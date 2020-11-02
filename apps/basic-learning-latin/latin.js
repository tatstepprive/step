//alert("Connected Latin");
var words=[
["grootvader", "avus", "avi", "m"],
["roos", "rosa", "rosae", "v"],
["geschenk", "donum", "doni", "o"],
["vriend", "amicus", "amici", "m"],
["jaar", "annus", "anni", "m"],
["god", "deus", "dei", "m"],
];

var h1=document.querySelector("h1");

var wordNlDisplay=document.getElementById("wordNl");
var wordLat1AnswerDisplay=document.getElementById("lat1Answer");
var wordLat2AnswerDisplay=document.getElementById("lat2Answer");
var genderAnswerDisplay=document.getElementById("genderAnswer");
var wordLat1CorrectDisplay=document.getElementById("lat1Correct");
var wordLat2CorrectDisplay=document.getElementById("lat2Correct");
var genderCorrectDisplay=document.getElementById("genderCorrect");

var latin1Input=document.getElementById("latin1");
var latin2Input=document.getElementById("latin2");
var buttonGroup=document.querySelectorAll("input[name=gender]");

var randowWord=words[0];
initWord();

var checkBtn=document.getElementById("checkBtn");
var testBlock=document.getElementById("test");

var nextBtn=document.getElementById("nextBtn");
var checkBlock=document.getElementById("check");

var gender="";

checkBlock.style.display="none";

latin1Input.addEventListener("change", function(){
        var input=this.value.trim();
	wordLat1AnswerDisplay.textContent=input;
	var correct=input===wordLat1CorrectDisplay.textContent;
	console.log("TEST1: correct=["+wordLat2AnswerDisplay.textContent+"] answer=["+input+"]");
	wordLat1AnswerDisplay.style.color=correct?"green":"red";
});

latin2Input.addEventListener("change", function(){
        var input=this.value.trim();
	wordLat2AnswerDisplay.textContent=input;
	var correct=input===wordLat2CorrectDisplay.textContent;
	console.log("TEST2: correct=["+wordLat2AnswerDisplay.textContent+"] answer=["+input+"]");
	wordLat2AnswerDisplay.style.color=correct?"green":"red";
});

function pickWord(){
	var random=Math.floor(Math.random()*words.length);
	return words[random];
}

function initWord(){
	randowWord=pickWord()
	wordNlDisplay.textContent=randowWord[0];
	wordLat1CorrectDisplay.textContent=randowWord[1];
	wordLat2CorrectDisplay.textContent=randowWord[2];
	genderCorrectDisplay.textContent=randowWord[3];
	latin1Input.value="";
	latin2Input.value="";
	initGenderInput();
}

function checkWord(){
	var questionMarkIfEmpty=latin1Input.value?latin1Input.value:"?";
	wordLat1AnswerDisplay.textContent=questionMarkIfEmpty;
        var correct=wordLat1CorrectDisplay.textContent===latin1Input.value.trim();
        wordLat1AnswerDisplay.style.color=correct?"green":"red";
        questionMarkIfEmpty=latin2Input.value?latin2Input.value:"?";
        correct=wordLat2CorrectDisplay.textContent===latin2Input.value.trim();
	wordLat2AnswerDisplay.textContent=questionMarkIfEmpty;
        wordLat2AnswerDisplay.style.color=correct?"green":"red";
        gender=getGenderInput();
        questionMarkIfEmpty=gender?gender:"?";
        genderAnswerDisplay.textContent=questionMarkIfEmpty;
        console.log("selected gender="+questionMarkIfEmpty);
        correct=genderCorrectDisplay.textContent===genderAnswerDisplay.textContent;
        genderAnswerDisplay.style.color=correct?"green":"red";
}

function getGenderInput(){
	for(var i=0; i<buttonGroup.length; i++){
		if(buttonGroup[i].checked){
			console.log(i+"="+buttonGroup[i].checked+ " value="+buttonGroup[i].value);
		    return buttonGroup[i].value;
		} 
	 }
	 return "";
}

function initGenderInput(){
	for(var i=0; i<buttonGroup.length; i++){
		buttonGroup[i].checked=false;		
	 }
}

checkBtn.addEventListener("click", function(){
	testBlock.style.display="none";
	checkBlock.style.display="block";
	checkWord();
});

nextBtn.addEventListener("click", function(){
	checkBlock.style.display="none";
	testBlock.style.display="block";
	initWord();
});

