# Model
## Client에서 사용
1. json 
2. Xml
3. Resource => i18n (언어 관리)

## Server
1. OData V2
2. OData V4

주로 사용하는 것은
JSON 과 OData V2;

## Resource 
{모델이름>키}
위와같이 중괄호를 이용해서 데이터 바인딩을 할 수 있다.

만약 모델에 이름이 없다면 {키} 처럼 편하게 데이터 호출이 가능하다.

# JSON
경로 설정이 필요함
{모델이름>/Key}

이렇게 설정하는 것이 Property 바인딩이라고 한다.

## Data Binding

1. 2 Way 방식 : 모델과 뷰 양방향으로 영향 받음
    - 뷰에서 변경했을 때 모델에서도 같이 변경된다.
    - 가장 많이 사용하는 방식임.
2. 1 way 방식 : 모델에서 뷰로반 데이터 전송 
    - 뷰에서 아무리 값을 변경하더라도 모델에는 아무런 영향이 없다.
3. 1 Time 방식 : 최초 1번만 뷰에 보이게 되고 이후 변경되지 않음.

뷰와 컨트롤 사이에서 데이터 동기화 혹은 격리를 위해 바인딩이 필요하고
최종적으로 Commit을 진행할 때 컨트롤에서 DB로 접근을 하는 것이 기본적이다.

## 전역 모델
manifest.json 에서 선언 한 모델은 전역적으로 사용이 가능하다.

```json
    "models": {
      "i18n": {
        "type": "sap.ui.model.resource.ResourceModel",
        "settings": {
          "bundleName": "zprojecte0104.i18n.i18n"
        }
      },
      "root":{
        "type": "sap.ui.model.json.JSONModel"
    }}
```
이렇게 선언하면
<Input  value="{root>/Value}" />
프로퍼티 경로 설정해서 찾을 수 있당,.



## Model Data 수정 

e데이터 호출 방식은 2개
- .getData()
    - 전체 데이터 호출
    - 예시 
    ```js
         var oModel = this.getView().getModel('MainModel');
                oModel.getData();
    ```
- .getPoperty()
    - 특정경로에 해당하는 데이터 호출 
    - 예시 
    ```js
         var oModel = this.getView().getModel('MainModel');
                oModel.getProperty("/title/subtitle");
    ```
```js
    this.getView().setModel(new JSONModel(datas), 'MainModel')
     //   모델객처생성(어떤 데이터 사용할지?),   모델이름 설정
    
     var oModel = this.getView().getModel('MainModel');
```                

## 모델의 값을 가져오기

oModel.getData(); : 전체 데이터을 모델에서 Get
oModel.getProperty("/key"); => { key2 : ''}

oModel.setData(세팅 데이터);  : 전체 데이터을 모델로 세팅
oModel.setProperty("/경로",세팅 데이터);   : 성능 이슈 있음 가능하면 마지막에 한번만 정리하는 것으로 할 것.

## JSON Model 로컬 CRD

모델의 데이터 값을 외부 파일에서 호출이 가능함
모델 폴더안에 JSON 파일을 생성하여 호출

## create 하기
 

## Delete 하기
선택한 로우 정보 파악하기
해당 로우의 Idex를 고려해서 삭제 기능 삽입

1. 단건 삭제

2. 다건 삭제
