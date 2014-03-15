(function() {
  var app, express, port;

  express = require('express');

  port = process.env.PORT || 8000;

  app = express();

  app.use(express["static"](__dirname + "/generated"));

  app.listen(port);

  console.log(__dirname);

  console.log("Starting express web server " + port);

}).call(this);
