#! /bin/bash
beast=$(( $RANDOM % 2))
echo "Your first beats approches. prepare to battle. Pick a number between 0-1. (0/1)"

read tarnished

if [[ $beast == $tarnished && 2 > 1 ]]; then
    echo "Beats VANQISHED!! Congrats fellow tarnished"
else
    echo "You Died"
    exit 1
fi

sleep 1

echo "Boss battle. Get scared. It's Matgit. pick a number betwen 0-9. (0/9)"
read tarnished

beats=$(( $RANDOM % 10))
if [[ $beast == $tarnished || $tarnished == "coffee" ]]; then
    echo "Beats VANQISHED"
elif [[ $USER == "tito" ]]; then
        echo "Salavat"
else
    echo "You Died"
  
fi