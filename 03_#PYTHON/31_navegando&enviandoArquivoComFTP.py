from ftplib import *

ftp = FTP('ftp.ibiblio.org')
print(ftp.getwelcome())

usuario=input("Digite o usuario")

senha=input("Digite a senha:")

ftp.login(usuario,senha)

print("Diretorio atual.: ", ftp.pwd())

ftp.cwd('pub') #mudar para diretório pub
 
print("Diretório corrente: ", ftp.pwd())

print(ftp.retrlines('LIST')) #listar todos os arquivos

ftp.quit()