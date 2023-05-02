sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("zprojectodatae1304.controller.Detail", {
            onInit: function () {
                    var oRouter = this.getOwnerComponent().getRouter();
                    oRouter.getRoute("RouteDetail").attachPatternMatched(this._onPatternMatched, this);
            },
            _onPatternMatched: function (oEvent) {
            var oArgu =  oEvent.getParameter("arguments")
            var oModel = this.getView().getModel();
            var oFilter = new sap.ui.model.Filter('OrderID', 'EQ', oArgu.key);
            console.log(oArgu);

            oModel.read("/Orders", {
                filters : [oFilter],
                success: function (oReturn) {
                    console.log(oReturn.results[0]);
                }
            })
            console.log("pattern matched funtion");
            },
            onNavButtonPress: function () {
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("RouteMain", {}, true);
                // navTo(1,2,3,)
                // 1: Route Name
                // 2: parameters
                // 3: route history clear
            }
            
        });
        
    });
