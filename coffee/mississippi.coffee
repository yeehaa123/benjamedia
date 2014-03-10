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
