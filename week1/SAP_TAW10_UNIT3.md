# Object Navigator
    SAP ERP 시스템에 접속하기위해서는 SPA GUI를 이용해야함
    리눅스나 맥OS에서는 SAP GUI FOR JAVA 를 이용해서 서버에 접속해야함

## 정의
    DEV server = Development Server ; ABAP 개발 및 단위 테스트 서버  
    QAS SERVER = Quality Assurance Server ; 통합 테스트 서버  
    PRD SERVER = Production Server ;E nd-User (현업) 사용, 실제 Business Data 발생  
    conferm popup = 유저에게 실행 할것인지 묻는 팝업창  


##  단축키
||||
|---|---|---|
|ctrl+f11 | SAP MENU 단축키
|section | SAP GUI WINDOW
| T-CODE | Transaction code
|| /n####|현재 섹션에서 T-code 실행
|| /o####| 새로운 섹션에서 T-code 실행
|| /i | sap gui 섹션 종료
|| /nend | sap gui 로그 오프 ; 컨펌팝업 있음
|| /nex | sap gui 로그 오프 ; 즉시 종료
|| f3 | 뒤로가기

## 주요 T-code
|||
|---|---|
| se80 | se80 abap dev navigator
| se11 | se11 abap dictionary 


사용자 언어 팩이 지원되며, 시스템 패키지는 BC가 관리함.<br>
user ID 에는 role 을 부여하여 기능을 GRANT 할 수 있음<br>
<br>
sap의 기본 화면을 section이라고 하고 기본 설정으로는 6개 까지만 open 가능함<br>
<br>
sap 에서 원하는 프로그램을 실해아기 위해서는 command field에서 t-code 를 입력함으로서 실행가능하고 Navigation List에서 실행하거나 Favorite List에서 실행할 수도 있음.

Role에 따라서 Navigation List에 가능한 프로그램이 시각화됨.

현재 USER profile 수정이 가능한 메뉴는 아래와 같음
    menubar - system - user profile - userdate
    User Profile Toolbar의 deafault 탭에서 기초 구조를 변경가능 
    날짜, 시간,등등


### Object navigaitor 기초 개발환경 스크린

    Favorite List에서 "insert t-cdoe"를 통해 T-code 프로그램을 등록할 수 있다.

## F1 help
    설명이 필요한 창 혹은 기능 위에 커서를 올려 놓고서 f1을입력한다면 help창 등장  
    thecnical information : 프로그램이름 화면번호, 테이블,데이터 타입 등등 프로그램정보를 확인할 수 있음.


## F4 help
    서치 헬프 혹은 인풋 헬프라고 함.
    해당 필드에 입력할 수 있는 명령어를 알려주는 help창

팝업 창에서 해당 명령어를 더블 클릭하면 해당 명령어 입력 시행
드롭 다운방식으로 도 가능함.
접두사를 적고 *을 입력하면 검색 가능

