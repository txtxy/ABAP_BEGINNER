# Web Dynpro ABAP
웹  Dynpro 아밥을 이용해서 프로그래밍하면 SAP GUI가 아니라 웹브라우져에서 실행됨.

SAP의 MDG 솔루션에서 주로 사용됨.

웹 Dynpro는 메타 데이터와 커스터마이징한 소스코드로 구성되어 Load됨.



## 웹  Dynpro의 메타데이터 구성요소
1. 뷰에대한 레이아웃 과 네스팅
2. 네비게이션과 에러 핸들링
3. 데이터 처리
4. 컴포넌트

## 커스텀 코딩 

1. 동적 어플리케이션 적용
2. 비즈니스 로직 구현 (주로 컴포넌트 컨트롤러에서 구현함)
3. 서비스 접속
4. Portal Eventing
    - SAP 포탈에서 발생하는 이벤트 처리

## 데이터 변동 사항
웹 Dynpro에서 변경된 데이터는 웹서비스에서 혹은 RFC 에서 DB로 직접 접속하거나

SAP 엔터프라이즈 포탈에서 HTTP 규약으로 진행되기도함

API 활용이 기본적으로 적용됨.

웹 Dynpro는 아래 세 곳에서 사용됨
1. SAP 넷위버 비즈니스 클라이언트 
2. HTTP 브라우저
3. SAP 포탈 


## Web Dynpro의 구성요소

- 윈도우 
    - 네비게이션
    - 뷰 콤비네이션
- 뷰 
    - UI 
    - 레이아웃
- 컴포넌트 컨트롤러
    - 플로우 컨트롤

### 주요 개념 
1. 컨텍스트 : UI와 관련된 데이터를 저장할 수 있는 저장소
    - ABAP의 변수와 동일하다
    - 계층구조로 생성할 수 있다.

2. 컨텍스트 맵핑
  : 뷰 컨트롤러와 컨텍스트와 같이 활용하는 것을 말함

3. OOP 개념을 기본 사용됨.
    - **MVC 패턴**을 기반으로 제작됨.

## 실습

패키지 : ZNET310_e01
1. 웹 Dynpro 컴포넌트(인터페이스)  : ZNET310_E01_01
    - 자동으로 뷰, 컨트롤 컴포넌트, 윈도우 패키지가 생성됨

2. 컴포넌트 컨트롤러를 시작
    - 최상위 노드인 콘텍스트를 발견할 수 있음

3. NODE 혹은 Attribute를 생성할 수 있음
    - 노드를 이용하여 계층구조를 가질 수 있다
        노드는 변수 이름과 유사한 개념으로 이해하면됨
    - 딕셔너리에서 스트럭쳐를 통해 필요한 어트리뷰트를 가져올 수 있음
    - 뷰의 컨택스트 탭에서 드래그앤 드랍으로 사용할 수 있음.

4. 컨텍스트 매핑
    - 우측의 컴포넌트 컨트롤러에 선언해놓은 노드를 드래그앤 드랍으로 사용하고자하는 뷰로 MAPPING 할 수 있음,

UI와 유저 데이터 바인딩 : 어트리뷰트와 UI를 연결하는 것을 의미함

웹 Dynpro에는 UI 엘리먼트가 존재한다 스크린의 어트리뷰트와 유사함

프로퍼티에 해당하는 값을 입력하게되면 값 적용가능하고

웹 Dynpro 어플리케이션이 존재해야지 프로그램을 실행할 수 있음

모듈풀의 트랜잭션같은 개념으로 이해하ㅏ자

웹 Dynpro 어플리케이션을 생성하면 URL이 생성된다.

이를 통해 테스트 혹인 브라우저에서 접속 가능하다.

---

컨트롤링에서 메쏘드를 설정하여 컨트롤링 진행 가능

웹  Dynpro는 소스코들를 직접 입력하기보다는 위저드를 통해 불러오는것을 대체적으로 함

컴포넌트 컨트롤러의 컨텍스트와 뷰 컨트롤러의 컨텍스트를 연결해서 사용하는 것을 컨텍스트 매핑이라고 함.



## From View To View 네비게이션

네비게이션에는 원칙이있는데
화면 이동 액션이 발생하면 액션 핸들러 메소드가 발생하고

뷰에는 아웃바운드 플러그를 통해 나와서 

타겟 뷰에는 인바운드 플러그의 핸들러 메소드를 통해 타겟 뷰로 이동이 완료된다.

즉 액션이 발생 -> 액션 핸들러의 아웃바운드 플러그 진행
->도착 뷰의 액션핸들러의 인바운드 플러그가 실행
-> 타겟 뷰의 활성화

이와같은 액션 핸들러와의 연결은 윈도우에서 네비게이션 링크를 통해 연결할 수 있음.

1. 버튼생성
    - button_view_detail
2. 아웃바운드 플러그 생성
    - to_main



그다음

윈도우즈에서 아웃바운드 플러그와 인바운드 플러그를 연결해야함

드래그 앤 드랍으로 원하는 윈도우에 원하는 뷰를 얹어내고

링크하기 원하는 인바운드와 아웃바운드를 드래그 앤 드랍으로 연결함.

## 웹 Dynpro 컨트롤러의 공통사항
컨텍스트가 존재하고 프로그래머의 이해 선언되어 활용됨

어트리뷰트는 기본적으로 존재하고
스탠다드 어트리뷰트와 어디셔널 어트리뷰트가존재
 설정하여 활용 가능하고

프로퍼티는 

스텐다드 훅 메소드와
어디셔널 메소드가 존재하여
이를 통해 비즈니스 로직을 처리한다.

