/*eslint no-console: 0, no-unused-vars: 0, no-undef:0, no-process-exit:0, new-cap:0*/
/*eslint-env node, es6 */

"use strict";

var express = require("express");
var async = require("async");

module.exports = function() {
	var app = express.Router();
	
	//Hello Router
	app.get("/Hi", (req, res) => {
		res.send("Hello World Node.js");
	});
	
	return app;
};