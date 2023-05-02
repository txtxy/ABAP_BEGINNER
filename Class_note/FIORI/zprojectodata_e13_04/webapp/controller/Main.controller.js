sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, Filter) {
        "use strict";

        return Controller.extend("zprojectodatae1304.controller.Main", {
            formatter: {
            dateTime : function (oDate) {
                let oDateTimeInstance;
                oDateTimeInstance = sap.ui.core.format.DateFormat.getDateTimeInstance({
                    pattern : 'yyyy-MM-dd hh:mm:ss'
                });

                return oDateTimeInstance.format(oDate);
            }},
            onInit: function () {

            },
            onSelectionChange: function(oEvent) {
                var oRouter = this.getOwnerComponent().getRouter();   //getOwnerComponent init에서 잘 쓸 수 있다.
                var sPath = oEvent.getParameters().listItem.getBindingContextPath();
                var sKey = this.getView().getModel().getProperty(sPath+'/OrderID');

                oRouter.navTo("RouteDetail", {
                    "key" : sKey
                });
            },
            onValueHelpRequest : function () {
                // CustomerDialog.fragment.xml 오픈
                //    해당 Dialog 안에 sap.ui.table.Table. 세팅후,
                //    /Customers 바인딩한다. 표시할 필드는 CustomerID , CompanyName
                //    팝엡에 close 버튼을 구성하여 킬릭시 팝업이 닫히도록한다.
                sap.m.MessageToast.show("input value help 실행!")
            },
            onValueHelpRequest: function() {
                var oDialog = this.byId("Dialog");
                if (oDialog) {
                    oDialog.open();
                    return;
                }else{
                this.loadFragment({
                    name: "zprojectodatae1304.view.fragment.CustomerDialog"
                }).then(function(oDialog) {
                    oDialog.open();
                }, this); // this는 현재컨트롤러를 바라보게
                }
            },
            onClose: function() {
                this.byId("Dialog").close();
            },
            rowSelectionChange: function (oEvent) {
                var oDialog = oEvent.getSource().getParent();
                var sPath = oEvent.getParameter("rowContext").sPath;
                var sKey = this.getView().getModel().getProperty(sPath+'/CustomerID');
                this.byId("Input").setValue(sKey);
                this._search(sKey);
                oDialog.close();
                
            },
            _search: function (sKey) {

                let oFilter = new Filter({
                    filters: [
                        new Filter({ path : 'CustomerID', operator : 'EQ', value1: sKey})],
                        and : true
                }); 
                this.byId("idProductsTable").getBinding("items").filter([oFilter]);
    }});
    });
