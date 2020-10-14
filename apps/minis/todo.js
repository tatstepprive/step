//alert("CONNECTED");

var todoList=[];

function ask(){

	return prompt("add,list,delete or quit?:")

}

function show(myArray){
alert("See console for todo list items");
	console.log(myArray);
	console.log("*******************");
	myArray.forEach(function(item, index, array){
     console.log(index + ": "+item);
	});
	console.log("*******************");
}

function addItem(){
	var item=prompt("New todo item:");
	todoList.push(item);
	console.log("Adding item="+item);
	show(todoList);

}	

function deleteItem(){
	var reqIndex=prompt("Deleting todo item on index:");
	console.log("Deleting on todo item on index: "+reqIndex);
	todoList.splice(reqIndex,1); //delete one elemeent on reqIndex
	show(todoList);
}


 var ans=ask();

while (ans!=="quit"){

if (ans==="list"){
	show(todoList);
}

else if (ans==="add"){
	addItem();
}
else if (ans==="delete"){
     deleteItem();
}
else{
  alert("Not known answer");
}

ans=ask();

}

console.log("OK. Quiting application. BYE-BYE!");