sap.ui.define([
    "sap/ui/core/mvc/Controller"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("zprojectteste0103.controller.HelloPannel", {
            onInit: function () {

            },
            // onHelloPress: function () {
            //     this.loadFragment({
            //         name: "zprojecttest_e01_03.view.fragment.HelloDialog", // 프래그먼트 경로
            //         type: "XML", //프래그먼트 타입
            //         controller:this  // this(본인) 컨트롤러에서 활용 까먹기 쉬우니 꼭 잘 적어라
            //     }
            //     .then(function(oDialog) {
            //         oDialog.open();
            //     }));
            // }
            onHelloPress: function () {
                var oDialog = this.byId("helloDialog");
                oDialog.open
                if (oDialog) {
                    oDialog.open();
                    return; // 함수 완전 종료
                } 

            this.loadFragment({
                name : "zprojectteste0103.view.fragment.HelloDialog"
            }).then((oDialog) => {
                oDialog.open();
            }, this)
        },
        onClose: function (oEvent) {
            var oDialog = oEvent.getSource().getParent();
            oDialog.close();

            }
    }); 
    });
