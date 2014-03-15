# db = ""
# docs = []
# 
# callAPI = (i) ->
#   db = new Firebase('https://mississippi.firebaseio.com/')
#   d3.json "#{queryString}#{i}", (d) ->
#     num_request = Math.floor d.response.meta.hits / 10
#     docs = docs.concat d.response.docs
#     docString = JSON.stringify(docs)
#     db.set(docs)
#     localStorage.setItem('m', docString)
#     i = i + 1
#     console.log("#{i}/#{num_request}")
#     unless i > num_request
#       _.delay(callAPI, 100, i)
# 
# queryString = "http://api.nytimes.com/svc/search/v2/articlesearch.json?q=mississippi+flood&page=12&sort=oldest&api-key=0d7e2dcc3be1bc75d9f1c766fd313cc8:11:68747186&begin_date=19270101&end_date=19271231&page="


$(document).ready ->
  wordCloud = window.wordCloud()
  sortWords = window.sortWords

  censored = true
  minWordFrequency = $('label.minWordFrequency').find('input').val()
  maxWordFrequency = 60
  data = ->
    sortWords  
      els: $('p')
      censored: censored
      minWordFrequency: minWordFrequency
      maxWordFrequency: maxWordFrequency

  wordCloud.init(data())
  $('label.switch-light').on 'change', 'input', (e) ->
    censored = $(this).is(':checked')
    wordCloud.init(data())

  $('.word-frequency').on 'change keyup', 'input', (e) ->
    minWordFrequency = $('.word-frequency .min').val()
    maxWordFrequency = $('.word-frequency .max').val()
    wordCloud.init(data())


  # i = 0
  # localStorage.clear('m')
  # callAPI(i)
