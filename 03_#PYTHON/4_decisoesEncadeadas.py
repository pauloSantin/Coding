nome=input("Digite o nome.: ")

idade=int(input("Digite a idade.: "))

doenca_infectocontagiosa=input("Supeita de doença infectocontagiosa?").upper()

if(idade >= 65):
    print("O paciente " + nome + " POSSUI atendimento prioritário!")
elif(doenca_infectocontagiosa=="SIM"):
    print("O paciente " + nome + " deve ser direcionado para salda de espera reservada" )
else:
    print("O paciente " + nome + " NÃO possui atendimento prioritário!")
print("fim")