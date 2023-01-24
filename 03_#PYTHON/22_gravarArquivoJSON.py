import json


dicionario = {
    "CHAVES" : ["CAHVES DO 8", "14/04/207", "RECEP_01"],
    "QUICO" : ["QUICO", "24/04/207", "RAIXO"],
    "FLORINDA" : ["DONA FLORINDA" , "18/08/2017" ,"RECEP_03"]
}

print(dicionario)

with open("bd1.json", "w") as json.file:
    json.dump(dicionario, json.file)