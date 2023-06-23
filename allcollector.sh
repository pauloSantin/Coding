#!/usr/bin/env bash

####################################################
#                                                  # 
# 						   #		
#     NOC - LANDIS-GYR                             #
#                                                  #
#     Descrição.: Coleta os dados de Rpltopology   #
#                                                  #
#     Version: 1.0, 2022, Paulo O.                 #
#                                                  #
#                                                  #
####################################################

touch /home/unirede/topology/#BEGIN2_COLLECTOR.log


data=`date +"%d_%b_%Y-%T"`

mv /home/unirede/topology/allcollector.csv /home/unirede/topology/"$data".csv

list_ip=(

fda0::1b6:0:0:8053:124b
fda0::191:0:0:8053:d93
fda0::19a:0:0:8053:d9f
fda0::197:0:0:8053:d98
fda0::195:0:0:8053:d95
#fda0::1b4:0:0:8053:123f #verificar senha
fda0::19c:0:0:8053:d9b
fda0::1b5:0:0:8053:1248
fda0::196:0:0:8053:d97
fda0::19b:0:0:8053:d9e
fda0::194:0:0:8053:d9a
fda0::1b7:0:0:8053:1249
fda0::192:0:0:8053:d9c
fda0::1b8:0:0:8053:1268
fda0::198:0:0:8053:d9d
fda0::193:0:0:8053:d94
fda0::1a9:0:0:8053:da0

)

#echo "INICIO N2450"

for i in "${list_ip[@]}"
do
   
    ping6 -c 1 "$i" > /dev/null
    if [ $? -eq 0 ]; then
	
#	echo "$data;$i; is up" >> allcollector.csv
 #   	echo "$i is up"
	/usr/bin/sshpass -p 'u%Px8exZf' ssh -q -o StrictHostKeyChecking=no far@"$i" 2>&1 'echo '$i' && echo "u%Px8exZf" | sudo -S cat /opt/iprf/tmp/rpltopology_graph.txt 2>&1' | paste -sd ';' >> /home/unirede/topology/allcollector.csv	
    else
    	echo "$i; is down;$data" >> /home/unirede/topology/allcollector.csv
  #  	echo "$i is down"
    fi              
done

list_ip2=(
fda0::1c4:0:0:8053:125a 
fda0::1c1:0:0:8053:1246
fda0::1c7:0:0:8053:1258
fda0::1c6:0:0:8053:125f #verificar arquivo
fda0::1b4:0:0:8053:123f 
fda0::1ba:0:0:8053:1247
fda0::1bf:0:0:8053:1267
fda0::1c0:0:0:8053:1243
fda0::1bd:0:0:8053:1259
)



#echo "INICIO N2450 ROOT"

for i in "${list_ip2[@]}"
do

    ping6 -c 1 "$i" > /dev/null
    if [ $? -eq 0 ]; then

#       echo "$data;$i; is up" >> allcollector.csv
   #     echo "$i is up"
        /usr/bin/sshpass -p 'u%Px8exZf' ssh -q -o StrictHostKeyChecking=no root@"$i" 2>&1 'echo '$i' && echo "u%Px8exZf" | sudo -S cat /opt/iprf/tmp/rpltopology_graph.txt 2>&1' | paste -sd ';' >> /home/unirede/topology/allcollector.csv
    else
        echo "$i; is down;$data" >> /home/unirede/topology/allcollector.csv
    #    echo "$i is down"
    fi
done


##############################################
#
# 6500
#############################################

