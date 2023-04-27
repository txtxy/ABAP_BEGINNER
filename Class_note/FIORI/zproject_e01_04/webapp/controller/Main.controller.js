sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel) {
        "use strict";

        return Controller.extend("zprojecte0104.controller.Main", {
            onInit: function () {
                let datas = {
                    title: {
                        title: 'Json Title',
                        subTitle: 'JSON Sub Title'
                    },

                    list: [
                        { name: 'moon', age: 20 },
                        { name: 'hong', age: 21 },
                        { name: 'kim', age: 22 },
                        { name: 'park', age: 23 },
                        { name: 'song', age: 24 },
                    ]
                }
                this.getView().setModel(new JSONModel(datas), 'MainModel');
                //   모델객처생성,   모델이름 설정

            },
            onChange: function () {
                // var oModel = this.getView().getModel('MainModel');
                // var oData = oModel.getData();
                var oModel = this.getView().getModel('MainModel');
                var oData = oModel.getData();

                
                // oData.title.subTitle = 'change Title';
                
                
                // 리스트내부 값 가져오기.
                // var sText = oData.list[0].name;
                // this.byId("idText").setText(sText);
                
                // oModel.getProperty("/title/subTitle");
                // 특정 데이터만 경로를 기준으로 호출
                console.log('변경 전 ',oData.title.subTitle);
                console.log('변경 전 ', oData.list[4].age);
                
                oData.list[4].age = 100;
                
                oModel.setProperty("/title/subTitle", "Change Title")
                
                oModel.setData(oData);
                
            },
            onDisplay: function () {
                var oModel = this.getView().getModel('MainModel');
                var oData = oModel.getData();
                
                console.log('변경 후 ',oData.title.subTitle);
                console.log('변경 후 ', oData.list[4].age);

            }

        });
    });


    // oModel.setData({num : 30});
// 만약 이런 식으로 데이터 경로 설정 없이 적용하면 
// 모든 데이터가 삭제되고 인자 값이 모델의 값이된다.

