tabuada=int(input("Digite um número para exibir a tabuaba"))
print("tabuada do número ", tabuada)

for valor in range(1, 11, 1): #inicio, fim, de qto a qto
    print(str(tabuada) + " x " + str(valor) + " = " + str(tabuada*valor))