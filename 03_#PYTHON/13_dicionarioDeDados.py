#Dicionarios



usuarios = {
    "chaves" : ["Cahves do 8", "24/12/2017", "Recep_01"],
    "quico" : ["Quico das flores", "01/01/2017", "Raiox_03"],

}



print(usuarios)

print(usuarios["chaves"])

print(usuarios)

#um registro
#adicionando no dicionario
usuarios["florinda"]  = ["Dona florinda", "24/01/2022", "TI_PC"]

print(usuarios)


print("###----###")
#Recupar valores
print(usuarios.get("quico"))

usuarios["chaves"] = ["outra info", "12"]

for chave in usuarios:
    print(usuarios.get(chave))