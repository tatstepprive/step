#!/bin/bash
echo "[INFO] creating pass"
W1=$(grep -vP "[\x80-\xFF\x27]" /usr/share/dict/american-english | sort -R | head -n1| cut -c 1-6)
W2=$(grep -vP "[\x80-\xFF\x27]" /usr/share/dict/american-english | sort -R | head -n1| cut -c 1-6)
E1=$(echo ${W2} |md5sum| cut -c 1-2)
R1=$(( $RANDOM % 10 ));
#echo ${W1}
#echo ${E1}
#echo ${R1}
#echo ${W2}

pass=$(echo ${W1}${E1}${R1}${W2} | cut -c 1-15)
#echo $pass
my_char=$(echo $pass | fold -w1| shuf -n1)
#echo $my_char
newpass=$(echo $pass | sed s/$my_char/_/)
echo $newpass
