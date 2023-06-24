#!/usr/bin/python3
import csv
import fileinput
import sys

file = open("/home/santin/replace/hosts","w")
file.close()

# open the file in read mode

filename = open('/home/santin/replace/endpoints.csv', 'r')
 
# creating dictreader object
file = csv.DictReader(filename)
 
# creating empty lists
ipv6 = []
 
# iterating over each row and append
# values to empty list
for col in file:
    ipv6.append(col['IPADDRV6'])
 
# printing lists
#print('ipv6:\n', ipv6)


#Write List to a File
with open(r'/home/santin/replace/endpoints.txt', 'w') as fp:
    for item in ipv6:
        # write each item on a new line
        if item != '':
            fp.write("%s\n" % item)
    print('Done')


try:
    # Using readlines()
    #topologyFile = open('/home/landisgyr/ip_routers/EndpointsFromTopologyRouters.txt', 'r')
    topologyFile = open('/home/santin/replace/endpoints.txt', 'r')
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
    hostFile = open('/home/santin/replace/hosts', 'r')
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
    with open("/home/santin/replace/hosts", "a") as myfile:
    #with open("C:/Users/santinpa/Desktop/AMAZONAS/hosts", "a") as myfile:
        for notFound in notFoundIps:
            myfile.writelines(notFound + "\t" + notFound[-9:].strip().replace(':','') + ".lg.net\n")
    myfile.close()

    #Remove the lines
    with open('/home/santin/replace/hosts', 'r') as fr:
    #with open('C:/Users/santinpa/Desktop/AMAZONAS/hosts', 'r') as fr:
        # reading line by line
        lines = fr.readlines()
        # pointer for position
        ptr = 1
        # opening in writing mode
        with open('/home/santin/replace/hosts', 'w') as fw:
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
