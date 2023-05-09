sap.ui.define([
    "sap/ui/core/mvc/Controller"

],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";
        return Controller.extend("ux410solving.controller.Detail", {
            onInit: function () {
                const oComponent = this.getOwnerComponent(),
                    oRouter = oComponent.getRouter();

                oRouter
                    .getRoute("RouteDetail")
                    .attachPatternMatched(this._onRoutePatternMatched, this);
            },

            _onRoutePatternMatched: function (oEvent) {
                debugger;
                const oView = this.getView(),
                    oModel = oView.getModel(),
                oArgs = oEvent.getParameter("arguments") // 이벤트 객체에 파라미터 정보가 있음


                // '/Order_Details(OrderID = 10248,ProductID = 72) '를 sBindPath변수에 담기
                let sBindPath = oModel.createKey("/Order_Details", {

                    OrderID: oArgs.OrderID,
                    ProductID: oArgs.ProductID
                
                });
                oView.bindElement(sBindPath); // 뷰에다가 기준데이터 세팅
                // 위 바인딩 방법을 Element Binding  또는 Context Binding 이라고 함
            }





        });
    });