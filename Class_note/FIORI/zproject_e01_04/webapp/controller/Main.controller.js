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




                // 1. 외부 데이터 호출 방식
                // var oModel = new JSONModel('MainModel');
                // oModel.loadData(sap.ui.require.toUrl("zprojecte0104/model/data.json"))
                // //Url경로는 Root Path에서 상대경로임 "Model/data.json"
                // this.getView().setModel(oModel, 'MainModel')
                // //   모델객처생성,   모델이름 설정


                // 2. 기본 방식
                //   모델객처생성(어떤 데이터 사용할지?),   모델이름 설정
                let datas = {
                    title: {
                        title: 'Json Title',
                        subTitle: 'JSON Sub Title'
                    },
                    list: [
                        {
                            "num1": 30,
                            "oper": "plus",
                            "num2": 10,
                            "result": 40
                        }
                    ],
                    todo: [
                        { Content: 'test' }
                    ]
                }
                this.getView().setModel(new JSONModel(datas), 'MainModel');
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
                            oModel.setProperty("/list", aList);
                        }

                    }


                    ,                                       // default
                    styleClass: "",                                      // default
                    actions: sap.m.MessageBox.Action.OK,                 // default
                    emphasizedAction: sap.m.MessageBox.Action.OK,        // default
                    initialFocus: null,                                  // default
                    textDirection: sap.ui.core.TextDirection.Inherit     // default
                });
            },
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            onSubmitDialogPress: function () {
                if (!this.oSubmitDialog) {
                    this.oSubmitDialog = new Dialog({
                        type: DialogType.Message,
                        title: "Confirm",
                        content: [
                            new Label({
                                text: "Do you want to submit this order?",
                                labelFor: "submissionNote"
                            }),
                            new TextArea("submissionNote", {
                                width: "100%",
                                placeholder: "Add note (required)",
                                liveChange: function (oEvent) {
                                    var sText = oEvent.getParameter("value");
                                    this.oSubmitDialog.getBeginButton().setEnabled(sText.length > 0);
                                }.bind(this)
                            })
                        ],
                        beginButton: new Button({
                            type: ButtonType.Emphasized,
                            text: "Submit",
                            enabled: false,
                            press: function () {
                                var sText = Core.byId("submissionNote").getValue();
                                MessageToast.show("Note is: " + sText);
                                this.oSubmitDialog.close();
                            }.bind(this)
                        }),
                        endButton: new Button({
                            text: "Cancel",
                            press: function () {
                                this.oSubmitDialog.close();
                            }.bind(this)
                        })
                    });
                }

                this.oSubmitDialog.open();
            },
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
            onAdd: function () {
                var oDialog = this.byId("addDialog");



                if (oDialog) {
                    oDialog.open();
                } else {

                    this.loadFragment({
                        name: "zprojecte0104.view.fragment.AddDialog"
                    }).then((oDialog) => {
                        oDialog.open();
                    }, this) // this를 넣어 준것은 현재 바라보고있는 컨트롤러를 바라보도록한것,
                }
            },
            onAddPress: function () {
                push({
                    num1: inum1,
                    oper: operator,
                    num2: inum2,
                    result: iresult
                });
                oModel.setProperty("/list", aList);

            },
            onClose: function (oEvent) {
                var oDialog = oEvent.getSource().getParent();
                var oModel = this.getView().getModel('MainModel');
                var aTodos = oModel.getProperty("/todo");
                //// 1 번째 방법 oDialog에서 직접 값을 가져오는 방법
                // var sValue = oDialog.getContent()[0].getItems()[1].getValue();
                //// 2 번째 방법 인풋에다가 root모델을 연결하기
                //// 바인딩 된 데이터를 sValue에 할당하여 활용하는 방법이다.
                var sValue = this.getView().getModel("root").getProperty("/Value")

                if (sValue) {
                    aTodos.unshift({ Content : sValue })
                    oModel.setProperty("/todo",aTodos);

                }
                oDialog.close();
            },
            onBeforeOpen: function () {
                this.byId("addInput").setValue();
            },
            onDelete: function () {
                var oTable = this.byId("todoTable");
                var oModel = this.getView().getModel("MainModel");

                var aSelectedIndices =   oTable.getSelectedIndices();  //테이블 인덱스 가져오는 함수
                var aDatas = oModel.getProperty("/todo");  // 데이터 가져오기
                // 단건 삭제
                // aDatas.splice(aSelectedIndices[0],1) ;   //(인덱스값, 대체 값)
                // oModel.setProperty("/todo", aDatas)


                // 선택 로우 삭제
                for (let i = (aSelectedIndices.length-1); i > -1; i--) {
                    // let element = aSelectedIndices[i];
                    aDatas.splice(aSelectedIndices[i],1) 
                    
                }
                
                oModel.setProperty("/todo", aDatas)
                }

            }
        
        );
    });


    // oModel.setData({num : 30});
// 만약 이런 식으로 데이터 경로 설정 없이 적용하면 
// 모든 데이터가 삭제되고 인자 값이 모델의 값이된다.

