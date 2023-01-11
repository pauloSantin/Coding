nome = input("Digite um funcionário.: ")
empresa = input("Digite a instituição.: ")

qtd_funcionarios = int(input("Digite a qtd de funcionários.: "))
mediaMensalidade=float(input("Digite média da mensalidade.: "))

print(nome + " trabalha na empresa " + empresa)
print("Possui: ", qtd_funcionarios, " funcionários.")
print("A média da mensalidade eh de.: " + str(mediaMensalidade))

print("===================Veritique os tipos de dados abaixo==================")
print("O tipo de dada da variavel [nome] é.: ", type(nome))
print("O tipo de dada da variavel [empresa] é.: ", type(empresa))
print("O tipo de dada da variavel [qtde_funcionarios] é.: ", type(qtd_funcionarios))
print("O tipo de dada da variavel [mediaMensalidade] é.: ", type(mediaMensalidade))

