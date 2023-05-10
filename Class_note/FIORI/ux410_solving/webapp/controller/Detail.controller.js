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
                // 라우터 패턴이 일치할 떄마다_onRoutePatternMatched() 실행
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



                // // 리드 구문을 통해 서버와의 통신으로 데이터 가져오기
                // oModel.read("/Order_Details", { // 이렇게하면 전체 데이터를 가져오는 것임
                // // oModel.read(sBindPath, {// 대신에 이렇게하면 한건의 데이터만 서버에서 가져옴
                //     success: function (oReturn) {
                //         // oReturn 안에 조회 데이터가 들어오게 됨.(JSON 데이터 형식)
                //         // 해당 데이터를 가지고 데이터 가공을 할 수 있음

                //         // 이렇게 Success 함수안에서 데이터 핸들링을 시도해야 정상적으로 READ 된 다음에 데이터 처리함
                // }

            }

            // 여기에다가 데이터 핸들링하면 오류 발생
        })





    });
    