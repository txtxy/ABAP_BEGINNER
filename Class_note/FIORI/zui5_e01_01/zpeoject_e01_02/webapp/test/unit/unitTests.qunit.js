/* global QUnit */
QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function () {
	"use strict";

	sap.ui.require([
		"zpeoject_e01_02/test/unit/AllTests"
	], function () {
		QUnit.start();
	});
});
