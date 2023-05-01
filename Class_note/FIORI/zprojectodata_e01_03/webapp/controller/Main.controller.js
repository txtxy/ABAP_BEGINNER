sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("nt.zprojectodatae0103.controller.Main", {
            formatter : {
                onSum : function (a,b) {
                    return a+b;
                    
                }
            },
            onInit: function () {

            }
        });
    });
