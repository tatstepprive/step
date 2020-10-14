//alert("Connected");

var limit=5;
var player1=0;
var player2=0;

var btn1=document.getElementById("btn1");
var btn2=document.getElementById("btn2");
var reset=document.getElementById("reset");

var player1Label=document.getElementById("player1");
var player2Label=document.getElementById("player2");

var numInput=document.querySelector("input[type='number']");
var limitLabel=document.getElementById("limit");

function setScore(playerLabel, playerScore){
	console.log("Clicked");
	console.log(player1Label);
	console.log(playerScore);
	if(playerScore<limit && ! done){
		playerScore++;
		playerLabel.textContent=playerScore;
	}
	else{
		done=true;
		playerLabel.style.color="green";
	}
};

function resetGame(){
	console.log("RESET");
	player1=0;
	player1Label.textContent=player1;
	player1Label.style.color="black";
	player2=0;
	player2Label.textContent=player2;
	player2Label.style.color="black";
	done=false;
};

var done=false;

//btn1.addEventListener("klick", setScore(player1Label, player1));
//btn2.addEventListener("klick", setScore(player2Label, player2));

btn1.addEventListener("click", function(){
	console.log("Clicked 1");
    //setScore(player1Label, player1); // does not work

    if(player1<limit && ! done){
    	player1++;
    	player1Label.textContent=player1;
    }
    else{
    	done=true;
    	player1Label.style.color="green";
    }
});

btn2.addEventListener("click", function(){
	console.log("Clicked 2");
 // setScore(player2Label, player2); //does not work

     if(player2<limit && ! done){
    	player2++;
    	player2Label.textContent=player2;
    }
    else{
    	done=true;
    	player2Label.style.color="green";
    }

});

reset.addEventListener("click", function(){
	resetGame();
});

numInput.addEventListener("change", function(){
	//alert("input clicked");
	resetGame();
	limitLabel.textContent=this.value;
	limit=this.value;
});
