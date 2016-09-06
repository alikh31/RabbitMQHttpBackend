'use strict'

var app, express;

express = require('express');

app = express();

app.get('/auth/user', function(req, res) {
  console.log(req);
  console.log('/auth/user');
  console.log(req.query);
  return res.status(200).send('allow [ Administrator ]');
});

app.get('/auth/vhost', function(req, res) {
  console.log('/auth/vhost');
  console.log(req.query);
  return res.status(200).send('allow');
});

app.get('/auth/resource', function(req, res) {
  console.log('/auth/resource');
  console.log(req.query);
  return res.status(200).send('allow');
});

var appPort = 8080

app.listen(appPort, () => {
  console.log('app is lestening on port: ' + appPort)
})
