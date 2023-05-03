sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter",
    "sap/ui/model/json/JSONModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller, JSONModel,} Controller
     */
    function (Controller, JSONModel, Filter) {
        "use strict";

        return Controller.extend("zprojectodatae0104.controller.Detail", {
            onInit: function () {
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.getRoute("RouteDetail").attachPatternMatched(this._onPatternMatched, this)

                   // detail을 이름으로하는 빈 모델 객체 생성 
                /*
                    data:{}
                */


                oView.setModel(new JSONModel(),"detail");
                // 아직 값을 하나도 넣지 않았는데 패턴 매칭 성공 이후에 값을 넣을 예정임
            },
            _onPatternMatched: function (oEvent) {
                var oView = oView
                var oArgu = oEvent.getParameter("arguments");
                var oDetailModel = oView.getModel('detail');
                // 이벤트 객체 안에 arguments 라는 프로퍼티가 존재하고 그  안에 키값이 존재한다.
                var oModel = oView.getModel(); //Northwind Odata Model (메니페스트ㅔㅇ 존재하는 이름 없는 모델임.)
                var oFilter = new sap.ui.model.Filter({
                    path: "OrderID",
                    opener: "EQ",
                    value1: oArgu.key
                });
                console.log(oArgu); // {key : 10248}


                this,getView().setBusy(true);
                // GET :    
                // .../Northwind.svc/Oders?$filter=OrderID eq 10248
                // 아래 내용은 위와 같음

                oModel.read("/Orders", {
                    urlParameters: {
                        '$expand': 'Customer'
                    },
                    filters: [oFilter],
                    success: function (oReturn) {
                        oView.setBusy(false);
                        console.log(oReturn.result[0]); // 한건의 데이터만 챙긴다는 의미 , 이 떼 result 안에는 객체가 존재함
                        // 여기서 안된이유는 석세스 함수 안에서는 this가 포인팅하는 객체가 다르다
                        // 왜냐면 success함수느 ㄴ비동기적으로 작동하기에 메인 프로세스와 별개의 흐름인다.
                        //oDetailModel = oView.setModel(oModel(), 'detail')
                        // 여기서 this는 이 컨트롤러를 의미하지 않는다.
                        // 만약에 여기서 tthis를 사용하고자 한다면
                        // 변수를 사용하거나 펑션 끝에 "}.bind(this)" 적어주면된다.
                        oDetailModel.setProperty("/data",oReturn.result[0])
                        // 모델 내부 데이터 변수
                        // 이제 화면에 표시하고 싶으면 바딩 작업이 필요하다,
                        
                    },
                    error: function () {
                        oView.setBusy(false);
                        sap.m.MessageToast.show('에러 발생');

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