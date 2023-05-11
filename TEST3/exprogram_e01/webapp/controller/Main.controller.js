sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter",
    "sap/m/Dialog",
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, Filter, Dialog) {
        "use strict";

        return Controller.extend("exprograme01.controller.Main", {
            onInit: function () {
                var oModel = new JSONModel();
                oModel.loadData(sap.ui.require.toUrl("exprograme01/model/currcode.json"))
                this.getView().setModel(oModel, 'currcode');


            },
            onSearch: function () {
                var sInputValue = this.byId("comboCurrency").getSelectedKey(),
                    oInputname = this.byId("inpurCarrier").getValue(),
                    oFilter;

                // setValueState 를 사용해서 벨리데이트 처리할 것

                if (!sInputValue) {

                    oFilter = new Filter({

                        path: 'Carrname',
                        operator: "Contains",
                        value1: oInputname,
                        and: true
                    });
                    this.byId("carrTable").getBinding("rows").filter([oFilter]);
                } else {


                    oFilter = new Filter({
                        filters: [
                            new Filter({
                                path: 'Currcode',
                                operator: "EQ",
                                value1: sInputValue
                            }),
                            new Filter({
                                path: 'Carrname',
                                operator: "Contains",
                                value1: oInputname
                            })
                        ],
                        and: true
                    });

                    this.byId("carrTable").getBinding("rows").filter([oFilter]);



                }
            },

            onDetail: function (oEvent) {
                
                var oDialog = this.byId("openDetail");

                var sPath = oEvent.getSource().getBindingContext().getPath();
                var oModel = oEvent.getSource().getBindingContext().getModel();

                oModel.read(sPath, {
                    urlParameters: { $expand: "to_Item" },
                    success: function (oData) {
                      if (oDialog) {

                        oDialog.setModel(oModel);
                        oDialog.bindElement({
                          path: sPath,
                          model: oModel
                        });
                        oDialog.open();
                      } else {
                        this.loadFragment({
                          name: "exprograme01.view.fragment.Detail"
                        }).then(function (oDialog) {

                          oDialog.setModel(oModel);
                          oDialog.bindElement({
                            path: sPath,
                            model: oModel
                          });
                          oDialog.open();
                        }.bind(this));
                      }
                    }.bind(this)
                })
               

            },

            onClose: function (oEvent) {
                var oDialog = oEvent.getSource().getParent();

                oDialog.close();
            },
            onBeforeOpen: function (oEvent) {

            }
        });
    });
