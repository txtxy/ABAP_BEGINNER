/* global QUnit */
QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function () {
	"use strict";

	sap.ui.require([
		"zproject_e01_08/test/unit/AllTests"
	], function () {
		QUnit.start();
	});
});
