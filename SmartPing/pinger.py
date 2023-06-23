#!/usr/bin/python3.4

import sys
import time
from subprocess import Popen, PIPE

ip = sys.argv[1]  # Ip do equipamento
serial = sys.argv[5] # Serial


def zabbixSender(msg):
    process = Popen(['/usr/bin/zabbix_sender', '-z', '127.0.0.1', '-s', serial, '-k', 'smart.ping', '-o', msg], stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()


# Packets - 9
# Quantidade de pacotes (retries) ate o equipamento responder ao comando ping
if sys.argv[2].isdigit():
    packets = int(sys.argv[2])
else:
    zabbixSender('{"error": "Packet parameter must be an integer"}')
    exit()

# Intervalo entre os pings (pacotes) em SEGUNDOS - 20
if sys.argv[3].isdigit():
    interval = int(sys.argv[3])
else:
    zabbixSender('{"error": "Interval parameter must be an integer"}')
    exit()

# Timeout em SEGUNDOS - 60
if sys.argv[4].isdigit():
    timeout = int(sys.argv[4])
else:
    zabbixSender('{"error": "Timeout parameter must be an integer"}')
    exit()

# Checando protocolo Ipv4 ou Ipv6
if ':' in ip:
    ping = '/bin/ping6'
else:
    ping = '/bin/ping'


count = 0
sucess = False
err = ''

while count < packets:

    process = Popen([ping, ip, '-c1', '-W{}'.format(timeout)], stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()

    if stderr:
        error_output = stderr.decode("utf-8").strip()
        if 'taking countermeasures' in error_output:
            time.sleep(interval)
            continue
        else:
            err += error_output
            break

    output = stdout.decode("utf-8")

    if '1 received' in output:
        sucess = True
        break

    if count != packets - 1:
        time.sleep(interval)

    count = count + 1


if err: # Se algum erro foi encontrado
    zabbixSender('{"error": "' + err + '"}')
    exit()


packet_loss = '{0:.2f}'.format((count / packets * 100))

if sucess:
    zabbixSender('{"success": "1", "packet_loss": "' + str(packet_loss) + '"}')
else:
    zabbixSender('{"success": "0", "packet_loss": "' + str(packet_loss) + '"}')

