(function() {
  var draw, fill, init;

  fill = d3.scale.category20();

  init = function(data) {
    return d3.layout.cloud().size([900, 300]).words(data).padding(5).rotate(function() {
      return ~~(Math.random() * 2 * 90);
    }).font("Impact").fontSize(function(d) {
      return d.size;
    }).on("end", draw).start();
  };

  draw = function(words) {
    var fontSizeScale;
    fontSizeScale = d3.scale.linear().domain(d3.extent(words, function(d) {
      return d.size;
    })).range([2, 100]);
    $('svg').remove();
    return d3.select("#cloud").append("svg").attr("width", 900).attr("height", 300).append("g").attr("transform", "translate(450,150)").selectAll("text").data(words).enter().append("text").style("font-size", function(d) {
      return fontSizeScale(d.size) + "px";
    }).style("font-family", "Impact").style("fill", function(d, i) {
      return fill(i);
    }).attr("text-anchor", "middle").attr("transform", function(d) {
      return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
    }).text(function(d) {
      return d.text;
    });
  };

  $(document).ready(function() {
    var censored, data;
    censored = true;
    data = function() {
      return window.sortWords({
        els: $('p'),
        censored: censored,
        minWordFrequency: 2
      });
    };
    init(data());
    return $('label.switch-light').on('change', 'input', function(e) {
      censored = $(this).is(':checked');
      return init(data());
    });
  });

}).call(this);
