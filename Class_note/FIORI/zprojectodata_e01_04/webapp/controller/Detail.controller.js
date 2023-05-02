sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("zprojectodatae0104.controller.Detail", {
            onInit: function () {
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.getRoute("RouteDetail").attachPatternMatched(this._onPatternMatched, this)
            },
            _onPatternMatched: function (oEvent) {
                var oArgu = oEvent.getParameter("arguments");
                var oModel = this.getView().getModel(); //Northwind Odata Model
                var oFliter = new sap.ui.model.Fliter("OrderID", "EQ","oArgu.key");
                console.log(oArgu); // {key : 10248}

                oModel.read("/Orders",{
                    filters: [oFliter],
                    success: function(oReturn){
                         console.log(oReturn.results[0]);
                    }
                });

            },

            onNavButtonPress: function () {
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("RouteMain", {}, true);
                // NavTo(1,2,3)
                // 1: Route Name
                // 2: Parameters
                // 3: Route History Clear
            },

        });
    });