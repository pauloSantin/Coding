from teste import *

hello()
minhaLista=[]
print("Preenchendo")
preencherInventario(minhaLista)
print("Exibindo")
exibirInventario(minhaLista)

print("Pesquisando")
localizarPorNome(minhaLista)
print("Alterando")
depreciarPorNome(minhaLista, 20)


print("Excluindo")
print(excluirPorSerial(minhaLista))
exibirInventario(minhaLista)

print("Resumindo")
resumirValores(minhaLista)


"""
Python eh uma das principais e mais simples linguagem de programação.

Eh a queridinha da cibersegurança, muito usada na segurança da informação.

Python=automatização de processos, programas de testes, transmissão entre dispositivos IOT.

O Python eh multiparadigma, suporta vários tipos diferentes de códigos e de alto nível.
Utiliza váriaveis, que armazenam dados temporários dentro da memoria ram.

Variaveis: identificadores são os nomes para a catalogação. Segeum regras e padrões.

Dados tipo número: flutuantes x inteiros
Dados de tipo alfanumérico: menos perfomaticos.

Tomadas de decisão: são responsaveis por fazer q o código programavel, consiga executar comandos automaticamente e são classificadas: simples, compostas e encadeadas.

Laços de repetição: Automatização de repetições de linhas do código. While e For.

Lista: organização e localização. Uma estrutura q permite armazenar uma grnade quantidade de dados de forma organizada.

Função: Automatização de funcoes especificas de algum trecho de código

programar = automatizar 

"""