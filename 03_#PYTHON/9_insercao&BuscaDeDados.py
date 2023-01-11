equipamentos = []
valores = []
seriais = []
departamentos = []

resposta = "S"

while resposta == "S":
    equipamentos.append(input("Equipamento.: "))
    valores.append(float(input("Valor.: ")))
    seriais.append(int(input("Numero serial.: ")))
    departamentos.append(input("Departamento.: "))
    resposta = input("Digite \"S\" para continuar.: ").upper()


busca=input("\nDigite o nome do equipamento que deseja buscar.: ") #busca do nome absoluto
"""
for indice in range(0, len(equipamentos)):

    if(busca == equipamentos[indice]):
        print("\nEquipamento.: ", (indice+1))
        print("Nome..........: ", equipamentos[indice])
        print("Valor.........: ", valores[indice])
        print("Serial........: ", seriais[indice])
        print("Departamento..: ", departamentos[indice])
"""
for indice in range(0, len(equipamentos)):
    
    if(busca == equipamentos[indice]):
        print("\nEquipamento.: ", (indice+1))
        print("Nome..........: ", equipamentos[indice])
        print("Valor.........: ", valores[indice])
        print("Serial........: ", seriais[indice])
        print("Departamento..: ", departamentos[indice])
    else:
        print("Não encontrado!")