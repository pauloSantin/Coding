import requests
import json
import csv 

# Zabbix API URL
url = 'http://localhost/zabbix/api_jsonrpc.php'

# Zabbix API credentials
username = 'robot'
password = 'zabbix@2023'

def get_token_zabbix(url, username, password):
    # Authenticate with the Zabbix API
    auth_payload = {
        'jsonrpc': '2.0',
        'method': 'user.login',
        'params': {
            'user': username,
            'password': password,
        },
        'id': 1,
    }
    response = requests.post(url, data=json.dumps(auth_payload), headers={'Content-Type': 'application/json'})
    auth_result = json.loads(response.text)
    if 'result' in auth_result:
        auth_token = auth_result['result']
    else:
        print(f"Failed to authenticate: {auth_result['error']['data']}")
    return auth_token

def get_data_csv(filename):
    # Initialize an empty list to store the data
    data = []
    # Open the CSV file
    with open(filename, 'r') as file:
        # Create a CSV reader
        csv_reader = csv.reader(file, skipinitialspace=True)

        # Skip the header row
        next(csv_reader)

        # Read the data and store it in the list
        for row in csv_reader:
            data.append(row)

    # Close the CSV file
    file.close()
    return data

def get_group_id_zabbix(url, auth_token, host_group_name):
    # Get the groupid for the specified host group name
    get_group_payload = {
        'jsonrpc': '2.0',
        'method': 'hostgroup.get',
        'params': {
            'filter': {
                'name': host_group_name
            }
        },
        'auth': auth_token,
        'id': 3,
    }

    response = requests.post(url, data=json.dumps(get_group_payload), headers={'Content-Type': 'application/json'})
    group_result = json.loads(response.text)
    group_id = ''

    if 'result' in group_result and group_result['result']:
        group_id = group_result['result'][0]['groupid']
    else:
       print(f"Failed to find host group '{host_group_name}'")
    return group_id

def create_host_zabbix(url, auth_token, hostname, visible_name, ip_address, dns_name, group_ids, inventory_data, template_ids):
    # Create host using the host.create method with the groupid
    create_host_payload = {
        'jsonrpc': '2.0',
        'method': 'host.create',
        'params': {
            'host': hostname,
            'name': visible_name,
            'interfaces': [
            {
                'type': 1,  # Agent
                'main': 1,
                'useip': 0,
                'ip': ip_address,
                'dns': dns_name,
                'port': '0',
            },
            {
                'type': 2,  # SMNP
                'main': 1,
                'useip': 0,  # Use DNS
                'ip': ip_address,     # Leave blank when using DNS
                'dns': dns_name,  # Specify the DNS name
                'port': '161',
                    "details": {
                    "version": 2,
                    "bulk": 1,
                    #"securityname": "mysecurityname",
                    #"contextname": "",
                    #"securitylevel": 1,
                    "community": "{$SNMP_COMMUNITY}"
                }
            }],
            #'groups': [{'groupid': group_id}],  # Use groupid instead of name
            'groups': [{'groupid': group_id} for group_id in group_ids],
            'inventory_mode': 1,  # Update mode
            'inventory': inventory_data,
            'tags': [{ 'tag':'Cliente','value':'LIGHT'}],
            'templates': [{'templateid': template_id} for template_id in template_ids],
            #'proxy_hostid': '11035'
        },
        'auth': auth_token,
        'id': 2,
    }

    response = requests.post(url, data=json.dumps(create_host_payload), headers={'Content-Type': 'application/json'})
    result = json.loads(response.text)
    if 'result' in result:
        print(f"Host '{hostname}' added successfully.")
    else:
        print(f"Failed to add host '{hostname}': {result['error']['data']}")

servers_raw = get_data_csv('hosts.csv')

auth_token = get_token_zabbix(url, username, password)

print(servers_raw)

for data in servers_raw:
    hostname, visible_name, ip_address, dns_name, host_group_name, type_full, name, alias, serialno_a, serialno_b, tag, asset_tag, location_lat, location_lon, template = data
    
    #Multi Groups
    host_group_names = host_group_name.split('|')
    groups_ids = []
    for group_name in host_group_names:
        group_id = get_group_id_zabbix(url, auth_token, group_name)
        groups_ids.append(group_id)

    #Inventory Fields
    #type_full|name|alias|serialno_a|serialno_b|tag|asset_tag|location_lat|location_lon
    #inventory_itens = inventory.split('|')
    inventory_data = {
        'type_full': type_full,
        'name': name,
        'alias': alias,
        'serialno_a': serialno_a,
        'serialno_b': serialno_b,
        'tag': tag,
        'asset_tag': asset_tag,
        'location_lat': location_lat,
        'location_lon': location_lon
    }

    #Templates
    templates = template.split('|')
    template_ids = []
    for template in templates:
        template_id = template
        template_ids.append(template_id)

    create_host_zabbix(url, auth_token, hostname, visible_name, ip_address, dns_name, groups_ids, inventory_data, template_ids)
    print(data)

    
