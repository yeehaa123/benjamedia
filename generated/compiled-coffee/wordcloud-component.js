(function() {
  window.wordCloud = function() {
    var draw, fill, height, width, _init;
    fill = d3.scale.category20();
    width = 900;
    height = 900;
    _init = function(data) {
      return d3.layout.cloud().size([width, height]).words(data).padding(5).rotate(function() {
        return ~~(Math.random() * 2 * 90);
      }).font("Impact").fontSize(function(d) {
        return d.size;
      }).on("end", draw).start();
    };
    draw = function(words) {
      var fontSizeScale;
      $('svg').remove();
      fontSizeScale = d3.scale.linear().domain(d3.extent(words, function(d) {
        return d.size;
      })).range([5, 100]);
      return d3.select("#cloud").append("svg").attr("width", width).attr("height", height).append("g").attr("transform", "translate(" + (width / 2) + "," + (height / 2) + ")").selectAll("text").data(words).enter().append("text").style("font-size", function(d) {
        return fontSizeScale(d.size) + "px";
      }).style("font-family", "Impact").style("fill", function(d, i) {
        return fill(i);
      }).attr("text-anchor", "middle").attr("transform", function(d) {
        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
      }).text(function(d) {
        return d.text;
      });
    };
    return {
      init: _init
    };
  };

}).call(this);
