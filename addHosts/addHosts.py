import requests
import json
import csv 

# Zabbix API URL
url = 'http://localhost/zabbix/api_jsonrpc.php'

# Zabbix API credentials
username = 'robot'
password = 'zabbix@2023'

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

# Initialize an empty list to store the data
data_collection = []

# Open and read the CSV file
with open('hosts.csv', mode='r', newline='') as file:
    csv_reader = csv.DictReader(file)
    
    # Iterate through each row in the CSV file
    for row in csv_reader:
        data_collection.append(row)

# Authentication
response = requests.post(url, data=json.dumps(auth_payload), headers={'Content-Type': 'application/json'})
auth_result = json.loads(response.text)

if 'result' in auth_result:
	auth_token = auth_result['result']

	# Iterate through the list using a for loop
	for data_item in data_collection:
          hostname = data_item['Host']
          visible_name = data_item['Name']
          ip_address = data_item['IP']
          dns_name = data_item['DNS']
          host_group_names = data_item['Groups'].split('|')

          # Get the groupids for the specified host group names
          group_ids =[]
          for host_group_name in host_group_names:
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

response=requests.post(url, data=json.dumps(get_group_payload), headers={'Content-Type': 'application/json'})
group_result = json.loads(response.text)
		
if 'result' in group_result and group_result['result']:
                    group_ids.append(group_result['result'][0]['groupid'])
else:
                    print(f"Failed to find host group '{host_group_name}' for host '{hostname}'")

            # Create host using the host.create method with the groupids
create_host_payload = {
                'jsonrpc': '2.0',
                'method': 'host.create',
                'params': {
                    'host': hostname,
                    'name': visible_name,
                    'interfaces': [{
                        'type': 1,  # 1 = Agent
                        'main': 1,
                        'useip': 1,
                        'ip': ip_address,
                        'dns': dns_name,
                        'port': 10050,  # Agent port
                    }
		],
                    'groups': [{'groupid': group_id} for group_id in group_ids],
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
		#print(f"Failed to add host '{hostname}':")
		#print(response.text)
#else: 
#print(f"Failed to authenticate: {auth_result['error']['data']}")