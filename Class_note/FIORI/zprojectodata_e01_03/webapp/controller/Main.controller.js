sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, Filter) {
        "use strict";

        return Controller.extend("nt.zprojectodatae0103.controller.Main", {
            formatter: {
                onSum: function (a, b) {
                    return a + b;

                },
                dateTime: function (oDate) {
                    // console.log(oDate);
                    // JS에서 월은 {0 : 1월} 값으로 진행됨 
                    let oDateTimeInstance;
                    oDateTimeInstance =
                        sap.ui.core.format.DateFormat.getDateTimeInstance({
                            pattern: 'yyyy-MM-dd HH:mm'
                        }
                        );
                    return oDateTimeInstance.format(oDate);
                }
            },
            onInit: function () {

            },
            onSearch: function () {


                let oOrderDate = this.byId("idOrderDate").getDateValue();
                let sInputValue = Number(this.byId("idOrderID").getValue());

                let oFilter = new Filter({
                    filters: [
                        {
                            path: 'OderID',
                            operator: "EQ",
                            value1: sInputValue
                        },
                        {
                            path: 'OrderDate',
                            operator: "GE",
                            value1: oOrderDate
                        }
                    ],
                    and: true
                });

                this.byId("idProductsTable").getBinding("items").filter([oFilter])

                // // 필터 객체 생성
                // let oOrderDate = this.byId("idOrderDate");
                // let sInputValue = Number(this.byId("idOrderID").getValue()),

                //     oFilter = new sap.ui.model.Filter("OrderID","EQ",sInputValue),
                //     // oFilter = new sap.ui.model.Filter(경로,조건,값),
                //     aFilter = [];                

                //     let oODateFilter = new sap.ui.model.Filter("OrderDate","GE",oOrderDate.getDateValue())

                //     aFilter.push(oFilter);
                //     aFilter.push(oODateFilter)

                // this.byId("idProductsTable").getBinding("items").filter(aFilter)
                // // this.byId(테이블).getBinding("아이템즈").filter("필터객체")

            }
        });
    });
