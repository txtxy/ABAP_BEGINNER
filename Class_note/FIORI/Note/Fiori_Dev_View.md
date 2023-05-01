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
    
    ".onClose"
    점이 찍혀있는것은 현재 바라보고 있는 컨트롤러에 존재하는 행동이다는 의미`

## 프레그먼트 생성
1. 새롭게 뷰 파일을 생성해서 활용
```js
<core:FragmentDefinition
    xmlns:core="sap.ui.core"
    xmlns="sap.m">
    <Dialog id="addDialog" title="Add todo list" beforeOpen="onBeforeOpen">
        <content>
                <HBox height="60px" alignItems="Center" justifyContent="Center">
                    <Label text="Content :" class="sapUismallMarginEnd" />
                    <Input  id="addInput"   value="{root>/Value}" />
                </HBox>
                <!-- <Button text="Add" icon="sap-icon://add" press="onAddPress" /> -->

        </content>
        <endButton>
            <Button text="close" press=".onClose"></Button>
            <!--앞에 점 찍힌것은 내가바라보는 컨트롤러에 해당한다는의미 -->
        </endButton>

    </Dialog>
</core:FragmentDefinition>
```
2. 생성한 프레그먼트 호출
```js
sap.ui.Fragment.load({
                    name: " ", // 프래그먼트 경로
                    type: "XML", //프래그먼트 타입
                    controller:this  // this(본인) 컨트롤러에서 활용 까먹기 쉬우니 꼭 잘 적어라
                }.then((result) => {
                    
                }).catch((err) => {
                    
                }););
```

```js
            onHelloPress: function () {
                sap.ui.Fragment.load({
                    name: " ", // 프래그먼트 경로
                    type: "XML", //프래그먼트 타입
                    controller:this  // this(본인) 컨트롤러에서 활용 까먹기 쉬우니 꼭 잘 적어라
                }.then((result) => {
                    
                }).catch((err) => {
                    
                }););
            }
```

## Message
1. MessageToast.

2. MessageBox 

