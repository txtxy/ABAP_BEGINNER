sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller,JSONModel,Filter) {
        "use strict";

        return Controller.extend("exprograme01.controller.Main", {
            onInit: function () {
                var oModel = new JSONModel();
                oModel.loadData(sap.ui.require.toUrl("exprograme01/model/currcode.json"))
                this.getView().setModel(oModel, 'currcode');


            },
            onSearch : function () {
                var sInputValue = this.byId("comboCurrency").getSelectedKey(),
                oInputname = this.byId("inpurCarrier").getValue(),
                oFilter;

                // setValueState 를 사용해서 벨리데이트 처리할 것

            if (!sInputValue) {
                
            oFilter = new Filter({
                
                    path: 'Carrname',
                    operator: "Contains",
                    value1: oInputname
                
            ,
            and: true});
            this.byId("carrTable").getBinding("rows").filter([oFilter]);
        }else{
            

            oFilter = new Filter({
                filters: [
                    new Filter( {
                        path: 'Currcode',
                        operator: "EQ",
                        value1: sInputValue
                    }),
                    new Filter( {
                        path: 'Carrname',
                        operator: "Contains",
                        value1: oInputname
                    })
                ],
                and: true
            });

            this.byId("carrTable").getBinding("rows").filter([oFilter]);



        }
            }
        });
    });
