//alert("Connected");

var myForm=document.querySelector('form');
var product=document.querySelector('#product');
var quantity=document.querySelector('#qty');
var ul=document.querySelector('#list');
myForm.addEventListener('submit', function(evt){
  
   var productValue=product.value;
   var quantityValue=quantity.value;
   console.log("input="+productValue +" quantityValue="+quantityValue);
   var newLi=document.createElement('li');
   newLi.innerText=productValue + ' ' + quantityValue;
   ul.appendChild(newLi);
   product.value="";
   quantity.value="";
    evt.preventDefault(); 
});