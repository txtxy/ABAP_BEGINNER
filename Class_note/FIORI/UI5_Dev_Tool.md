# UI5
## 개발 툴
1. SAP BAS
2. VS 코드
    - Fiori Extansion을 설치해야함

- 둘다 배포도 가능하고
- BAS가 속도가 느려서 개별적으로 연습 등을 할때에는 VS 코드를 주로 사용
- BAS는 거의 VS 코드와 유사함
- bas는 AWS 와 유사한 제품

[접속 URL](https://account.hanatrial.ondemand.com/trial/#/home/trial)
[BAS Document](https://help.sap.com/docs/bas/sap-business-application-studio/what-is-sap-business-application-studio)


## NODE.JS
노드js를 이용하기에 
NPM 명령어를 이용해서 서버 설치와 생성이 진행됨,

## 라이브러리 확인
(ui5.sap.com)의 API 레퍼런스에서 체크 가능
![라이브러리 확인](./%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC%20%EA%B2%80%EC%83%89.png)

### 버튼 라이브러리
SAP.m.button


## 로드 순서

인덱스 html
컴포넌트 제이에스
메니페스트 제이슨 (진정한 설정파일)
    - 루트 뷰를 통해서 순서 확인
    - 첫 URL은 MAIN 뷰로 지정되어있기에
메인.view를 호출

메인 컨트롤러 실행
컨트롤러에서 라이블로리를 짝국ㅇ인 직접 작성한 컨트롤러 내용을 익스텐드


## 패키지 구조


   \webapp

    Components.js 설정파일이고 전역 메모리 등록
    index./html 전체 윤곽

    manifest.json : 설정파일.App 전체 구성요소를 담당
    화면이동 경로, RootView 전역모델 설정등을 관리

    \컨트롤러\Component.js
         기준으로 런치패드 구성

    \컨트롤러\메인.컨트롤러/js
        화면 기능을 담당 기능 구현

    \Model\Ddatas.json 화면데이터와 서버데이터 담당
    \View
    Main.view 
        화면 구성 담당

![패키지 구성](./node%EA%B5%AC%EC%84%B1.png)

    /css 
    style.css
        스타일 시트
        부트스트랩에서 개별화 진행할 때 사용
    /i18n
    i18n.properties
        전세계 언어팩 관리

## 부트 스트랩 구현
제일 중요한 부분 : 인덱스 파일 위치 경로는 아래와 같이 잘 설정해줘야함 
```HTML
    data-sap-ui-resourceroots='{
        "zprojecte0101": "./"
    }'
```
### 컴포넌트.js
첫번째 파라미터 : 라이브러리 종료 배열
두번째 파라미터 : 메쏘드 선언

```js
sap.ui.define([
        "sap/ui/core/UIComponent",
        "sap/ui/Device",
        "zprojecte0101/model/models"
    ],
    function (UIComponent, Device, models) {
        "use strict";

        return UIComponent.extend("zprojecte0101.Component", {
            metadata: {
                manifest: "json"
            },

            /**
             * The component is initialized by UI5 automatically during the startup of the app and calls the init method once.
             * @public
             * @override
             */
            init: function () {
                // call the base component's init function
                UIComponent.prototype.init.apply(this, arguments);

                // enable routing
                this.getRouter().initialize();

                // set the device model
                this.setModel(models.createDeviceModel(), "device");
            }
        });
    }
);
```
### 메니페스트.js
 루트 변경도 여기서 가능하고
```js
     "routing": {
      "config": {
        "routerClass": "sap.m.routing.Router",
        "viewType": "XML",
        "async": true,
        "viewPath": "zprojecte0101.view",
        "controlAggregation": "pages",
        "controlId": "app",
        "clearControlAggregation": false
      }
     }
```

### View 클래스 지정
```js
    <mvc:View controllerName="zprojecte0101.controller.Main"
    xmlns:mvc="sap.ui.core.mvc" displayBlock="true"      

    xmlns="sap.m" xmlns:name = "">
    <Page id="page" title="{i18n>title}">
        <content>
        <tnt:InforLabewl />
            <Button text="test" enabled="true" type= "Ghost"/> 
        </content>
    </Page>
</mvc:View>
```


### 단어
라우팅 /ㅣ 패아자 앋홍
### **라이프 사이클**
- 따로 설정하지 않아도 자동으로 실행되는 함수

|메쏘드|사용처|
|:---:|:---|
| onInit | 디폴트 세팅 및 화면 최초 실행시 필요한 로직 추가|
| onBeforeRendering | 화면 실행 직전 로직 ; LIKE PBO|
| onAfterRendering | 화면 실행 직후 로직 ; LIKE PAI|
| onExit | 화면 종료시 메모리 처리 등 관리|


A

## 주의사항
 경로 실수가 많이 존재한다 꼭 경로를 잘 확인할 수 있도록 해라.
API로 배껴올 떄 소속을 잘 맞춰야한다.,

어그리게이션
태그 안에 들어갈 수 있는 태그를 확인할 수 있음.

어그리게이션이 디폴트 값이면 기본설정이기에 생략 가능하다,