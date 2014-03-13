db = ""
fill = d3.scale.category20();

width = 900
height = 900

init = (data) ->
  d3.layout.cloud().size([width, height])
      .words(data)
      .padding(5)
      .rotate -> ~~(Math.random() * 2* 90)
      .font("Impact")
      .fontSize (d) -> d.size
      .on("end", draw)
      .start()

draw = (words) ->
  $('svg').remove()

  fontSizeScale = d3.scale.linear()
    .domain(d3.extent(words, (d) -> d.size))
    .range([5, 100])

  d3.select("#cloud").append("svg")
      .attr("width", width)
      .attr("height", height)
    .append("g")
      .attr("transform", "translate(#{width/2},#{height/2})")
    .selectAll("text")
      .data(words)
    .enter().append("text")
      .style "font-size", (d)-> fontSizeScale(d.size) + "px"
      .style("font-family", "Impact")
      .style "fill", (d, i) -> fill(i)
      .attr("text-anchor", "middle")
      .attr "transform", (d) -> "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"
      .text (d) -> d.text

docs = []

callAPI = (i) ->
  db = new Firebase('https://mississippi.firebaseio.com/')
  d3.json "#{queryString}#{i}", (d) ->
    num_request = Math.floor d.response.meta.hits / 10
    docs = docs.concat d.response.docs
    docString = JSON.stringify(docs)
    db.set(docs)
    localStorage.setItem('m', docString)
    i = i + 1
    console.log("#{i}/#{num_request}")
    unless i >= num_request
      _.delay(callAPI, 100, i)

queryString = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=mississippi+flood&page=12&sort=oldest&api-key=0d7e2dcc3be1bc75d9f1c766fd313cc8:11:68747186&begin_date=19270101&end_date=19271231&page="


$(document).ready ->
  censored = true
  minWordFrequency = $('label.minWordFrequency').find('input').val()
  maxWordFrequency = 60
  data = ->
    window.sortWords  
      els: $('p')
      censored: censored
      minWordFrequency: minWordFrequency
      maxWordFrequency: maxWordFrequency

  init(data())
  $('label.switch-light').on 'change', 'input', (e) ->
    censored = $(this).is(':checked')
    init(data())

  $('.word-frequency').on 'change keyup', 'input', (e) ->
    minWordFrequency = $('.word-frequency .min').val()
    maxWordFrequency = $('.word-frequency .max').val()
    init(data())

  i = 0
  localStorage.clear('m')
  callAPI(i)
