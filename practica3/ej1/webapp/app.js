var express = require('express');
var mysql = require('mysql');
var app = express();

app.get('/', function(req, res) {
    var connection = mysql.createConnection({
      host     : "acr2324-db",
      user     : "acr2324",
      password : "12345",
      database : "acr2324-database"
    });

    var url = req.protocol + '://' + req.get('host') + req.originalUrl;

    connection.connect(function(err) {
	var height = '200px';
	if(err)
		height = '230px';

	var course = '<h3><u>GEI AISI 2023/2024</u></h3>';
	var img = '<p><img src="https://gac.udc.es/~rober/aisi/udc.png" style="max-width: 300px; width: auto;"></p>';
	var header = '<html><head><title>GEI AISI</title></head><div style="width:600px;height:'+height+';border:2px solid #000;text-align: center;">';
	var msg = header +'<body><strong>'+img+course+'<p><u>Node.js+Express+MariaDB (Ansible)</u><p>'+url+'<p>'+new Date()+'<p>MariaDB connection from user '+connection.config.user+': ';
	var footer = '</strong></div></body></html>';

        if(!err) {
	    res.type('text/html').send(msg + '<span style="color: green;">OK</span>'+footer);
        } else {
            res.type('text/html').send(msg + '<span style="color: red;">FAILED</span><p>'+err+footer);
        }
        connection.end();
    });
});

app.listen(80, function () {
    console.log('Node.js app listening on port 80!');
});