스탠다드 훅 메소드는 호출하여 활용할 수 있는 메소드가 아니다.
특정 시점이되면 자동적으로 호출되어진다.
예시 : WD*


## 기본 사항
MVC 패턴을 기반으로 진행되기에

뷰(V)와 컨텍스트(M), 컨트롤러(C) 이 3가지 요소를 기반으로 돌아가게된다.
유저가 보는 화면은 뷰에서 적용 및 수ㅈㅇ을 진행하는데

윈도우는 여러 뷰들을 한데 묶어놓은 것으로 볼 수 있다.

각각의 요소들은 스탠다드 

## 컨텍스트 
각기 노드는 계층구조로 존재하고
각기 노드에는 어트리뷰트를 선언할 수 있다.
이 때 ABAP DICC를 이용하여 생성할 수 있다.

컨텍스트의 노드와 어트리뷰트에 활용할 데이터들을 저장하여 활용하고
ABAP DICC를 기반으로한다.

### 노드

컨텍스트 노드를 루트 노드로 생성됨.
루트 노드에 대한 오브젝트가 생성되고
루트 노드에대한 엘리먼트가 생성된다.(즉,인스턴스;로우)

루트 노드의 wd_context에 해당 노드의 주소값을 가지고 있다,
    즉, 루트 노드로 접속하기 위해서는 wd_context를 활용해야함

### 어트리 뷰트
루트의 노드로 생성된 엘리먼트에 값을 설정하고

### 자식 노드 생성
엘리먼트에 각기 로우로 생성됨

루트 노드의 프로퍼티값은 수정할 수 없다.

노드 1과 노드 2를 생성했을 때,

카디널리티를 설정할 수 있는데
카디널리티는 엘리먼트의 개수를 의미한다.
즉 자식 노드 의 카디널리티를 (0..1)로 생성한다면 스트럭쳐인것이고

카디널리티의 종류
|||
|---|---|
|값|설명|
|0..1|있거나 없거나|
|0..n|없거나 여러 엘리먼트가 생기거나|
|1..1|꼭 1개 엘리먼트만 생성|
|1..n|1개 이상의 엘리먼트가 생성|




ns_condr 에 입력된 값을 기준으로
NT_data의 값을 가져와야한다.

즉 컴포넌트 컨트롤러에 get_data 메소드를 생성하고

입력된 ns 값을 READ 하고

셀렉트 구문으로 값을 가져오고

NT_DATA에 값을 세팅하기


메인 뷰의 서치 액션에
wd_comp_controler->get_data( ) . 메소드를 호출하기


싱글톤 프로퍼티가 존재하고 ㅍFALSE로 오게된다면
부모 노드의 엘리먼트 갯수 만큼 자식노드의 오브젝트도 그만큼 생성되게 됨,

싱클톤이 트루일 경우
자식노드의 갯수도 1개만 생성된다.


먼텍스트에 할당된 값들은 스탠다드 혹인 코딩한 메소드, 액션, 네비게시션 플러그에서 변동시킬 수 있따.

데이터 바인딩을 위해서는 노드와 어트리뷰트가 선언이되어져 있아야한다.

뷰의 레이아웃에서 UII  엘리먼트를 생성ㅎ고

해당 UI 엘리먼트에 해당하는 어트리뷰트를 바인딩하는 작업이 필요하다.

UI 엘리먼트에는 여러가지 프로퍼티가 존재하고 각각의 프로퍼티에 값을 설정할 수 있따.

동적으로 처리하고 싶다면
컨텍스트에 노드를 생성하고 그노드의 어트리뷰트를 ㄷ이터 바인딩해서 동적으로 처리할 수 잇다.


## 기본적인 제작 순서
실습 2 : ZNET310_E01_02
1. 컴포넌트 생성
1. 데이터 어트리뷰트 생성
3. 뷰의 컨텍스트에서 컨택스트 매핑
4. 엘리먼트 컨테이너 생성 
메트릭스 레이아웃으로


wddoinit 메소드에 트루 값 설정

## 컴포짓 UI 엘리먼트

테이블 UI 엘리먼트를 컴포짓 UI 엘리먼트라ㅗㄱ 얘기하고
얘네는 자식 UI 엘리먼트를 가지고 있따./

테이블 유아잉 엘리먼트안에는 컬럼즈라는 UI엘리먼트가 있고

컬럼즈 UI엘리먼트 안에는 텍스트 뷰와 캡션 UI 엘리먼트가 존재한다.

이렇게 UI엘ㄹ미ㅓㄴ트 안에 자식 UI 엘리먼트를 가지고 있는 것을 컴포짓 UI엘리먼틀고 한다.

테이블 UI 엘리먼트를 사용할 떄 

데이터 바인딩을 하고자 하는 노드의 카디널리티는 0..n이 와야한다.

xpdlqmfdms rlqhswjrdmfh dufj dpfflajsxmfmf eltmvmffpdlgksms rjtdl니까 
테이블은 기본적으로 여러
카디널리티가 0..n혹은 1..n으로 와야한다

실제적인 컨텍스트 바인딩은 각각의 컬럼에대한 텍스트뷰에 대해 컨택스트의 어트리뷰트끼리 바인딩된다.

노드의 셀렉션 값은 카디널리티와 동일

테이블 UI 엘리먼트에 셀력션 모드라는 프로퍼티를 이용할 수 도 있다.

|||
|---|---|
|auto||
|MULTI|여러 ROW를 선택|
|MUlti no lead|어떤 로우가 선택됐는지 설정하지 안흔ㄴ것|
|NONE| 셀렉션 컬림이 디스플레이되지 않음|
|Single| 1개 로우만 선택 가능|
|Single no Lead|1개로우만 선택가능하나 리드 셀렉션이 설정되지 않음.|