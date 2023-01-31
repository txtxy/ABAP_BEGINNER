# Prg INTERFACE
**&nbsp;&nbsp; B4.P394** 

## USER INTERFACE Introduce

![제목 및 상태창](../screenShot/WEEK3/Tittle_Bar%26GUI_Status.png)

1. 최상단 메뉴바
3. 스탠다드 툴바
3. GUI 타이틀
2. 어플리케이션 툴바

위의 '아이콘'들은 단축키를 세팅해서 사용할 수 있다. 

하나의 스크린 프로그램에는 여러개의 Status가 존재할 수 있고  
이 Status는 Menubar와 Application Toolbar로 나눠진다.

---
**&nbsp;&nbsp; B4.P396** 

Screen Prg에는  
Status로 사용할 Fuction을 List로 가지고 있다.  
이 Function List에서 직접 제작한 Function을 Menu Bar에 넣을 지.    
미리 정의된 Standard Function을 가져와서 사용할지는 개발자 마음.

**&nbsp;&nbsp; B4.P396** 

List에 있는 Function들은 각자의 이름인 Fct-code로 Identification한다.

펑션 타입은 6개로 나눠진다.
|의미|타입코드|
|:---|:---:|
|Normal|없음|
|Exit| E|
|-------구분자-------|---|
|system|S|
|Transaction|T|
|tabstrip ctrl|P|
|Help Request|H|

---
### 펑션키 어싸인먼트 
398쪽
- 이건 뭐라고 적은지 모르겠네
>Status bar의 Functionkey Assignment안에  
>컨택스트 메뉴는 마우스 우클릭했을때 나오는 팝업을 의미하고 이를 조절 할 수도 있음.  
>다이얼로그 박스에는 메뉴바가 존재하지 않는다.

---


## GUI Tittle & GUI Status Setting

* 스크린의 Flow Logic에 보면   
MODULE STATUS_0100.가 주석처리돼서 존재함  
이 Status Module에서 Titlevar 이름을 선언할 수 있고.   
`SET TITLEBAR '이름'.`  
위 구조로 작성한다. 

* GUI STATUS Bar는 아래와 같이 선언한다.  
`set pf-status '이름'.`  

* 다음으로 Status Type을 선택한다.
1. Normal Screen인지 
2. Modal Dialog Box인지 
3. 마우스 우클릭으로 생기는 Context Menu인지 선택해야한다.  

Functionkey Assignment에 미리 정의된 standard Tool bar를 선언할 수 있고.  

임의로 생성한 Function Key는 최대 20 CHAR 까지 명명할 수 있음.  
각각의 평션에는 속성값이 존재하는데  
Functionkey Assignment 화면을 보면 충분히 이해가 갈것이다.  

- Function ASsignment 이동방법  
    ![Status_Setting](../screenShot/WEEK3/Status_Setting.png)
- Function ASsignment 화면  
    ![Function_Assignment](../screenShot/WEEK3/Function_Assignment.png)

---
**&nbsp;&nbsp; B4.P404** 

스탠다드 툴바는 자동적으로 펑션이 어싸인 되어져 있다.  
---------------------404페이지 테이블 고대로 배껴오자

어플리케이션 툴바는 펑션키 어싸인번트에서 자유롭게 어싸인해서 지정할 수 있고  
어플리케이션 툴바에서 F4를 누르면 프릴리 어싸인된 펑션을 볼 수 있고 여기서 선택해라.  
메뉴바를 구성하기위해서는 메뉴바를 선택하고  메뉴바 속성에서 간단 설명보고  
메뉴바에는 메뉴 리스트가 오면된다.  
메뉴바에도 스탠다드 펑션키가 존재한다 기본 제공품이라고 볼 수있고 이것들을 가져올 수 있다.  

---

메뉴를 구성할때는 펑션리스트를 가지고 어플리케이션 툴바를 사용할지 메뉴바에 사용할지
바텀업으로 판단한다.
1. 펑션을 먼저 제작하고
2. 어플리케이션 툴바에갈지 메뉴바에 갈지 정하고
3. 메뉴바에 가면 어떤 메뉴리스트에 넣을지 선택하고

---

펑션의 코드들은 스크린의 엘리먼트 리스트에 TYPE이 OK로 되어있는 로우가 있고
OK_code라는 필드 이름으로 만들어진다.

즉. 스크린에서 펑션 코드를 실행하면(메뉴바에서 해당 아이콘을 선택하고나 실행하면)
OK_code에 해당 펑션 코드의 이름이 값으로 할당된다.
OK_code는 이름을 마음대로 바꿔도 되는데,

아밥 TOP에 같은 이름으로 SY-ucomm 타입으로 변수선언을 해줘야한다.

스크린에서 펑션 코드값을 받기위한 변수를 선언해줄 필요가 있다는 말이다~이말이다.

각기 스크린에 스테이터스 모듈을 생성해서
 SET PF-STATUS 'xxxxxxxx'.
 SET TITLEBAR 'xxx'.

위의 set 키워드를 이용해서 이름 정해주고 더블클릭하면 메뉴바 시능 가능함

PBO에서 OK_code가 가장 많이쓰이니까 꼭! 클리어시켜주는 모둘을 넣어누자

![주의사항](../screenShot/WEEK3/IMPORTANT_ok_CODE.png)


![Title_setting](../screenShot/WEEK3/Title_setting.png)
* 타이틀바의 첫번째 &기호 위치에 해당 with에 지정한 변수값이 표시된다. 최대 9개까지!!
```abap
    SET PF-STATUS 'S100'.
    SET TITLEBAR 'FIRST_TITLE' WITH sdyn_conn-carrid.
```
