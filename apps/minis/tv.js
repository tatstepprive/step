//alert("connected");

const form=document.querySelector("#searchForm");

form.addEventListener("submit", async function(e){ 
	e.preventDefault();
	console.log("clicked");
//	console.dir(this)
//    console.log(this.elements.query.value);
const searchTerm=this.elements.query.value;
//const res = await axios.get("http://api.tvmaze.com/search/shows?q="+searchTerm);
const config={params: { q: searchTerm}}
const res = await axios.get("http://api.tvmaze.com/search/shows", config);

console.log(res.data);
  //   console.log(res.data[0].show.image.medium);
  //   const img=document.createElement('img');
  //  img.src=res.data[0].show.image.medium;
  //   document.body.append(img);
  makeImages(res.data);
  this.elements.query.value="";
});

const makeImages=(shows)=>{
	for(let result of shows){
		if(result.show.image){
			console.log(result.show.image.medium);
			const img=document.createElement('img');
			img.src=result.show.image.medium;
			document.body.append(img);
		}
	}
}
