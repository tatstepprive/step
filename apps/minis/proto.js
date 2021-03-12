// to examine in the dev console in browser with a.__proto__ return value
var a={};
var b=function () {};
var c=[];
//======================
var person ={
	firstName: 'Default',
	lastName: 'Default',
	fullName: function(){
		return this.firstName+ ' ' +this.lastName;
	}
}

var john={
	firstName: 'John',
	lastName: 'Doe'
}
// dont do this EVER! Only for test purposes!

john.__proto__= person;

console.log('Name= ' +john.fullName());

var vera={
	firstName: 'Vera'
}
vera.__proto__= john;
console.log('Name= '+ vera.fullName());

// loop over the property and value of the object
console.log('Print out all properties for prototype');
for(var prop in vera){
	console.log(prop+':'+vera[prop]);
}

console.log('Print out only own properties');
for(var prop in vera){
	if(vera.hasOwnProperty(prop)){
	console.log(prop+':'+vera[prop]);
}
}

// working with extend (combine objects in one)
console.log('Print out etended object john');

var jim={
	getFirstName: function(){
		return this.firstName;
	}
}

var jane={
	address: '123 Main str.',
	getFormalFullName: function(){
		return this.lastName+ ', ' + this.firstName;
	}
}

_.extend(john, jim, jane);

console.log(john);
//=============