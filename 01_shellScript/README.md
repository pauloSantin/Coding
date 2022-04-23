 ![hardest-programming-language](https://github.com/pauloSantin/Coding/blob/main/imgs/banner.png)





<p align="center">
<b><a href="#introdução">Introdução</a></b>
<b><a href="#shellscripting"></a></b>
<b><a href="#créditos">Créditos</a></b>
</p>

## Introdução

Welcome to my workshop. É aqui onde faço testes e estudos com linguagens, frameworks e ferramentas de programação.

Repository for workshop and lab about tech, just fun. :)

## SHELL SCRIPTING

Shell scripts can make your everyday task easier, predictable.

* Basics de shell scripting
* How to write script
* Take parameters
* Read Files
* Monitor process
* Interactive scripts
* Handle bad data

## 01_Basics de shell scripting

Ex:
```
#!/usr/bin/env bash
FILE=$0
USER_NAME=$1

echo Hello $USER_NAME
echo $(date)
echo $(pwd)
echo $FILE
exit 0
```
-------------------

**PARAMETERS**

- $0 - the name of the script, the path is included
- $1 - the first parameter 
- $2 - the second parameter
- $9 - the ninth parameter

-------------------

**WHAT YOU SHOULD KNOW**

- Linux computer with bash shell
- Second item you will need is a text editor
- Some command line experience
- Learning linux command line

-------------------

**touch** : touch command updates a file's timestamp if exists and if the file doesn´t exist creates it.
Ex: touch hello.sh

-------------------

**echo** : printing to the console
Ex: echo Hello, world

-------------------

**TO EXECUTE SCRIPT**

bash hello.sh

It opens our script and invokes the commands it.

-------------------

**CHMOD**

Why do I have to type bash in order to execute my script? 
Ex: bash hello.sh

The answer is because files by default don´t have the execute permission.

./hello.sh

bash: ./hello.sh: Permission denied

To make a file exceutable, we must use th change mode command.

chmod 755 hello.sh

This gives everyone the permission to read and execute the script, but only the owner permission to write it.

-------------------

**COMMENT**

It is a best practice to include comments in scripts which explain then
#COMMENT

-------------------

**THE SHEBANG**

Our script code is written specifically for the bash shell
```
#!/usr/bin/env bash
#!/usr/bin/bash
```
We want our script to run as we designed them.
We need to make sure that our script only runs on bash.
On the top of the page we insert a new line, every shell script should be begin with th interpreter line. (SHEBANG)
This line tells the system which command processor should handle this script. For bash is:
```
#!/usr/bin/env bash
#!/usr/bin/bash
```
Both will works, the shebang must be the first line of file 

## 02_How to write script

**CREATING AND USING VARIABLES**

Ex:
```
#!/usr/bin/env bash
FIRST_NAME=Bob
FAVORITE_COLOR=blue

echo Hello $FIRST_NAME, your favorite color is $FAVORITE_COLOR

exit 0

./greeting.sh
```
-------------------

Variable is created by putting a equal sign between a name on the left side and value on right side.

FIRST_NAME=Bob

Variable consists of letter and numbers and underscodes.

- Must begin with a letter or an underscore (Not a number)
- Any character except the first can be a number
- Are case sensitive
- Usually all uppercase, but that´s not mandatory, that´s just by tradition
- The value is anything that you can type, but uf ut has spaces it should be wrapprd in quotes

NAME="Nome completo"
DATANASC=22

Spaces are not allowed on either side of the equal sign.

## 03_Take parameters

**PASSING PARAMETER**

We can get input from user of our script via parameters.
Your script alwas receives parameters, even if it doesn't use them.

Bash passes them in via soma special symbols.

The first parameter, $0 is special in that it the path and name of the executing script.

- $0 - the name of the script, the path is included.
- $1 - the first parameter
- $2 - the second parameter
- $9 - the ninth parameter

Generally, we don't use parameters past $9s since the use of curly braces with parameter is only supported in newer versions of the bash shell.
Parameters make it possible to be interactive with user.

If for example to echo the user,s name, we could do this.

Ex:
```
touch 03_params.sh
chmod 755 03_params.sh
vi 03_params.sh

#!/usr/bin/env bash

echo Hello $1

exit 0

./03_params.sh MyName

MyName
```


Its generally considered a bad practice, to work directly with the parameter since theirs names have no meaning.

It is better to assign the parameter to a variable.
That way, the variable's name can give some meaning to it.


Ex:
```
touch 03_paramsCorrect.sh
chmod 755 03_paramsCorrect.sh
vi 03_paramsCorrect.sh

#!/usr/bin/env bash

USER_NAME=$1
echo Hello $USER_NAME

exit 0

./03_paramsCorrect.sh MyName

MyName
```

It is sometimes useful to know when something happend not just that it happened.
That is where the date command comes in handy.

```
touch 03_paramsCorrect.sh
chmod 755 03_paramsCorrect.sh
vi 03_paramsCorrect.sh

#!/usr/bin/env bash

USER_NAME=$1
echo Hello $USER_NAME
echo $(date) #date
echo $(pwd) #location

exit 0

./03_paramsCorrect.sh MyName

MyName
```

## 04_Read Files

## 05_Monitor process

## 06_Interactive scripts

## 07_Handle bad data




## Créditos

Copyright (C) 2022 by Paulo O. Santin:+1:



