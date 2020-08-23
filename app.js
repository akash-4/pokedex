const express = require("express");
const app = express();
app.get("/reverse",function(req, res){
    var word=req.query.word;
    var splitString = word.split(""); 
  var reverseArray = splitString.reverse();
 var joinArray = reverseArray.join(""); 
    var obj={
      number_words: word.length,
      reverse:joinArray,
    }
   res.send(obj);
});
app.get("/",function(req, res){

   res.send("<p>Please use <mark>http://localhost:3000<em>/reverse?word=<strong>example</strong></em> ");
});
app.listen(3000, function() {
    console.log("Server started on port 3000");
  });