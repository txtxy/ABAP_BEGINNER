sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
/**
* @param {typeof sap.ui.core.mvc.Controller} Controller
**/
function (Controller) {
"use strict";

return Controller.extend("zprojectodatae0104.controller.Main", {
formatter: {
    onSum: function (a, b) {
        return a + b;
    },
    dateTime: function (oDate) {
        let oDateTimeInstance;

        oDateTimeInstance =
            sap.ui.core.format.DateFormat.getDateTimeInstance({
                pattern: 'yyyy-MM-dd hh:mm:ss'
            });

        return oDateTimeInstance.format(oDate);
    },
},
onInit: function () {

},
onRowPress: function (oEvent) {
    //row 클릭시 Detail 화면으로
    var oRouter = this.getOwnerComponent().getRouter();
    var sPath = oEvent.getParameters().listItem.getBindingContextPath();
    var sKey = this.getView().getModel().getProperty(sPath+'/OrderID')
    debugger;
    oRouter.navTo("RouteDetail",{
        "key": sKey
    });

},
onValueHelpRequest: function() {
    /*
        CustomerDialog.fragment.xml 오픈

        해당 Dialog 안에 sap.ui.table.Table 세팅 후,
        /Customers 바인딩한다. 표시한 필드는 CustomerID, CompanyName
        팝업에 close 버튼을 구성하여 클릭 시 팝업이 닫히도록 한다.
        sap.m.MessageToast.show("input value help 실행!");
    */
    var oDialog = this.byId("Dialog");
    if (oDialog) {
        oDialog.open();
        return;
    }

    this.loadFragment({
        name: "zprojectodatae0104.view.CustomerDialog"
    }).then(function(oDialog) {
        oDialog.open();
    }, this); // this는 현재컨트롤러를 바라보게
    
},
onClose: function(){
    this.byId("Dialog").close();
},
})
});