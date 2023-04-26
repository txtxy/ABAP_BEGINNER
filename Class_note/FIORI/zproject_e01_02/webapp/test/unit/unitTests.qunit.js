/* global QUnit */
QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function () {
	"use strict";

	sap.ui.require([
		"C05/zproject_e01_02/test/unit/AllTests"
	], function () {
		QUnit.start();
	});
});
