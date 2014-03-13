$(document).ready(function(){
    text = "";
    $('p').each(function(i, p){
      console.log(p);
      text += p.innerText;
    });

    text = text.split(" ");

    console.log(text);
});
