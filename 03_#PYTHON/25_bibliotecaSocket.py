import socket

resp = "S"

while(resp=="S"):
    url=input("Digite uma url: ")
    ip=socket.gethostbyname(url)
    print("O ip referente a url informada eh: ", ip)
    resp = input("Digite <s> para continuar.:").upper()