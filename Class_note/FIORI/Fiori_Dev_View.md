# 뷰 관리
## Nested View
중첩 뷰 만들기
뷰에 새로운 뷰파일 생성


뷰를 생성할떄 컨트롤러를 지정해줘야하는데
컨트롤러네이믕로 지정해줘야하고 
해당하는 컨트롤러 이름은 

CSS적용은 CLASS 등 기존 CSS 문법화 동일하게 적용가능하다.   

fragment => Dialog Box에 사용
view => 메인 화면이나 상헤솨면등에 사용

## 프래그먼트 생성

".onClose"
점이 찍혀있는것은 현재 바라보고 있는 컨트롤러에 존재하는 행동이다는 의미
```js
            onHelloPress: function () {
                sap.ui.Fragment.load({
                    name: " ", // 프래그먼트 경로
                    type: "XML", //프래그먼트 타입
                    controller:this  // this(본인) 컨트롤러에서 활용 까먹기 쉬우니 꼭 잘 적어라
                }.then((result) => {
                    
                }).catch((err) => {
                    
                }););
```