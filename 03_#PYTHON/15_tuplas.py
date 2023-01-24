#tuplas: estrutura de dados volatel, assim como dicionarios e listas , tupla é imutavel diferente do dic e listas 


usuarios = {} #dicionario

emails = ["xpto@xyz.com", "xkcd@phd.com"] #lista

tupla = list(enumerate(emails)) #tupla

#print(tupla)

for chave in range(0, len(tupla)):
    print("Email: ", tupla[chave][1])
    usuarios[tupla[chave]] = input("Digite o nome.:\n"), input("Digite o nivel.:\n")

for (chave, dado) in usuarios.items():
    print("Usuário.: ", chave[0])
    print("E-mail.: ", chave[1])
    print("Nome.: ", dado[0])
    print("Nível.: ", dado[1])

#tupla tmb eh muito usada quando queremos retornar mais de um valor de um metodo