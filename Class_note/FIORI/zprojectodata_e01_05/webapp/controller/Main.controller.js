sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel) {
        "use strict";

        return Controller.extend("zprojectodatae0105.controller.Main", {
            onInit: function () {

                // 빈껍데기 JSON 모델 생성
                this.getView().setModel(new JSONModel(), "main");

                this._defaultSet();
            },

            // 아래 디폴트 세팅으로 전역변수처럼 활용할 수 있음.
            _defaultSet: function () {
                // OData Model 변수 세팅
                this.oModel = this.getOwnerComponent().getModel();
                // JSON Model 변수 세팅
                this.oMainModel = this.getView().getModel("main");
                // 테이블 객체
                this.oTable = this.byId("idTable");
            },
            onCreate: function () {
                let oData = this.oMainModel.getData();
                        /* OData=>{ 
                            Productno : 
                            Productname : 
                            Fname : 
                            Lname : 
                            Memo : 
                        }
                        */
                oData.Productno = Number(oData.Productno)
                        // HTTP 리퀘스트를 위한 BODY 생성
                        // create 요청은 POST 요청임.
                this.oModel.create("/Products", oData, {
                    success: function () {
                        sap.m.MessageToast.show("Create Success!")
                    },
                    error: function () {

                        sap.m.MessageToast.show("Error Ocured!")

                    }
                });
                // 패스 , 바디 정보 , 성공실패 로직 처리
            },
            onUpdate: function () {
                let jsonData = this.oMainModel.getProperty("/");
                let sFullPath = this.oModel.createKey("/Products", {
                    Productno: jsonData.Productno
                });
                //sFullPath ==> "/Produycts(poroductno =jsonData.Productno"
                //sFullPath는 문자열과 변수로 생성할 수도 있음
                // 예시 ) sFullPath = /Produycts("poroductno ="+ 변수)
                this.oModel.update(sFullPath, jsonData, {
                    success: function () {
                        sap.m.MessageToast.show("변경되었습니다.");

                    }

                })
            },
            onDelete: function () {
                let index = this.oMainModel.getProperty("/Productno");
                let sFullPath = this.oModel.createKey("/Products", {
                    Productno: Number(index)
                });
                this.oModel.remove(sFullPath, {
                    success: function () {
                        sap.m.MessageToast.show("삭제되었습니다.")

                    }
                });
            },
            onReadEntity: function () {
                let index = this.oTable.getSelectedIndex();
                let sPath = this.oTable.getContextByIndex(index).getPath();
                debugger;

                // 전체 경로 값을 저장하는 로직
                // let sFullPath = this.oModel.createKey("/Products",{
                //     Productno: 2
                // });

                // "/Products(2)" 와 동일한 의미이다.
                // 위 변수를 키값으로 패스에 넣어준다.
                // this.oModel.read("/Products",{
                //     success:function (oReturn) {
                //     console.log("READ ALL : ",oReturn);
                //     }
                //     })
                // ODataMode v2 => read(); 메쏘드를 활용한 것임
                // 다건 조회를 위해서는 sPath 대신에 "/Products"로 변경하면 됨.
                this.oModel.read(sPath, {
                    // filter : [필터 모델 객체],
                    success: function (oReturn) {

                        // console.log("READ : ",oReturn);
                        this.byId("grid").getContent(oReturn);
                        // this.oMainModel().setProperty("/", oReturn);  
                        // 조회 데이터는 JSON으로 받아진다.
                        this.oMainModel.setData(oReturn);
                        /*
                        oReturn =>{ 
                            Productno : 
                            Productname : 
                            Fname : 
                            Lname : 
                            Memo : 
                        }
                        */

                        //현재 사용하고 싶은 Controller 객체로 this를 활용핫기위해 }.bind(this)
                    }.bind(this)
                })
            },
            onRefresh: function () {
                this.oModel.refresh(true);
            }
        });
    });
