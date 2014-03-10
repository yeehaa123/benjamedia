(function() {
  $(document).ready(function() {
    var text;
    text = "";
    $('p').each(function(i, p) {
      p = p.replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]/g, "");
      return text += p.innerText;
    });
    text = text.split(" ");
    return console.log(text);
  });

}).call(this);
