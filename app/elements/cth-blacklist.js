var cth = cth || {};

cth.wordTools = cth.wordTools || {};

cth.wordTools.blacklist = function() {

  var general = ["the", "of", "to", "and", "a", "it", "in", "we", "was", "that", "as", "with", 
    "which", "for", "were", "not", "they", "one", "had", "did", "its",
    "his", "on", "so", "be", "all", "by", "or", "even", "then", "this", "he", "you", "an", "no", "our",
    "are", "than", "him", "would", "is", "i", "too", "if", "us", "when", "know", "who", "them", "we’ll", 
    "what", "make", "been", "their", "these", "more", "only", "other", "those",
    "saw", "only", "ever", "just", "could", "have", "themselves", "want",
    "some", "give", "came", "himself", "said", "like", "heard", "same",
    "show", "see", "you’ll"];

  var direction = ["from", "at", "into", "where", "there", "up", "down", "against", 
    "away", "under", "out", "back", "toward", "around", "above", "left", 
    "right", "upon", "along"];

  var time = ["ever", "when", "now", "already", "new", "again", "year", "once",
    "finally", "years", "time", "times", "day"];

  var condition = ["but", "however"];

  var quantity = ["first", "three", "ten", "much", "every", "hundreds", "many", 
    "seven", "fifty", "nothing", "everything", "most", "two", "another", 
    "thousands"];

  var distance = ["meter", "miles", "meters", "distance"];
  
  var blacklist = _.flatten([general, direction, condition, time, quantity, distance]);
  
  return blacklist; 
}
