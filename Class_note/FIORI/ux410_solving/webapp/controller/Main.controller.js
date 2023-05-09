sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter",
    "sap/viz/ui5/controls/VizFrame"

],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, Filter, VizFrame) {
        "use strict";

        return Controller.extend("ux410solving.controller.Main", {
            onInit: function () {
                var oModel = new JSONModel();
                oModel.loadData(sap.ui.require.toUrl("ux410solving/model/datas.json"))
                // //Url경로는 Root Path에서 상대경로임 "Model/data.json"
                this.getView().setModel(oModel, 'typeList')
                // //   모델객처생성,   모델이름 설정
                this.byId("idViewChart").setVizType("bar")
            },
            onSearch: function () {
                var sInputValue = this.byId("idComboBox").getSelectedKey(),
                    sVizType = this.byId("idCombo2").getSelectedKey(),
                    oFilter;

                if (!sVizType) {
                    this.byId("idCombo2").setValueState("Error");
                    return;
                }

                this.byId("idCombo2").setValueState("None");
                if (sInputValue) {
                    oFilter = new Filter({
                        path: "OrderID",
                        operator: "EQ",
                        value1: sInputValue
                    });
                }

                this.byId("idViewChart").getDataset().getBinding("data").filter(oFilter);

                if (sVizType) {
                    this.byId("idViewChart").setVizType(sVizType);
                } else {
                    this.byId("idViewChart").setVizType("bar");
                }
                // setValueState 를 사용해서 벨리데이트 처리할 것
            },
            onChartSelectData: function (oEvent) {
                const oComponent = this.getOwnerComponent(),
                    oRouter = oComponent.getRouter(),
                    oData = oEvent.getParameter("data")[0].data,
                    oVizFrame = this.byId("idViewChart");

                oVizFrame.vizSelection(oData, { clearSelection: true });
                oRouter.navTo("RouteDetail", {
                    OrderID: oData.OrderID,
                    ProductID: oData.ProductID
                })

                //oEvent.getParameter() 에서 데이터 배열을 확인할수 있고
                // oEvent.getParameter("data")[0].data에서 선택한 데이터의 값을 알 ㅅ ㅜ있다,
            }
        })
    });
