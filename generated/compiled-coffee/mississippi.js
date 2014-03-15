(function() {
  $(document).ready(function() {
    var censored, data, maxWordFrequency, minWordFrequency, sortWords, wordCloud;
    wordCloud = window.wordCloud();
    sortWords = window.sortWords;
    censored = true;
    minWordFrequency = $('label.minWordFrequency').find('input').val();
    maxWordFrequency = 60;
    data = function() {
      return sortWords({
        els: $('p'),
        censored: censored,
        minWordFrequency: minWordFrequency,
        maxWordFrequency: maxWordFrequency
      });
    };
    wordCloud.init(data());
    $('label.switch-light').on('change', 'input', function(e) {
      censored = $(this).is(':checked');
      return wordCloud.init(data());
    });
    return $('.word-frequency').on('change keyup', 'input', function(e) {
      minWordFrequency = $('.word-frequency .min').val();
      maxWordFrequency = $('.word-frequency .max').val();
      return wordCloud.init(data());
    });
  });

}).call(this);
