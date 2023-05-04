sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel) {
        "use strict";

        return Controller.extend("zprojecte0108.controller.Main", {
            onInit: function () {
                this._setChartInView();
            },
            _setChartInView: function () {
                var oData = {
                    list: [
                        
                        { name: '국어', rate: '100' },
                        { name: '영어', rate: '50' },
                        { name: '수학', rate: '80' },
                        { name: '도덕', rate: '80' },
                        { name: '체육', rate: '70' }

                    ]

                };
                this.getView().setModel(new JSONModel(oData), "view");
            }
        });
    });
