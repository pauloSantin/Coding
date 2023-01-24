# https://archive.ics.uci.edu/ml/machine-learning-databases/iris/ 
#  baixar um dataset
basedados = []

with open ("iris.data", "r") as arquivo:  
    for registro in arquivo.readlines():
        basedados.append(registro.split(","))

print(basedados[0])
print(basedados[0][0])

print(float(basedados[0][0]) + float(basedados[0][1]))