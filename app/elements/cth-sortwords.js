var cth = cth || {};

cth.wordTools = cth.wordTools || {};

cth.wordTools.sortWords= function() {
  var minValue, maxValue, blacklist, censored;
  
  var sortWords = function(config){
    minValue = config.minValue || 3;
    maxValue = config.maxValue || 6;
    censored = config.censored || false;
    blacklist = config.blacklist || [];

    var text = config.text,
        cleanedText = cleanText(text),
        splittedText = splitText(cleanedText),
        rawWordsObject = countWords(splittedText),
        rawKeys = getKeys(rawWordsObject),
        sortedKeys = sortKeys(rawKeys, rawWordsObject),
        filteredKeys = filterWords(sortedKeys, rawWordsObject),
        censoredKeys = censorWords(filteredKeys),
        wordsObject = makeOutputObject(censoredKeys, rawWordsObject)

      return wordsObject
    },

    makeOutputObject = function(keys, words){
      return keys.map(function(word){
        var temp = {};
        temp.text = word;
        temp.size = words[word];
        return temp;
      });
    },

    cleanText =  function(text){
      return text.replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]/g,"");
    },

    splitText = function(text){
      return text.split(" ") 
    },

    countWords = function(text){
      var wordsObject = [];
      text.forEach(function(word){
        word = word.toLowerCase();
        if (_.has(wordsObject, word)) {
          wordsObject[word] += 1;
        } else {
          wordsObject[word] = 1;
        }
      });
      return wordsObject
    },

    getKeys = function(wordsObject){
      return _.keys(wordsObject);
    },

    sortKeys = function(keys, words){
      return _.sortBy(keys, function(i) {
        return words[i];
      }).reverse();
    },

    filterWords = function(keys, words) {
      return _.reject(keys, function(i) {
        if (words[i] < minValue || words[i] > maxValue) {
          return i;
        }
      });
    },

    censorWords = function(keys) {
      return _.reject(keys, function(key) {
        if (censored && _.contains(blacklist, key)) {
          return key;
        }
      });
    }

  return sortWords;

}()
