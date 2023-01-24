"""
from teste import perguntar
from teste import inserir
from teste import listar
from teste import salvar
"""

from teste import *

usuarios = {}

opcao = perguntar()

while opcao == "I" or opcao == "P" or opcao == "E" or opcao == "L":
    if opcao=="I":
        inserir(usuarios)
        
    opcao = perguntar()
"""
chave=input("Digite o login: ").upper()
nome=input("Digite o nome: ").upper()
data=input("Digite a última data de acesso: ")
estacao=input("Qual a ultima estacao acessada: ").upper()
usuarios[chave] = [nome, data, estacao]
otimizado abaixo
"""
        #usuarios[input("Digite o login: ").upper()] = [input("Digite o nome: ").upper(), input("Digite a última data de acesso: "), input("Qual a ultima estacao acessada: ").upper()]

        
        

    #elif opcao=="L":
        
        #listar(usuarios)
    

print(usuarios)



#metodos Adicionais Dicionarios: 
  #  -items

"""
    items
    key
    values
    clear - limpar dicionario
    popitem


"""

print(usuarios.items)
print(usuarios.values)
print(usuarios.keys)
