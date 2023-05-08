sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel) {

        "use strict";

        return Controller.extend("ux400solving.controller.Main", {
            formatter: {
                transformDiscontinued: function (oDateDiscontinued) {
                    debugger;
                    // aaa => true false
                    // let oDateDiscontinued = aaa === true ? 'Yes' : 'No';

                    if (oDateDiscontinued == true) {
                        oDateDiscontinued = "Yes"
                    }
                    else {
                        oDateDiscontinued = "No"

                    };

                    // return oData.format(oDateDiscontinued);

                    return oDateDiscontinued
                }
            },
            onInit: function () {
                var oData = {
                    value: []
                };
                var oModel = new JSONModel(oData);
                this.getView().setModel(oModel, "List");
            },
            onRandomPress: function () {
                // var oModel = this.getView().getModel("List");
                // var aList = oModel.getProperty("/value");

                // let ranNum = Math.floor(Math.random() * 100) + 1;
                // this.byId("idInput").setValue(ranNum);


                // oModel.setProperty("/value", [{"text":ranNum}]);
                // aList = oModel.getProperty("/value");


                var oModel = this.getView().getModel("List");
                var aList = oModel.getProperty("/value");

                var ranNum = Math.floor(Math.random() * 100) + 1;
                this.byId("idInput").setValue(ranNum);

                aList.push({
                    text: ranNum
                });
                oModel.setProperty("/value", aList);
            },
            onOpenProduct: function () {
                var oDialog = this.byId("openProduct");

                if (oDialog) {
                    oDialog.open();
                } else {

                    this.loadFragment({
                        name: "ux400solving.view.fragment.Products"
                    }).then((oDialog) => {
                        oDialog.open();
                    }, this) // this를 넣어 준것은 현재 바라보고있는 컨트롤러를 바라보도록한것,
                }

            },
            onClose: function (oEvent) {
                var oDialog = oEvent.getSource().getParent();

                oDialog.close();
            },
            onValueChange: function () {
                debugger;
                var nInputNumber = Number(this.byId("idInput").getValue());

                if (nInputNumber < 100 && nInputNumber > 1) {

                        this.byId("idInput").setValueState(sap.ui.core.ValueState.None)

                } else {
                    this.byId("idInput").setValueState(sap.ui.core.ValueState.Error)
                }


            }
        });
    });
