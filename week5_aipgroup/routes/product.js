var express = require('express');
var router = express.Router();
//var app = express();
var mysql      = require('mysql');


router.get("/product/list",function(req,res){

    var con = mysql.createConnection({
        host     : 'ourcityshop.com.au',
        user     : 'ourcity9_aip2017',
        password : 'Minmin@1',
        database : 'ourcity9_aip2017_uts'
    });

    con.connect(function(err) {
        if (err) throw err;
        con.query("SELECT p.product_id, p.product_nm, p.description FROM ourcity9_aip2017_uts.product as p", function (err, rows, fields) {
            if (err){
                console.log('Error while performing Query.');
                return res.send(err);
            }
            return res.json(rows);
        });
    });

});

router.get("/product/:id",function(req,res){

    var con = mysql.createConnection({
        host     : 'ourcityshop.com.au',
        user     : 'ourcity9_aip2017',
        password : 'Minmin@1',
        database : 'ourcity9_aip2017_uts'
    });

    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT p.product_id  , p.product_nm, p.description FROM ourcity9_aip2017_uts.product as p where p.product_id = ?";
        var values = [req.params.id];
        con.query(sql, [values], function (err, rows, fields) {
            if (err){
                console.log('Error while performing Query.');
                return res.send(err);
            }
            console.log('product data retrieved');
            return res.json(rows);
        });
    });

});

router.post('/product/update/:id', function(req, res, next){

    var product = req.body;



    var con = mysql.createConnection({
        host     : 'ourcityshop.com.au',
        user     : 'ourcity9_aip2017',
        password : 'Minmin@1',
        database : 'ourcity9_aip2017_uts'
    });

    con.connect(function(err) {
        if (err) throw err;
        var sql = "UPDATE ourcity9_aip2017_uts.product set product_nm = ?  , description = ?  where product_id = ?";
        var values = [product.product_nm, product.description, product.product_id];
        console.log(values);
        con.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log(result.affectedRows + " record(s) updated");
        });
    });
});


router.get("/flavor/:id",function(req,res){

    var con = mysql.createConnection({
        host     : 'localhost',
        user     : 'aipgroup',
        password : 'aipgroup',
        database : 'aipgroup'
    });

    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT f.flavor_id  , f.flavor_nm FROM aipgroup.flavor as f where f.product_id = ?";
        var values = [req.params.id];
        con.query(sql, [values], function (err, rows, fields) {
            if (err){
                console.log('Error while performing Query.');
                return res.send(err);
            }
            return res.json(rows);
        });
    });

});

router.get("/ingredient/:id",function(req,res){

    var con = mysql.createConnection({
        host     : 'localhost',
        user     : 'aipgroup',
        password : 'aipgroup',
        database : 'aipgroup'
    });

    con.connect(function(err) {
        if (err) throw err;
        var sql = "SELECT i.ingred_id  , i.ingred_nm  , q.quantity  , q.unit from aipgroup.ingredient as i  , aipgroup.ingred_qty as q where i.ingred_id = q.ingred_id and   q.flavor_id = ?";
        var values = [req.params.id];
        con.query(sql, [values], function (err, rows, fields) {
            if (err){
                console.log('Error while performing Query.');
                return res.send(err);
            }
            return res.json(rows);
        });
    });

});



module.exports = router;