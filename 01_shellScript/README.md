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

./03_paramsCorrect.sh MyName

MyName
```

And final thing is if a script executes without error. It should return a zero to the system.
We currently aren't returning anything in particular to the system.
We can see what got returned from the system by just doing an echo dollar sign question mark(echo $?)

echo $?

And that will show us the last exit code that the system received. So in this case, we are actually returning a zero.

```
#!/usr/bin/env bash

USER_NAME=$1
echo Hello $USER_NAME
echo $(date)
echo $(pwd)

exit 0

```

And zero means sucess, anything other than zero means that there was some sort of an issue.
The exit codes go from 0 to 255

```
echo $?
```
It returns the last thing returned to the system.

**CHALLENGE 01**

- Create a script named sport.sh
- Make it executable
- Accept two parameters a name and a favorite sport
- Display any sentence to the console using those inputs.

**SOLUTION**: 03_challenge01.sh

-------------------

**THE IF STATEMENT**

Writing code in a straigh line, where one line always executes after the next can't take us very far.
In order to write useful scripts, we need the ability to make decisions.

```
if [ $COLOR = "blue"]
then
   echo "The color is blue"
fi

```
The if statement allows us to do that. The basis form of the if statement is if - then - fi
If is a test to see if an expression is true. If it is true, then thee commands between the then and the fi are executed.

Fi sounds funny but has no deep meaning. It is simply backwards and denotes the end of if statement.

Ex:
```
touch if.sh
chmod 755 if.sh
vi if.sh

#!/usr/bin/env bash

COLOR=$1
if [ $COLOR="blue"]
then
    echo "The color is blue"
fi

USER_GUESS=$2
COMPUTER=50

if [ $USER_GUESS -lt $COMPUTER]
then
     echo "Your are to low"
fi

```

We have a lot more options when we´re comparing two numbers.

- eq  (if equal)
- ne  (if not equal)
- lt  (if less than)
- gt  (if greater than)
- le  (if less than or equal)
- ge  (if greater than or equal)

So we have a lot more compares when use boolean values.

**THE ELSE CLAUSE**

Sometimes you'd like to do one thing if the expressession is true and something else if it is false.
That is where the else clause comes in.
If the expression is false then the commands following the else. Up to the fi are executed. And if it is true, it executes the commands in between the and the else.
So, let's go ahead and add the else to our script.

```
touch if_else.sh
chmod 755 if_else.sh
vi if_else.sh

#!/usr/bin/env bash

COLOR=$1
if [ $COLOR="blue" ]
then
    echo "The color is blue"
else
    echo "The color is NOT blue
fi

USER_GUESS=$2
COMPUTER=50

if [ $USER_GUESS -lt $COMPUTER ]
then
     echo "Your are to low"
else
     echo "You are equal or too"
fi
```

**THE ELIF ELSE**
There is still one more variation of the if we need to discuss.
The elif which is an abbreviation of else if. It allows us to check a different expression than the one use the in if. Elif must come before the else

```

touch if_elif_else.sh
chmod 755 if_elif_else.sh
vi if_elif_else.sh

#!/usr/bin/env bash

USER_GUESS=$1
COMPUTER=50

if [ $USER_GUESS -lt $COMPUTER ]
then
     echo "Your are to low"
elif [ $USER_GUESS -gt $COMPUTER ]
then
     echo "You are equal hight"
else
     echo "You guessed it."
fi

```

-------------------
**THE WHILE LOOP**
**THE FOR LOOP**
**USING BREAK AND CONTINUE**


## 04_Read Files

## 05_Monitor process

## 06_Interactive scripts

## 07_Handle bad data




## Créditos

Copyright (C) 2022 by Paulo O. Santin:+1:



