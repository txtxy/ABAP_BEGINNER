sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageBox"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller,JSONModel,MessageBox) {
        "use strict";

        return Controller.extend("zprojecte0106.controller.Main", {
            onInit: function () {
                // var oModel = new JSONModel(sap.ui.require.toUrl("sap/ui/demo/mock/products.json"));
                // this.getView().setModel(oModel);
  
            // 1. 외부 데이터 호출 방식
            var oModel = new JSONModel('MainModel');
            oModel.loadData(sap.ui.require.toUrl("zprojecte0106/model/data.json"))
            //Url경로는 Root Path에서 상대경로임 "Model/data.json"
            this.getView().setModel(oModel, 'MainModel')
            //   모델객처생성,   모델이름 설정

            },
            getPage : function() {
                return this.byId("dynamicPageId");
            },
            onToggleFooter: function () {
                this.getPage().setShowFooter(!this.getPage().getShowFooter());
            },
            toggleAreaPriority: function () {
                var oTitle = this.getPage().getTitle(),
                    sNewPrimaryArea = oTitle.getPrimaryArea() === DynamicPageTitleArea.Begin ? DynamicPageTitleArea.Middle : DynamicPageTitleArea.Begin;
                oTitle.setPrimaryArea(sNewPrimaryArea);
            },
            // onPressOpenPopover: function (oEvent) {
            //     var oView = this.getView(),
            //         oSourceControl = oEvent.getSource();
    
            //     if (!this._pPopover) {
            //         this._pPopover = Fragment.load({
            //             id: oView.getId(),
            //             name: "sap.f.sample.DynamicPageFreeStyle.view.Card"
            //         }).then(function (oPopover) {
            //             oView.addDependent(oPopover);
            //             return oPopover;
            //         });
            //     }
    
            //     this._pPopover.then(function (oPopover) {
            //         oPopover.openBy(oSourceControl);
            //     });
            // }
            onAdd: function () {
                var oDialog = this.byId("addDialog");



                if (oDialog) {
                    oDialog.open();
                } else {

                    this.loadFragment({
                        name: "zprojecte0106.view.fragment.AddDialog"
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
                    aTodos.unshift({ Content: sValue })
                    oModel.setProperty("/todo", aTodos);

                }
                oDialog.close();
            },
            onBeforeOpen: function () {
                this.byId("addInput").setValue();
            },
            onDelete: function () {
                var oTable = this.byId("todoTable");
                var oModel = this.getView().getModel("MainModel");

                var aSelectedIndices = oTable.getSelectedIndices();  //테이블 인덱스 가져오는 함수
                var aDatas = oModel.getProperty("/todo");  // 데이터 가져오기
                // 단건 삭제
                // aDatas.splice(aSelectedIndices[0],1) ;   //(인덱스값, 대체 값)
                // oModel.setProperty("/todo", aDatas)

                MessageBox.confirm('정말 삭제하시겠습니까?', {
                    title: "Delect",                                    // default
                    onClose: function (oAction) {
                        if (oAction === 'OK') {
                            // 선택 로우 삭제
                            for (let i = (aSelectedIndices.length - 1); i >= 0; i--) {
                                // let element = aSelectedIndices[i];
                                aDatas.splice(aSelectedIndices[i], 1)

                            }

                            oModel.setProperty("/todo", aDatas)
                        }

                    },
                    styleClass: "",                                      // default
                    actions: sap.m.MessageBox.Action.OK,                 // default
                    emphasizedAction: sap.m.MessageBox.Action.OK,        // default
                    initialFocus: null,                                  // default
                    textDirection: sap.ui.core.TextDirection.Inherit     // default
                });

            },
            onRowDelete: function (oEvent) {
                var oModel = this.getView().getModel("MainModel");
                var aDatas = oModel.getProperty("/todo");  // 데이터 가져오기
                var index = oEvent.getParameters().row.getIndex();
                
                MessageBox.confirm('정말 삭제하시겠습니까?', {
                    title: "Delect",                                    // default
                    onClose: function (oAction) {
                        if (oAction === 'OK') {

                            aDatas.splice(index, 1);   //(인덱스값, 대체 값)
                            oModel.setProperty("/todo", aDatas)
                        }

                    },
                    styleClass: "",                                      // default
                    actions: sap.m.MessageBox.Action.OK,                 // default
                    emphasizedAction: sap.m.MessageBox.Action.OK,        // default
                    initialFocus: null,                                  // default
                    textDirection: sap.ui.core.TextDirection.Inherit     // default
                });

            }
        });
    });
