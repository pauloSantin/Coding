#tras todo o conteudo

with open("C:/Users/santinpa/Desktop/03_#PYTHON/arquivo.txt", "r") as arquivo:
    conteudo = arquivo.read()
    print(conteudo)




#tras todo por linha

with open("C:/Users/santinpa/Desktop/03_#PYTHON/arquivo.txt", "r") as arquivo:
    for linha in arquivo.readlines():
        print(linha)
