arquivo = open("C:/Users/santinpa/Desktop/03_#PYTHON/arquivo.txt", "w")  # r - read, w - write, a - append, x - exclusivo, r+w, w+x

arquivo.write("Meu primeiro arquivo.!!!")

arquivo.close()



#forma resumida, não precisa fechar?!

with open("C:/Users/santinpa/Desktop/03_#PYTHON/arquivo.txt", "a") as arquivo:
    arquivo.write("\nTESTE")