list_ip3=(

fda0::43:0:0:642d:4be0
fda0::3f:0:0:6440:e59c
fda0::8e:0:0:6440:6f4f
fda0::4d:0:0:642b:9146
fda0::4e:0:0:642b:a15b
fda0::150:0:0:642f:18d9
fda0::16a:0:0:642f:18db # verificar senha padrao
fda0::147:0:0:641b:271e
fda0::148:0:0:641b:3d9c
fda0::149:0:0:6440:9496
fda0::14a:0:0:642b:d1cd
fda0::ab:0:0:642f:18ea
fda0::ac:0:0:642f:18c7
fda0::19e:0:0:641b:4fca
fda0::137:0:0:6419:8b2a
fda0::136:0:0:6419:8b14
fda0::19f:0:0:642c:1e22
fda0::c5:0:0:642b:d1a0
fda0::c8:0:0:642d:471e
fda0::c7:0:0:642d:46fc
fda0::c6:0:0:642b:d317
fda0::160:0:0:6419:8ae3
fda0::15f:0:0:6419:8b29
fda0::3a:0:0:6440:8adf
fda0::b2:0:0:6440:8e5e
fda0::b3:0:0:6440:8e68
fda0::d5:0:0:642c:f7e2
fda0::99:0:0:642f:48bd
fda0::d7:0:0:6440:d91e
fda0::161:0:0:6419:8ad8
fda0::2f:0:0:642b:916c
fda0::af:0:0:6440:8e81
fda0::b0:0:0:6440:949f
fda0::111:0:0:6419:8b11
fda0::14d:0:0:6419:8b1e
fda0::14b:0:0:6419:8b2f
fda0::14c:0:0:6419:8b07
fda0::45:0:0:642d:4717
fda0::97:0:0:6440:83f4
fda0::d8:0:0:6440:d923
fda0::36:0:0:642b:912a
fda0::8b:0:0:642d:46f2
fda0::21:0:0:642b:a5b3
fda0::6a:0:0:642b:a16d
fda0::17a:0:0:641b:3db5
fda0::fa:0:0:6441:9cf3
fda0::f9:0:0:6440:8ae4
fda0::f8:0:0:6440:8e4e
fda0::f7:0:0:6440:56cf
#fda0::106:0:0:6440:e0cb #esse esta apresentando problema ssh 
fda0::11e:0:0:6440:83db
fda0::ce:0:0:642c:23cb
fda0::cd:0:0:6440:8e55
fda0::15:0:0:642a:104a
fda0::72:0:0:642f:520e
fda0::44:0:0:6441:9ce1
fda0::98:0:0:6440:d911
fda0::41:0:0:642d:7aee
fda0::a2:0:0:6440:8e7a
fda0::dc:0:0:6440:d965
fda0::dd:0:0:6440:d924
fda0::151:0:0:641b:26d0
fda0::152:0:0:6440:bfca
fda0::aa:0:0:6440:4c1c
fda0::a9:0:0:642c:53ed
fda0::20:0:0:642b:a169
fda0::90:0:0:6440:d966
fda0::f2:0:0:6440:83d7
fda0::a1:0:0:6440:4591
fda0::128:0:0:641b:3d9b
fda0::cb:0:0:642e:577c
fda0::cc:0:0:642d:4724
fda0::d0:0:0:6440:94a0
fda0::55:0:0:642d:4bf0
fda0::89:0:0:642c:ef7d
fda0::88:0:0:6441:9efe
fda0::87:0:0:6440:7e8c
fda0::23:0:0:642b:a16c
fda0::94:0:0:6440:8e73
fda0::95:0:0:6440:9494
fda0::166:0:0:641a:750
fda0::165:0:0:6419:8b01
fda0::4c:0:0:642d:7b1e
fda0::12f:0:0:6416:e94e
fda0::130:0:0:641a:752
fda0::121:0:0:642c:ef82
fda0::127:0:0:641b:3d9e
fda0::3:0:0:642a:108d
fda0::6b:0:0:642d:7b1a
fda0::11f:0:0:641b:2741
fda0::17d:0:0:641b:3da6
fda0::1f:0:0:642b:9128
fda0::78:0:0:642b:a56b
fda0::134:0:0:6419:8b16
fda0::17c:0:0:641b:2725
fda0::a7:0:0:6440:459a
fda0::a8:0:0:6440:5872
fda0::10a:0:0:6449:21b7
fda0::42:0:0:642b:a171
fda0::68:0:0:6440:e585
fda0::eb:0:0:6440:83cf
fda0::186:0:0:6419:8b19
fda0::129:0:0:642f:18f2
fda0::143:0:0:641a:1186
fda0::39:0:0:642b:912c
fda0::d9:0:0:642b:e119
fda0::57:0:0:642b:a57e
fda0::146:0:0:6419:8b0d
fda0::14:0:0:642b:a147
fda0::7d:0:0:642f:18c4
fda0::f1:0:0:6440:d92d
fda0::47:0:0:6440:587d
fda0::9f:0:0:6440:7e78
fda0::46:0:0:6441:9f0f
fda0::93:0:0:642c:1e18
fda0::e6:0:0:642c:f800
fda0::33:0:0:642b:a5df
fda0::a5:0:0:642d:46ca
fda0::ea:0:0:642d:46eb
fda0::162:0:0:6419:8aef
fda0::2e:0:0:642d:4731
fda0::109:0:0:6449:21b3
fda0::1a5:0:0:6419:8af3
fda0::1a6:0:0:641a:0748
fda0::2d:0:0:642d:4bfa
fda0::15c:0:0:642e:575d
fda0::3d:0:0:6440:7e99
fda0::b7:0:0:6440:8e51
fda0::b6:0:0:642f:190d
fda0::d6:0:0:6441:9f23
fda0::10:0:0:642b:e560
fda0::124:0:0:641b:26cb
fda0::17b:0:0:641b:4fc8
fda0::2a:0:0:642b:a16e
fda0::8d:0:0:642c:ef7f
fda0::e2:0:0:642d:46fa
fda0::e5:0:0:6440:5878
fda0::e3:0:0:642f:18bd
fda0::12c:0:0:6416:e960
fda0::25:0:0:642b:e55e
fda0::26:0:0:642b:e57f
fda0::91:0:0:6440:8e7f
fda0::92:0:0:6440:8e4d
fda0::11a:0:0:642b:d1b5
fda0::11b:0:0:6449:21f0
fda0::11c:0:0:6440:e594
fda0::133:0:0:6419:8acb
fda0::31:0:0:642d:46ef
fda0::9d:0:0:6440:8b02
fda0::9c:0:0:6442:e7f2
fda0::140:0:0:641a:760
fda0::116:0:0:641b:26c3
fda0::81:0:0:642c:1e09
fda0::ef:0:0:642f:18ba
fda0::f0:0:0:642d:43b0
fda0::172:0:0:641b:4fdf
fda0::188:0:0:6419:8aee
fda0::18f:0:0:6416:e936
fda0::1b1:0:0:6419:8aec
fda0::1ad:0:0:641a:709
fda0::52:0:0:642b:a58a
fda0::19d:0:0:642f:190e
fda0::139:0:0:641a:751
fda0::138:0:0:6419:8b15
fda0::107:0:0:6440:e612
fda0::10c:0:0:6449:21b5
fda0::174:0:0:641a:72a
fda0::173:0:0:6419:8af5
fda0::e1:0:0:642c:f7e3
fda0::e0:0:0:6440:e586
fda0::131:0:0:6419:8b2e
fda0::163:0:0:641a:753
fda0::8f:0:0:642d:471c
fda0::155:0:0:6419:eaaf
fda0::154:0:0:6419:8b20
fda0::156:0:0:641a:6fa
fda0::1a:0:0:642b:a143
fda0::71:0:0:6440:9499
fda0::1d:0:0:642b:a157
fda0::12a:0:0:6419:8af4
fda0::157:0:0:641a:71c
fda0::158:0:0:6419:eaca
fda0::ad:0:0:6440:5891
fda0::ae:0:0:6440:e599
fda0::17:0:0:642b:e565
fda0::180:0:0:641b:5000
fda0::170:0:0:6419:8b6d
fda0::171:0:0:641a:716
fda0::bf:0:0:6440:2a6e
fda0::be:0:0:642f:1907
fda0::4b:0:0:642c:ef7a
fda0::9a:0:0:6440:4597
fda0::24:0:0:642b:a166
fda0::48:0:0:642d:472d
fda0::a0:0:0:642e:5754
fda0::183:0:0:6419:8af8
fda0::e8:0:0:6440:d91d
fda0::167:0:0:642d:4730
fda0::16b:0:0:6419:8b1d
fda0::169:0:0:641a:1172
fda0::168:0:0:6419:8b10
fda0::1af:0:0:642e:5778
fda0::1ac:0:0:6440:5874
fda0::b8:0:0:642f:18d7
fda0::b9:0:0:6440:94a2
fda0::18a:0:0:641a:1148
fda0::199:0:0:641a:116e
fda0::126:0:0:641b:3da7
fda0::125:0:0:641b:3da5
fda0::5c:0:0:642d:4bef
fda0::5b:0:0:642b:d1a4
fda0::5a:0:0:642f:f2d0
fda0::18c:0:0:641a:1175
fda0::2c:0:0:642d:4bd3
fda0::85:0:0:6441:9cd1
fda0::86:0:0:6442:e6b8
fda0::145:0:0:6419:8b33
fda0::144:0:0:6419:8af6
fda0::13:0:0:642b:e545
fda0::63:0:0:642b:e121
fda0::64:0:0:642d:56a
fda0::1b:0:0:642b:a172
fda0::182:0:0:6419:8ad0
fda0::189:0:0:6419:8ae1
fda0::18d:0:0:6419:8b30
fda0::1c:0:0:642b:a165
fda0::74:0:0:6440:8afd
fda0::34:0:0:6428:64f3
fda0::75:0:0:642c:53e8
fda0::4f:0:0:642d:7af8
fda0::d1:0:0:6440:e581
fda0::f4:0:0:642b:a155
fda0::fd:0:0:642b:d1b9
fda0::ff:0:0:6440:bfbf
fda0::135:0:0:6416:e95b
fda0::13f:0:0:6419:8adf #estava apresentando problemas ssh
fda0::c1:0:0:642f:18e3
fda0::118:0:0:642f:18d5
fda0::119:0:0:642f:18c8
fda0::bd:0:0:642c:f7f3
fda0::ba:0:0:642f:4896
fda0::bc:0:0:6440:8e57
fda0::1a4:0:0:641a:762
fda0::5:0:0:642a:1093
fda0::76:0:0:642f:18c2
fda0::29:0:0:642b:911f
fda0::8a:0:0:642d:43d5
fda0::132:0:0:6419:8ae6
fda0::164:0:0:641a:1127
fda0::3c:0:0:6440:744
fda0::122:0:0:641b:26cc
fda0::16c:0:0:6419:8afd
fda0::16d:0:0:641a:770
fda0::11:0:0:642a:fea
fda0::66:0:0:6440:d91a
fda0::65:0:0:642c:d7e5
fda0::d3:0:0:6440:94a4
fda0::16:0:0:642b:a14f
fda0::7f:0:0:6441:9f2c
fda0::80:0:0:6440:d915
fda0::7e:0:0:6442:da98
fda0::13d:0:0:6419:eabf
fda0::13e:0:0:641a:6fd
fda0::ed:0:0:642d:46f5
fda0::ec:0:0:642d:43cf
fda0::ee:0:0:642d:46e9
fda0::1b2:0:0:642c:1e1a
fda0::1b0:0:0:6419:9566
fda0::69:0:0:642d:73c9
fda0::10e:0:0:6440:e0cc
fda0::176:0:0:641b:26c0
fda0::175:0:0:641b:4fe2
fda0::28:0:0:642b:2293
fda0::84:0:0:6441:9f22
fda0::12d:0:0:641a:745
fda0::12e:0:0:6419:9568
fda0::13c:0:0:641a:738
fda0::13a:0:0:6419:8b23
fda0::13b:0:0:641a:113a
fda0::b4:0:0:642e:5755
fda0::b5:0:0:6440:83f1
fda0::d4:0:0:6440:8e77
fda0::123:0:0:641b:2724
fda0::1ab:0:0:6440:e58f
fda0::1a7:0:0:641a:764
fda0::114:0:0:642f:18c6
fda0::113:0:0:6440:d96d
fda0::37:0:0:642d:4bfc
fda0::c2:0:0:642f:1d52
fda0::120:0:0:6419:8b22
fda0::179:0:0:641b:4fd0
fda0::22:0:0:642d:7b1b
fda0::da:0:0:642c:f7fc
fda0::17f:0:0:641b:3dab
fda0::17e:0:0:641a:118b
fda0::59:0:0:642d:46e3
fda0::58:0:0:642f:191e
fda0::5f:0:0:642d:49a6
fda0::60:0:0:642d:470b
fda0::32:0:0:6427:8999
fda0::a6:0:0:642b:cc54
fda0::db:0:0:6440:e57d
fda0::e9:0:0:642d:4714
fda0::1ae:0:0:641a:1160
fda0::54:0:0:642d:7b21
fda0::e7:0:0:642c:d7e0
fda0::153:0:0:6440:5875
fda0::ca:0:0:6440:e611
fda0::c9:0:0:642f:520b
fda0::d2:0:0:6440:5887
fda0::de:0:0:642f:1919
fda0::df:0:0:642b:cc44
fda0::61:0:0:642c:d813
fda0::62:0:0:642d:46ee
fda0::100:0:0:6440:d96f
fda0::c4:0:0:642d:470d
fda0::181:0:0:641a:739
fda0::5e:0:0:642d:4bd9
fda0::5d:0:0:642a:101d
fda0::19:0:0:642d:46e6
fda0::190:0:0:6416:e935
fda0::7b:0:0:642c:d7fd
fda0::cf:0:0:6440:7ce8
fda0::12b:0:0:641a:731
fda0::187:0:0:641a:1168
fda0::6c:0:0:6440:83da
fda0::117:0:0:641b:4534
fda0::16f:0:0:6419:8b1f
fda0::16e:0:0:6419:8ae4
fda0::38:0:0:642d:4706
fda0::f6:0:0:642b:d1c3

)


#data=`date +"%d/%m/%Y"`

#echo "INICIO 6500"

for i in "${list_ip3[@]}"
do
   
    ping6 -c 1 "$i" > /dev/null
    if [ $? -eq 0 ]; then
	
#	echo "$data;$i; is up" >> allcollector.csv
    #	echo "$i is up"
	/usr/bin/sshpass -p '#!2019L#>t' ssh -q -o StrictHostKeyChecking=no far@"$i" 2>&1 'echo '$i' && echo "#!2019L#>t" | sudo -S cat /opt/iprf/tmp/rpltopology_graph.txt 2>&1' | paste -sd ';' >> /home/unirede/topology/allcollector.csv	
    else
    	echo "$i; is down;$data" >> /home/unirede/topology/allcollector.csv
    #	echo "$i is down"
    fi              
done
#echo "FIM C6500"


touch /home/unirede/topology/#END_COLLECTOR.log 
/bin/sh /home/unirede/topology/all/findall.sh
#finalizou
