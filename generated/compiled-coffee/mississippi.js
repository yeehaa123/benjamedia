(function() {
  var callAPI, docs, draw, fill, height, init, queryString, width;

  fill = d3.scale.category20();

  width = 900;

  height = 900;

  init = function(data) {
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

  docs = [];

  callAPI = function(i) {
    return d3.json("" + queryString + i, function(d) {
      var docString, num_request;
      num_request = Math.floor(d.response.meta.hits / 10);
      docs = docs.concat(d.response.docs);
      docString = JSON.stringify(docs);
      localStorage.setItem('m', docString);
      i = i + 1;
      console.log("" + i + "/" + num_request);
      if (!(i >= num_request)) {
        return _.delay(callAPI, 100, i);
      }
    });
  };

  queryString = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=mississippi+flood&page=12&sort=oldest&api-key=0d7e2dcc3be1bc75d9f1c766fd313cc8:11:68747186&begin_date=19270101&end_date=19271231&page=";

  $(document).ready(function() {
    var censored, data, i, maxWordFrequency, minWordFrequency;
    censored = true;
    minWordFrequency = $('label.minWordFrequency').find('input').val();
    maxWordFrequency = 60;
    data = function() {
      return window.sortWords({
        els: $('p'),
        censored: censored,
        minWordFrequency: minWordFrequency,
        maxWordFrequency: maxWordFrequency
      });
    };
    init(data());
    $('label.switch-light').on('change', 'input', function(e) {
      censored = $(this).is(':checked');
      return init(data());
    });
    $('.word-frequency').on('change keyup', 'input', function(e) {
      minWordFrequency = $('.word-frequency .min').val();
      maxWordFrequency = $('.word-frequency .max').val();
      return init(data());
    });
    i = 0;
    localStorage.clear('m');
    return callAPI(i);
  });

}).call(this);
