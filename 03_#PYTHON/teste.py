def hello():
    print("Hello")

print("hello World")


def preencherInventario(lista):
    resp="S"

    while resp == "S":
        equipamento=[input("Equipamento.:"),
                    float(input("valor: ")),
                    int(input("Número serial: ")),
                    input("Departamento:")]

        lista.append(equipamento)
        resp = input("Digite \"S\" para continuar: ").upper()
    #
#

def exibirInventario(lista):
    for elemento in lista:
            print("Nome.............", elemento[0])
            print("Valor............", elemento[1])
            print("Serial...........", elemento[2])
            print("Departamento.....", elemento[3])
#

def localizarPorNome(lista):
    busca=input("\nDigite o nome do equipamento que deseja buscar.: ")
    for elemento in lista:
        if(busca==elemento[0]):
            print("valor.: ", elemento[1])
            print("Serial.: ", elemento[2])
#

def depreciarPorNome(lista, porc):
    depreciacao=input("\nDigite o serial do equipametnto que será excluído.:")
    for elemento in lista:
        if depreciacao==elemento[0]:
            print("Valor antigo", elemento[1])
            elemento[1] = elemento[1] * (1-porc/100)
            print("Novo valor.:", elemento[1])
        #
    #
#

def excluirPorSerial(lista):
    serial=int(input("\nDigite o serial do equipamento que será excluido.: "))
    for elemento in lista:
        if elemento[2] == serial:
            lista.remove(elemento)
    return "Itens excluidos."
#

def resumirValores(lista):
    valores = []
    for elemento in lista:
        valores.append(elemento[1])    
    if len(valores)>0:
        print("O equipamento mais caro custa", max(valores))
        print("O equipamento mais barato custa", min(valores))
        print("O total de equipamentos é de ", sum(valores))
    #
#


def perguntar():
        return input("O que deseja realizar?\n"+ 
                "   <I> - Para Inserir um usuário\n"+
                "   <P> - Para Pesquisar um usuário\n"+
                "   <E> - Para Excluir um usuário\n"+
                "   <L> - Para Listar um usuário: ").upper()
#

def inserir(dicionario):
        dicionario[input("Digite o login: ").upper()] = [input("Digite o nome: ").upper(), input("Digite a última data de acesso: "), input("Qual a ultima estacao acessada: ").upper()]
        salvar(dicionario)
# nao precisa de return

def listar(usuarios):
    for registro in usuarios:
        print(usuarios[registro])


def salvar(dicionario):  
    with open("C:/Users/santinpa/Desktop/03_#PYTHON/bancoDeDados.txt", "a") as arquivo:
        for chave, valor in dicionario.items():
            arquivo.write(chave + ":" + str(valor))



# https://archive.ics.uci.edu/ml/machine-learning-databases/iris/ 
#  baixar um dataset