sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter"

],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, Filter,) {
        "use strict";`                                          `

        return Controller.extend("ux410solving.controller.Main", {
            onInit: function () {
                var oModel = new JSONModel();
                oModel.loadData(sap.ui.require.toUrl("ux410solving/model/datas.json"))
                // //Url경로는 Root Path에서 상대경로임 "Model/data.json"
                this.getView().setModel(oModel, 'typeList');
                // //   모델객처생성,   모델이름 설정
                this.byId("idViewChart").setVizType("bar");
            },
            onSearch: function () {
                var sInputValue = this.byId("idComboBox").getSelectedKey(),
                    oCombo2 = this.byId("idCombo2"),
                    sVizType = oCombo2.getSelectedKey(),
                    oFilter;

                    // setValueState 를 사용해서 벨리데이트 처리할 것
                if (!sVizType) {
                    oCombo2.setValueState("Error");
                    return;
                }

                oCombo2.setValueState("None");

                if (sInputValue) {
                    oFilter = new Filter({
                        path: "OrderID",
                        operator: "EQ",
                        value1: sInputValue
                    });
                }

                // 비즈 프레임에서 사용하는 데이터 셋은 플래튼드 데이터 셋에 data 프로퍼티 값에 바인딩 되어있음 그래서 바인딩을 찾아온 것임
                // <viz:dataset>
                //     <viz.data:FlattenedDataset data="{/Order_Details}">
                //         <viz.data:dimensions></viz:dataset>
                this.byId("idViewChart").getDataset().getBinding("data").filter(oFilter);

                if (sVizType) {
                    this.byId("idViewChart").setVizType(sVizType);
                } else {
                    this.byId("idViewChart").setVizType("bar");
                }


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
                // oEvent.getParameter("data")[0].data에서 선택한 데이터의 값을 알 수 있다,
            }
        })
    });
