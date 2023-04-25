sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/Select"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("zpeojecte0102.controller.Main", {
            onInit: function () {
                debugger;
                let input1 = this.byId("idInput1") ;
                input1.setValue(10) ;
                let input2 = this.byId("idInput2") ;
                input2.setValue(20) ;
                let select = this.byId("Select1");
                select.setSelectedKey('multiply') 
            },
            onButtonPress: function (oEvent) {
                // alert("오이벤트"+oEvent);
                let sValue1 = this.byId("idInput1").getValue();
                let sValue2 = this.byId("idInput2").getValue();

                alert(sValue1 )
            }
        });
    });
