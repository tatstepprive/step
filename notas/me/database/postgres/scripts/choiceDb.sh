#!/bin/bash

PS3='Choose your db for export: '
dbs=$(./showDb4Export.sh)
echo dbs=$dbs;
arr=(`echo ${dbs}`);
select fav in "${arr[@]}"; do
    case $fav in
        "Pizza")
            echo "Americans eat roughly 100 acres of $fav each day!"
	    # optionally call a function or run some code here
            ;;
        "Pho")
            echo "$fav is a Vietnamese soup that is commonly mispronounced like go, instead of duh."
	    # optionally call a function or run some code here
            ;;
        "Tacos")
            echo "According to NationalTacoDay.com, Americans are eating 4.5 billion $fav each year."
	    # optionally call a function or run some code here
	    break
            ;;
        $fav)
            echo "Your choice $fav for export."
	    # optionally call a function or run some code here
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done
