/* global QUnit */
QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function () {
	"use strict";

	sap.ui.require([
		"ux410_solving/test/unit/AllTests"
	], function () {
		QUnit.start();
	});
});
