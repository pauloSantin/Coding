import platform
import getpass
from datetime import datetime

print("Nome máquina.:..........", platform.node())
print("Arquitetura.:...........", platform.architecture())
print("Sistema Operacional.:..........", platform.system())
print("Versão SO.:..........", platform.release())
print("Processador.:..........", platform.processor())
print("Versão Python.:..........", platform.python_version())

print(datetime.now().year)
print(datetime.now().hour)
print(datetime.now().day)


print(getpass.getuser())
print(getpass.getpass("Digite uma senha:..."))