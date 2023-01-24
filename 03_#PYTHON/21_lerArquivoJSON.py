import json

with open("c:/Users/santinpa/Desktop/03_#PYTHON/bd.json", "r") as arq:
    dic = json.load(arq)
    print(dic)
    for chave, dados in dic.items():
        print(chave + " | " + str(dados))




Datas = """{"name":"Rob","age":35}"""

data = json.loads(Datas)
print(data)