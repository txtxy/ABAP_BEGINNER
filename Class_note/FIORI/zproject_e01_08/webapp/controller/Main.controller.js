sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/viz/ui5/data/FlattenedDataset",
    "sap/viz/ui5/controls/common/feeds/FeedItem"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel, FlattenedDataset, FeedItem) {
        "use strict";

        return Controller.extend("zprojecte0108.controller.Main", {
            onInit: function () {
                this._setChartInView();
                this._setChartInController();
            },
            _setChartInController: function () {

                // 차트 데이터 세팅
                var oData = {
                    sales: [
                        { product: "Jackets", amount: "65" },
                        { product: "Shirts", amount: "70" },
                        { product: "Pants", amount: "83" },
                        { product: "Coats", amount: "92" },
                        { product: "Purse", amount: "77" }

                    ]

                }
                // 차트 Model 생성
                this.getView().setModel(new JSONModel(oData), "cont");

                // 차트 Control 세팅

                var oChart = this.byId("idConChart");
                // 차트 dataset 정보 세팅
                var oColDataSet = new FlattenedDataset({
                    dimensions: [{ name: 'Product', value: "{cont>product}" }],
                    measures: [{ name: 'Amount', value: "{cont>amount}" }],
                    data: {
                        path: "cont>/sales"
                    }

                });
                oChart.setDataset(oColDataSet);

                var oFeedValueAxis = new FeedItem({
                    type : "Measure",
                    uid : "valueAxis",
                    values : ["Amount"]

                });
                var oFeedCategoryAxis = new FeedItem({
                    type : "Dimension",
                    uid : "categoryAxis",
                    values : ["Product"]

                });
                oChart.addFeed(oFeedValueAxis);
                oChart.addFeed(oFeedCategoryAxis);
                
                oChart.setVizProperties({
                    title : {text : "Salse Data"}
                })
            },
            _setChartInView: function () {
                var oData = {
                    list: [

                        { name: '국어', rate: '100', cost: '10' },
                        { name: '영어', rate: '50', cost: '22' },
                        { name: '수학', rate: '80', cost: '55' },
                        { name: '도덕', rate: '80', cost: '44' },
                        { name: '체육', rate: '70', cost: '33' }

                    ]

                };
                var chartUid = this.byId("idViewChart").getVizUid();

                this.getView().setModel(new JSONModel(oData), "view");

                this.byId("idViewPopover").connect(chartUid);
            }
        });
    });
