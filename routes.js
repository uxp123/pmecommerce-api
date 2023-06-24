"use strict";
var winston = require("winston");
var jwt = require("jsonwebtoken");
var mysql = require("mysql");
var postrequest = require("request");
var Jimp = require("jimp");
const https = require("http");
const bcrypt = require("bcrypt");
const crypto =  require("crypto");

var connection = mysql.createPool({
    connectionLimit: 120,
    host: "localhost",
    port: 8889,
    user: "root",
    password: "root",
    database: "ecommerce"
  });


connection.query(
  "SELECT * FROM customers",
  [""],
  function (err, rows, fields) {
    if (err) throw err;

    for (var i in rows) {
      console.log(
        "LIVE DB TABLE RESULT: ",
        rows[i].id + "  " + rows[i].agentname
      );
    }
  }
);

module.exports = function (app) {
//authentication
  var authenticate = (request, response, next) => {
    var token = request.header("api-key");

    jwt.verify(token, "p@$sW0rd1234", function (err, agent) {
      if (err) {
        return response.status(401).send("UNAUTHORIZED ACCESS TO API -  ERROR");
      } else {
       
       next();
      }
    });
  };

//Hash password  
async function hashPassword(plaintextPassword) {
    const hashedpassword = await bcrypt.hash(plaintextPassword, 15);
    return hashedpassword;}
 
// compare password
async function comparePassword(plaintextPassword, hash) {
    const result = await bcrypt.compare(plaintextPassword, hash);
    return result;
}

//ping route
  app.get("/api/ping/",authenticate ,(request, response) => {
    response.send(
      "WELCOME TO MY TEST ROUTE"
    );
  });


  
  app.post("/api/token/", (request, response) => {
    let json = request.body;
    console.log(json);
    if (json.requesttype == "etoken") {
      jwt.sign(
        {
          username: json.username,
          accesstoken: json.accesstoken,
        },
        "p@$sW0rd1234",
        function (err, token) {
          if (err) {
            var data = JSON.stringify({"status":"0","message":err,"key":""});
            response.send(data);
          }
          else {
           var data = JSON.stringify({"status":"1","message":"key generated successfuly","key":token});
            response.send(data);
          }
        }
      );
    } else {
      response.send("INVALID REQUEST FOR TOKEN");
    }
  });  



//login route 
  app.post("/api/login", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });

  //signup route 
  app.post("/api/signup", authenticate ,(request, response) => {
    let customer = request.body;
    var encryptedpassword =  hashPassword(customer.password);


     encryptedpassword.then(function(result){
      encryptedpassword =  result;
      
      var sql= "INSERT INTO customers(firstname, surname, mobilenumber, emailaddress, password, createddate, createdtime, status, reference) VALUES (?,?,?,?,?,?,?,?,?)";

      var status = "active";
      var todaysdate = new Date().toISOString().slice(0,10);
      var time  =  new Date();
      var finaltime =  time.getHours() +":"+time.getMinutes()+":"+time.getSeconds();
      var reference = crypto.randomUUID();

      connection.query(
       sql,
        [customer.firstname, customer.surname, customer.mobilenumber, customer.emailaddress, encryptedpassword,todaysdate,finaltime,status,reference],
        function (err, rows, fields) {
          if (err) {
            var data = JSON.stringify({"status":"0","message":err.sqlMessage + "-" + err.code,"reference":""});
            response.send(data);
          }
           else{
           
            var data = JSON.stringify({"status":"1","message":"Your registration was successful","reference":reference});
            response.send(data);
           }
        }
      );

     
     });

    
  


  });

  //changepassword
   app.post("/api/changepassword", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });

  //resetpassword
   app.post("/api/resetpassword", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });
  
  

  //addwishlistitem route 
  app.post("/api/addwishlistitem", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });

  //deletewishlistitem route 
  app.post("/api/deletewishlistitem", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });

  //mywishlist route 
  app.post("/api/mywishlist", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });

  //checkout route 
  app.post("/api/checkout", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });


  //adddelivery adress route 
  app.post("/api/adddeliveryadress", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });


  //deletedeliveryaddress route 
  app.post("/api/deletedeliveryaddress", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });

  //mydeliveryaddress route 
  app.post("/api/mydeliveryaddress", authenticate ,(request, response) => {
    let json = request.body;
  
  
  });
  
 //myorderlist route 
 app.post("/api/myorderlist", authenticate ,(request, response) => {
  let json = request.body;


});
  


 //addproduct route 
 app.post("/api/admin/addproduct", authenticate ,(request, response) => {
  let json = request.body;


});

 //deleteproduct route 
 app.post("/api/admin/deleteproduct", authenticate ,(request, response) => {
  let json = request.body;


});

 //updateproduct route 
 app.post("/api/admin/updateproduct", authenticate ,(request, response) => {
  let json = request.body;


});

 //viewproduct route 
 app.post("/api/admin/viewproducts", authenticate ,(request, response) => {
  let json = request.body;


});

 //vieworders route 
 app.post("/api/admin/vieworders", authenticate ,(request, response) => {
  let json = request.body;


});

 //addcategory route 
 app.post("/api/admin/addcategory", authenticate ,(request, response) => {
  let json = request.body;


});

 //editcategory route 
 app.post("/api/admin/editcategory", authenticate ,(request, response) => {
  let json = request.body;


});

 //deletecategory route 
 app.post("/api/admin/deletecategory", authenticate ,(request, response) => {
  let json = request.body;
//helloo

});

 //listcategory route 
 app.post("/api/admin/listencategory", authenticate ,(request, response) => {
  let json = request.body;


});

 //adminloginroute 
 app.post("/api/admin/adminlogin", authenticate ,(request, response) => {
  let json = request.body;


});

}

