//alert("CONNECTED");

var myButton=document.querySelector("button");
var myBody=document.querySelector("body");
var colorInfo=document.querySelector("h1");


function blackWhite(){
	console.log("button is clicked");  
	myBody.style.background=myBody.style.background==="black"?"white":"black";
	colorInfo.innerText=myBody.style.background==="white"?"white":"black";
	colorInfo.style.color=myBody.style.background==="white"?"black":"white"
	// other way is to add/remove = toogle the class name defined in css
	//document.body.classList.toogle("purple"); 
}

function randomColor(){
	var myColor=getRandomColor();
	console.log("button is clicked with picked color="+myColor);  
	myBody.style.background=myBody.style.background=myColor;
	colorInfo.innerText=myColor; 
}


function getRandomColor(){
	var red=Math.floor(Math.random()*256);
	var green=Math.floor(Math.random()*256);
	var blue=Math.floor(Math.random()*256);
	return "rgb("+red +", "+green+", "+ blue +")";
}

myButton.addEventListener("click", randomColor);