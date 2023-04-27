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
                var oModel = this.getView().getModel('MainModel');
                var oData = oModel.getData();

                console.log(oData.title.subTitle)


                // oModel.getProperty("/title/subTitle");

            }
        });
    });
