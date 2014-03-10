fill = d3.scale.category20();

init = (data) ->
  d3.layout.cloud().size([900, 300])
      .words(data)
      .padding(5)
      .rotate -> ~~(Math.random() * 2* 90)
      .font("Impact")
      .fontSize (d) -> d.size
      .on("end", draw)
      .start()

draw = (words) ->
  fontSizeScale = d3.scale.linear()
    .domain(d3.extent(words, (d) -> d.size))
    .range([2, 100])
  $('svg').remove()
  d3.select("#cloud").append("svg")
      .attr("width", 900)
      .attr("height", 300)
    .append("g")
      .attr("transform", "translate(450,150)")
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
  data = ->
    window.sortWords({els: $('p'), censored: censored, minWordFrequency: 2})
  init(data())
  $('label.switch-light').on 'change', 'input', (e) ->
    censored = $(this).is(':checked')
    init(data())
