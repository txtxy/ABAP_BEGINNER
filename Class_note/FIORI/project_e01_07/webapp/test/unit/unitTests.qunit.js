/* global QUnit */
QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function () {
	"use strict";

	sap.ui.require([
		"project_e01_07/test/unit/AllTests"
	], function () {
		QUnit.start();
	});
});
