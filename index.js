var app, express;

express = require('express');

app = express();

app.get('/auth/user', function(req, res) {
  console.log('/auth/user');
  console.log(req.method);
  console.log(req.body);
  console.log(req.query);
  console.log(req.headers);
  return res.status(200).send('allow [ Administrator ]');
});

app.get('/auth/vhost', function(req, res) {
  console.log('/auth/vhost');
  console.log(req.method);
  console.log(req.body);
  console.log(req.query);
  console.log(req.headers);
  return res.status(200).send('allow');
});

app.get('/auth/resource', function(req, res) {
  console.log('/auth/resource');
  console.log(req.method);
  console.log(req.body);
  console.log(req.query);
  console.log(req.headers);
  return res.status(200).send('allow');
});

app.listen(8080);
