#!/usr/bin/python2.7

import fileinput
import sys

try:
    # Using readlines()
    #topologyFile = open('/home/landisgyr/ip_routers/EndpointsFromTopologyRouters.txt', 'r')
    topologyFile = open('C:/Users/santinpa/Desktop/AMAZONAS/EndpointsFromTopologyRouters.txt', 'r')
    topologyLines = topologyFile.readlines()
    topologyIps = []
    foundIps = []
    lineRemove = []
    notFoundIps = []

    count = 0
    for line in topologyLines:
        count += 1
        columns = line.split()
        if len(columns) > 0:
            ip = columns[0]
            topologyIps.append(ip.upper())
            
    #Reading hosts
    #hostFile = open('C:/Users/santinpa/Desktop/AMAZONAS/hosts', 'r')
    hostFile = open('/opt/tis/hosts', 'r')
    count = 0
    for hostLine in hostFile:
        count += 1
        for topologyIp in topologyIps:
                if hostLine.find(topologyIp[-9:].strip().upper()) >= 0:
                    columns = hostLine.split()
                    if len(columns) > 0:
                        hostIp = columns[0]
                        if hostIp.upper() == topologyIp.upper():
                            print("EQUAL " + hostIp)
                            foundIps.append(hostIp.upper())
                        else:
                            print("DIFFERENT " + "(" + hostIp + ")" + "(" + topologyIp +")")
                            lineRemove.append(count)
                            if topologyIp not in notFoundIps:
                                notFoundIps.append(topologyIp.upper())

    #Ips NotFound
    for topoIp in topologyIps:
        if topoIp not in foundIps:
            if topoIp not in notFoundIps:
                notFoundIps.append(topoIp.upper())

    for notFound in notFoundIps:
        print("NOT FOUND " + notFound + " " + notFound[-9:].strip().replace(':','') + ".lg.net")

    #Lines to remove
    for remove in lineRemove:
        print(remove)

    #Appending the ips not found
    with open("/opt/tis/hosts", "a") as myfile:
    #with open("C:/Users/santinpa/Desktop/AMAZONAS/hosts", "a") as myfile:
        for notFound in notFoundIps:
            myfile.writelines(notFound + "\t" + notFound[-9:].strip().replace(':','') + ".lg.net\n")
    myfile.close()

    #Remove the lines
    with open('/opt/tis/hosts', 'r') as fr:
    #with open('C:/Users/santinpa/Desktop/AMAZONAS/hosts', 'r') as fr:
        # reading line by line
        lines = fr.readlines()
        # pointer for position
        ptr = 1
        # opening in writing mode
        with open('/opt/tis/hosts', 'w') as fw:
        #with open('C:/Users/santinpa/Desktop/AMAZONAS/hosts', 'w') as fw:
            for line in lines:
                # we want to remove 5th line
                if ptr not in lineRemove:
                    fw.write(line)
                else:
                    print("Deleted")
                ptr += 1
except:
    print("Oops! something error")
