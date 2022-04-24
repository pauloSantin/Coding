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