sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller,JSONModel) {
        "use strict";

        return Controller.extend("zprojectodatae0105.controller.Main", {
            onInit: function () {
                
                // 빈껍데기 JSON 모델 생성
                this.getView().setModel(new JSONModel(),"main");

            }
        });
    });
