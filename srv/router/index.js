/*eslint no-console: 0, no-unused-vars: 0, no-undef:0, no-process-exit:0, new-cap:0*/
/*eslint-env node, es6 */
"use strict";

module.exports = (app, server) => {
	app.use("/node", require("./routes/myNode")());
	app.use("/node/ex2", require("./routes/ex2")());
	let express = require("express");
	app.use("/node/os/web", express.static("os_web"));
	app.use("/node/os", require("./routes/os")());
	app.use("/node/excAsync", require("./routes/exercisesAsync")(server));
};