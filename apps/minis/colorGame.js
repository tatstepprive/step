//alert("Connected");

/*var colors=[
"rgb(255, 0, 0)",
"rgb(255, 255, 0)",
"rgb(0, 255, 0)",
"rgb(0, 255, 255)",
"rgb(0, 0, 255)",
"rgb(255, 0, 255)"
]
*/
var numSquares=6;
var colors=getRandomColors(numSquares);

var squares=document.querySelectorAll(".square");
var pickedColor=pickColor();

var colorDisplay=document.getElementById("colorDisplay");
colorDisplay.textContent=pickedColor;

var message=document.getElementById("message");

var h1=document.querySelector("h1");
var newColorsBtn=document.querySelector("#resetBtn");

var easyBtn=document.querySelector("#easyBtn");
var hardBtn=document.querySelector("#hardBtn");

easyBtn.addEventListener("click", function(){
	this.classList.toggle("selected");
	hardBtn.classList.toggle("selected");
	numSquares=3;
	colors=getRandomColors(numSquares);
	pickedColor=pickColor();
	fillSquares();
	colorDisplay.textContent=pickedColor;
	newColorsBtn.textContent="New colors";
	message.textContent="";
	h1.style.backgroundColor="steelblue";
});

hardBtn.addEventListener("click", function(){
	this.classList.toggle("selected");
	easyBtn.classList.toggle("selected");
	numSquares=6;
	colors=getRandomColors(numSquares);
	pickedColor=pickColor();
	fillSquares();
	colorDisplay.textContent=pickedColor;
	newColorsBtn.textContent="New colors";
	message.textContent="";
	h1.style.backgroundColor="steelblue";
});


for(var i=0; i<squares.length; i++){
	squares[i].style.backgroundColor=colors[i];
	squares[i].addEventListener("click", function(){
		var clickedColor=this.style.backgroundColor;
		console.log("clicked=" + clickedColor);
		if(clickedColor===pickedColor){
			message.textContent="Correct!";
			h1.style.backgroundColor=pickedColor;
			newColorsBtn.textContent="Play again?";
			for(var i=0; i<squares.length; i++){
				squares[i].style.backgroundColor=pickedColor;
			}

		}else{
			this.style.backgroundColor="#232323";
			message.textContent="Try Again!";
			newColorsBtn.textContent="New colors";
		}
	});
}

newColorsBtn.addEventListener("click", function(){
	colors=getRandomColors(numSquares);
	pickedColor=pickColor();
	fillSquares();
	colorDisplay.textContent=pickedColor;
	this.textContent="New colors";
	message.textContent="";
	h1.style.backgroundColor="steelblue";
})

function fillSquares(){
	for(var i=0; i<squares.length; i++){
		if(colors[i]){
			squares[i].style.backgroundColor=colors[i];
			squares[i].style.display="block";
		}else{
			squares[i].style.display="none";
		}
	
}
}

function pickColor(){
	var random=Math.floor(Math.random()*colors.length);
	return colors[random];
}

function getRandomColors(num){
	var arr=[];

	for (var i=0; i<num; i++){
		arr.push(randomColor());
	}

	return arr;
}

function randomColor(){
	var red=Math.floor(Math.random()*256);
	var green=Math.floor(Math.random()*256);
	var blue=Math.floor(Math.random()*256);
	return "rgb("+red +", "+green+", "+ blue +")";
}

