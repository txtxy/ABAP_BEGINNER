# SEARCH HELP <br>&nbsp;&nbsp;&nbsp;a.k.a. INPUT HELP; F4 HELP

## SEARCH HELP의 구성요소

1. IMPORT INTERFACE
    사용자로부터 Search 필요 값을 전달받음
2. SELECTION-METHOD
    1. table
    2. view (DB VIEW ,HELP View, project view)
3. Export interface
    사용자에게 검색 결과를 전달

### SELECTION-METHOD는
테이블이나 뷰에서 어떤 값을 읽어올 것인지 정의하는 것.

### SELECTION Dialog
**&nbsp;&nbsp; B3.P256**  

1. Dialog Box for limiting Values
2. Dialog nox to display number of hits

## SEARCH HELP의 사용
**&nbsp;&nbsp; B3.P260**  
1. 스트럭쳐의 컴포넌트에 연결할 수 있음.
2. 테이블의 필드에 연결할 수 있음
2. 스크린페인터의 속성에 Search help를 연결해서 사용하는 것은 **권장하지 않음**

## Mechnisms for F4 HELP
**&nbsp;&nbsp; B3.P262**  

|<b>input help의 존재를 찾는 알고리즘</b>|이하 설정|
|:---:|:---:|
|1. SEARCH HELP가 설정되어있는지?||
|2. FK가 설정되어있는 필드인지?||
|3. 해당 Field의 DE에 SEARCH HELP가 설정되어있는지?||
|4. 해당 DE의 Domain에 Fixed value가 존재하는지?||
|5. 해당 Domain이 시간 혹은 DATE값인지?||

너무 많은 데이터를 가진 값을 SEARCH HELP로 이용하면 퍼포먼스가 떨어진다.

## HELP VIEW
- 헬프뷰는 오로지 서치헬프에만 사용할 수 있다.
- 아밥 프로그램 소스코드에서 사용할 수 없다.
- 여러 테이블에서 SEARCH 핼프를 생성하고자할때  
    헬프뷰를 사용하는데,  
- 테이블 간 left outer join을 사용할 수 있다.

---


### !!Search Help 생성 실습!!

<b>zsh_emp_e01 생성</b>

![search_help_setting](../screenShot/WEEK3/search_help_setting.png)

1. <b>selection method 테이블 선택</b>
2. <b> dialog type 설정</b>
    - Display Imedietly
    - Dialog With Value List
        Selection Method에 선택된 Table에서 읽어온
         데이터 양에 따라서 자동적으로 처리해주는 것.
3. <b>파라미터 입력</b>
    - F4로 입력 필드 선택가능함.
    - IMP IMport
    - EXP Export
    - Lpos 리스트되는 순서
        숫자가 작은 컬럼부터 순서대로 나옴
        값을 입력하지 않으면 디스플레이되지 않는다.
    - SPos 셀렉션 포지션에 오는 순서
        값을 입력하지 않으면 디스플레이되지 않는다.
4. <b>activate</b>
5. 서치핼프를 설정하고자하는 테이블 필드 설정에서 FK아이콘 우측 Search를 선택하여
    원하는 서치핼프 이름을 입력하여 설정함.

---

### !!스트럭쳐에 SEARCH HELP 생성 실습!!  <br>
ZSEMP_E01 생성

테이블과 동일함.

---

### !!CODE에 직접 연결 !!

abap CODE를 통한 서치헬프 입력
 **살무에서 사용하지 않음**
`parameters: pa_nr type num8 matchcode object zsh_emp_e01.`
 ### FULL TEXT SEARCH 기능
HA/NA DB에서 사용가능
유사한 TEXT를 검색하는 <a href = "https://juggernaut.tistory.com/14">FUZZY 서치</a> 기능이라고 있음.

#### FUZZY SEARCH 생성 실습
1. ZSH_CUST_E01 서치 헬프 생성 - 동일함.
2. 서치헬프 창에서 Advanced Search OPTION 설정
    - ![ADVANCED](../screenShot/WEEK3/FUZZY_SEARCH.png)
3. 코드에 matchcode object 를 설정하여 서치헬프 입력시에 
    INPUT 칸에 돋보기 문양이 생기며 문자열을 통한 DB 내부 유사 검색이 가능해짐.

머신러닝에 따라 유사성 래밸 설정도 가능함.(Default = 0.8)

<a href="https://help.sap.com/docs/PRODUCT_ID/691cb949c1034198800afde3e5be6570/cc763b18bb571014b9c2ca94cc5e7da0.html?state=PRODUCTION&version=2.0.02&locale=en-US">링귀스트 서치</a>.