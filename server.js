var express = require("express");

bodyParser = require("body-parser");
const cluster = require('cluster');
const cors = require('cors');
const {
  cpus
} = require('os');


console.log("cl..." + cluster.isMaster);

if (cluster.isMaster) {
  var numWorkers = require('os').cpus().length;

  console.log('Master cluster setting up ' + numWorkers + ' workers...');

  for (var i = 0; i < numWorkers; i++) {
    cluster.fork();
  }

  cluster.on('online', function (worker) {
    console.log('Worker ' + worker.process.pid + ' is online');
  });

  cluster.on('exit', function (worker, code, signal) {
    console.log('Worker ' + worker.process.pid + ' died with code: ' + code + ', and signal: ' + signal);
    console.log('Starting a new worker');
    cluster.fork();
  });
} else {

  app = express();

  port = process.env.PORT || 3789;

  app.use(cors({
    origin: '*'
  }));

  app.use(bodyParser.json({
    limit: '1000mb'
  }));
  app.use(bodyParser.urlencoded({
    limit: '1000mb',
    parameterLimit: 100000,
    extended: true
  }));

  var routes = require("./routes.js");
  routes(app);

  app.get("/api/services/", (request, response) => {
    response.send("WELCOME TO SERVICE REST API - REQUEST METHOD NOT ALLOWED ON THIS ENDPOINT");
  });

  app.use(function (req, res) {
    res.status(404).send({
      url: req.originalUrl + ' not found'
    })
  });

  app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header(
      'Access-Control-Allow-Headers',
      'Origin, X-Requested-With, Content-Type, Accept'
    );
    if (req.method === 'Options') {
      res.header('Access-Control-Allow-Methods', 'POST,GET');
      return res.status(200).json({});
    }
  });


  app.listen(port);
  console.log("SERVICE REST API SERVER STARTED ON : " + port);

}