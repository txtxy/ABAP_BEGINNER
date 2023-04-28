sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageBox"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, MessageBox) {
        "use strict";

        return Controller.extend("zprojecte0104.controller.Main", {
            onInit: function () {
                let datas = {
                    list: new Array([
                        {
                            num1: new Number,
                            oper: new String,
                            num2: new Number,
                            result: new Number
                        }
                    ])
                }
                this.getView().setModel(new JSONModel(datas), 'MainModel')
                //   모델객처생성,   모델이름 설정
                
            },
            onChange: function () {
                // // var oModel = this.getView().getModel('MainModel');
                // // var oData = oModel.getData();
                // var oModel = this.getView().getModel('MainModel');
                // var oData = oModel.getData();


                // // oData.title.subTitle = 'change Title';


                // // 리스트내부 값 가져오기.
                // // var sText = oData.list[0].name;
                // // this.byId("idText").setText(sText);

                // // oModel.getProperty("/title/subTitle");
                // // 특정 데이터만 경로를 기준으로 호출
                // console.log('변경 전 ', oData.title.subTitle);
                // console.log('변경 전 ', oData.list[4].age);

                // oData.list[4].age = 100;

                // oModel.setProperty("/title/subTitle", "Change Title")

                // oModel.setData(oData);

            },
            onDisplay: function () {
                // var oModel = this.getView().getModel('MainModel');
                // var oData = oModel.getData();

                // console.log('변경 후 ', oData.title.subTitle);
                // console.log('변경 후 ', oData.list[4].age);

            },
            onButtonPress: function () {
                var oModel = this.getView().getModel('MainModel');
                var aList = oModel.getData().list;

                let oSelect = this.byId("idSelect1").getSelectedItem(),
                    inum1 = Number(this.byId("idInput1").getValue()),
                    inum2 = Number(this.byId("idInput2").getValue()),
                    iresult = 0;

                // oSelect = oSelect.key;
                switch (oSelect.mProperties.key) {
                    case "plus":
                        iresult = Number(inum1) + Number(inum2);
                        break;
                    case "minus":
                        iresult = Number(inum1) - Number(inum2);

                        break;
                    case "multiply":
                        iresult = Number(inum1) * Number(inum2);

                        break;
                    case "divide":
                        iresult = Number(inum1) / Number(inum2);

                        break;
                    default:
                        break;
                }
                let operator = oSelect.mProperties.key;

                let sMsg = `${inum1} ${oSelect.getText()} ${inum2} = ${iresult}`;

                // aList.push({
                //     num1: inum1,
                //     oper: operator,
                //     num2: inum2,
                //     result: iresult
                // });
                // oModel.setData(aList);

                MessageBox.success(sMsg, {
                    title: "Success",                                    // default
                    onClose: function (oAction) {
                        if (oAction === 'OK') {

                            aList.push({
                                num1: inum1,
                                oper: operator,
                                num2: inum2,
                                result: iresult
                            });
                            oModel.setProperty("/list",aList);
                        }

                    }


                    ,                                       // default
                    styleClass: "",                                      // default
                    actions: sap.m.MessageBox.Action.OK,                 // default
                    emphasizedAction: sap.m.MessageBox.Action.OK,        // default
                    initialFocus: null,                                  // default
                    textDirection: sap.ui.core.TextDirection.Inherit     // default
                });
            }

        });
    });


    // oModel.setData({num : 30});
// 만약 이런 식으로 데이터 경로 설정 없이 적용하면 
// 모든 데이터가 삭제되고 인자 값이 모델의 값이된다.

