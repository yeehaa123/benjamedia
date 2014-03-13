window.sortWords = (config) ->
  els = config.els
  censored = config.censored || false
  minWordFrequency = config.minWordFrequency || 1
  maxWordFrequency = config.maxWordFrequency || 60

  text = ""

  for el, index in els
    el = el.innerText.replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]/g,"")
    text += el

  words = text.split(" ")

  general = ["the", "of", "to", "and", "a", "it", "in", "we", "was", "that", "as", "with", 
    "which", "for", "were", "not", "they", "one", "had", "did", "its",
    "his", "on", "so", "be", "all", "by", "or", "even", "then", "this", "he", "you", "an", "no", "our",
    "are", "than", "him", "would", "is", "i", "too", "if", "us", "when", "know", "who", "them", "we’ll", 
    "what", "make", "been", "their", "these", "more", "only", "other", "those",
    "saw", "only", "ever", "just", "could", "have", "themselves", "want",
    "some", "give", "came", "himself", "said", "like", "heard", "same",
    "show", "see", "you’ll"]

  direction = ["from", "at", "into", "where", "there", "up", "down", "against", 
    "away", "under", "out", "back", "toward", "around", "above", "left", 
    "right", "upon", "along"]

  time = ["ever", "when", "now", "already", "new", "again", "year", "once",
    "finally", "years", "time", "times", "day"]

  condition = ["but", "however"]

  quantity = ["first", "three", "ten", "much", "every", "hundreds", "many", 
    "seven", "fifty", "nothing", "everything", "most", "two", "another", 
    "thousands"]

  distance = ["meter", "miles", "meters", "distance"]
  
  blacklist = _.flatten([general, direction, condition, time, quantity, distance])


  wordsObject = []
  for word, index in words
    word = word.toLowerCase()
    if _.has wordsObject, word
      wordsObject[word] += 1
    else
      wordsObject[word] = 1

  wordsIndex = _.keys wordsObject

  sortedWordsIndex= _.sortBy wordsIndex, (i) ->
    wordsObject[i]
  
  filteredSortedWordsIndex = _.reject sortedWordsIndex, (i) ->
    i if wordsObject[i] < minWordFrequency || wordsObject[i] > maxWordFrequency

  censoredSortedWordsIndex = _.reject filteredSortedWordsIndex, (i) ->
    if censored
      i if i in blacklist

  sortedWords = censoredSortedWordsIndex.reverse().map (word) ->
    temp = {}
    temp.text = word
    temp.size = wordsObject[word]
    temp


  sortedWords
