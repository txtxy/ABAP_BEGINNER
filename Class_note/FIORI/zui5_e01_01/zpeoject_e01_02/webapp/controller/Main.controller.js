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

                // let input1 = this.byId("idInput1") ;
                // input1.setValue(10) ;
                // let input2 = this.byId("idInput2") ;
                // input2.setValue(20) ;
                // let select = this.byId("Select1");
                // select.setSelectedKey('multiply') 
            },
            onclick: function () {
                debugger;
                var oInput = this.byId("idCustomer");
                var oLabel =oInput.getLabels()[0];

                oLabel.getText();
                console.log(oLabel.getText());
            },



            onButtonPress: function (oEvent) {
                // alert("오이벤트"+oEvent);
                // let result = 0;
                // let sValue1 = this.byId("idInput1").getValue();
                // let sValue2 = this.byId("idInput2").getValue();
                // let select = this.byId("Select1").getSelectedItem();
                // select = select.key;

                // switch (select.mProperties.key) {
                //     case "plus":
                //         result = Number(sValue1) + Number(sValue2);
                //         break;
                //         case "minus":
                //         result = Number(sValue1) - Number(sValue2);
                        
                //         break;
                //         case "multiply":
                //         result = Number(sValue1) * Number(sValue2);
                        
                //         break;
                //         case "divide":
                //         result = Number(sValue1) / Number(sValue2);
                        
                //         break;
                //     default:
                //         break;
                // }
                alert(result);
            }
        });
    });
