var cth = cth || {};

cth.wordTools = function() {
  var minValue, maxValue;
  
  var sortWords = function(config){
    minValue = config.minValue;
    maxValue = config.maxValue;

    var text = config.text,
        cleanedText = cleanText(text),
        splittedText = splitText(cleanedText),
        rawWordsObject = countWords(splittedText),
        rawKeys = getKeys(rawWordsObject),
        sortedKeys = sortKeys(rawKeys, rawWordsObject),
        filteredKeys = filterWords(sortedKeys, rawWordsObject),
        wordsObject = makeOutputObject(filteredKeys, rawWordsObject)

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
        if (wordsObject.propertyIsEnumerable(word)) {
          wordsObject[word] += 1;
        } else {
          wordsObject[word] = 1;
        }
      });
      return wordsObject
    },

    getKeys = function(wordsObject){
      return Object.keys(wordsObject)
    },

    sortKeys = function(keys, words){
      return keys.sort(function(a,b){
        return words[b] - words[a];
      });
    },

    filterWords = function(keys, words) {
      return _.reject(keys, function(i) {
        if (words[i] < minValue || words[i] > maxValue) {
          return i;
        }
      });
    }

  return {
    sortWords: sortWords
  }

}()
