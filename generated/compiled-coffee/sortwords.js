(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  window.sortWords = function(config) {
    var blacklist, censored, censoredSortedWordsIndex, el, els, filteredSortedWordsIndex, index, maxWordFrequency, minWordFrequency, sortedWords, sortedWordsIndex, text, word, words, wordsIndex, wordsObject, _i, _j, _len, _len1;
    els = config.els;
    censored = config.censored || false;
    minWordFrequency = config.minWordFrequency || 1;
    maxWordFrequency = config.maxWordFrequency || 60;
    text = "";
    for (index = _i = 0, _len = els.length; _i < _len; index = ++_i) {
      el = els[index];
      el = el.innerText.replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]/g, "");
      text += el;
    }
    words = text.split(" ");
    blacklist = ["the", "of", "to", "and", "a", "it", "in", "we", "was", "that", "as", "with", "from", "which", "at", "but", "however", "for", "were", "not", "they", "one", "had", "did", "its", "into", "his", "on", "so", "be", "all", "by", "or", "even", "then", "this", "he", "you", "an", "no", "our", "are", "than", "him", "would", "is", "i", "too", "if", "us", "when", "know", "who", "them", "we’ll", "what", "make", "been", "first", "three", "ten", "much", "out", "their", "these", "more", "only", "other", "saw", "only", "ever", "just", "could", "new", "have", "now", "themselves", "already", "want", "where", "some", "give", "came", "himself", "said", "like", "heard", "same", "there"];
    wordsObject = [];
    for (index = _j = 0, _len1 = words.length; _j < _len1; index = ++_j) {
      word = words[index];
      word = word.toLowerCase();
      if (_.has(wordsObject, word)) {
        wordsObject[word] += 1;
      } else {
        wordsObject[word] = 1;
      }
    }
    wordsIndex = _.keys(wordsObject);
    sortedWordsIndex = _.sortBy(wordsIndex, function(i) {
      return wordsObject[i];
    });
    filteredSortedWordsIndex = _.reject(sortedWordsIndex, function(i) {
      if (wordsObject[i] < minWordFrequency || wordsObject[i] > maxWordFrequency) {
        return i;
      }
    });
    censoredSortedWordsIndex = _.reject(filteredSortedWordsIndex, function(i) {
      if (censored) {
        if (__indexOf.call(blacklist, i) >= 0) {
          return i;
        }
      }
    });
    console.log(censoredSortedWordsIndex.reverse());
    sortedWords = censoredSortedWordsIndex.reverse().map(function(word) {
      var temp;
      temp = {};
      temp.text = word;
      temp.size = wordsObject[word];
      return temp;
    });
    return sortedWords;
  };

}).call(this);
