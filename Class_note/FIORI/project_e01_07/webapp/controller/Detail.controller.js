sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("projecte0107.controller.Detail", {
            onInit: function () {
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.getRoute("RouteDetail").attachPatternMatched(this._onPatternMatched, this) // URL 패턴이 맞으면 _onPatternMatched 함수 호출
            },
            // 패턴이 맞을 떄마다 실행해라!
            _onPatternMatched : function (oEvent) {
                // oEvent.getParameters().arguments
                var oArgu = oEvent.getParameter("arguments");  
                 //파라미터 내부 arguments 내부에 URL 파라미터정보인 aa, bb가 담겨있다.
                console.log(oArgu);
            },
            onNavButtonPress : function () {
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("RouteMain", {}, true);
                // navTo(1,2,3)
                //      1: Router Name
                //      2: Parameters
                //      3: Route History Clear
            }

        });
    });