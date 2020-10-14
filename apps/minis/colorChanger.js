//alert("CONNECTED");

var myButton=document.querySelector("button");
var myBody=document.querySelector("body");

myButton.addEventListener("click", function(){
	console.log("button is clicked");  
	myBody.style.background=myBody.style.background==="black"?"white":"black";
	// other way is to add/remove = toogle the class name defined in css
	//document.body.classList.toogle("purple"); 
});