sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageToast",
    "sap/m/MessageBox"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller,MessageToast,MessageBox) {
        "use strict";

        return Controller.extend("C05.zprojecte0102.controller.Main", {
            onInit: function () {

            },
            onsubmit: function () {
                let inputed = this.byId("idInput").getValue();
                this.byId("idText").setText(inputed);
            },
            onButtonPress: function () {
                debugger;
                let oSelect = this.byId("idSelect1").getSelectedItem(),
                    inum1 = Number(this.byId("idInput1").getValue()),
                    inum2 = Number(this.byId("idInput2").getValue()),
                result = 0 ;

                // oSelect = oSelect.key;
                switch (oSelect.mProperties.key) {
                    case "plus":
                        result = Number(inum1) + Number(inum2);
                        break;
                    case "minus":
                        result = Number(inum1) - Number(inum2);
                        
                        break;
                    case "multiply":
                        result = Number(inum1) * Number(inum2);
                        
                        break;
                    case "divide":
                        result = Number(inum1) / Number(inum2);
                        
                        break;
                    default:
                        break;
                }

                let sMsg = `${inum1} ${oSelect.getText()} ${inum2} = ${result}`
                // MessageToast.show(sMsg);
                // MessageBox.show(sMsg,{
                //     icon: MessageBox.Icon.INFORMATION,                      // 옵션임
                //     title: "My message box title",                          // 옵션임
                //     actions: [MessageBox.Action.YES, MessageBox.Action.NO], // 옵션임
                //     emphasizedAction: MessageBox.Action.YES,                // 옵션임
                //     onClose: function (oAction) { / * do something * / }}) 


             MessageBox.success(sMsg, {
                  title: "Success",                                    // default
                  onClose: null,                                       // default
                  styleClass: "",                                      // default
                  actions: sap.m.MessageBox.Action.OK,                 // default
                  emphasizedAction: sap.m.MessageBox.Action.OK,        // default
                  initialFocus: null,                                  // default
                  textDirection: sap.ui.core.TextDirection.Inherit     // default
              });


            }
        });
    });
