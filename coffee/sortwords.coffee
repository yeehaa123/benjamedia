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

  blacklist = ["the", "of", "to", "and", "a", "it", "in", "we", "was", "that", "as", "with", "from", 
    "which", "at", "but", "however", "for", "were", "not", "they", "one", "had", "did", "its", "into",
    "his", "on", "so", "be", "all", "by", "or", "even", "then", "this", "he", "you", "an", "no", "our",
    "are", "than", "him", "would", "is", "i", "too", "if", "us", "when", "know", "who", "them", "we’ll", 
    "what", "make", "been", "first", "three", "ten", "much", "out", "their", "these", "more", "only", "other",
    "saw", "only", "ever", "just", "could", "new", "have", "now", "themselves", "already", "want", "where",
    "some", "give", "came", "himself", "said", "like", "heard", "same", "there"]


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

  console.log(censoredSortedWordsIndex.reverse())


  sortedWords = censoredSortedWordsIndex.reverse().map (word) ->
    temp = {}
    temp.text = word
    temp.size = wordsObject[word]
    temp


  sortedWords
