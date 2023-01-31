# Subscreen
**&nbsp;&nbsp; B4.P486**  

- 스크린 화면을 동적으로 변화시킬 때 **Subscreen**을 사용한다.
## Subscreen의 목적(Moduliaztion)
- SubScreen을 **재사용**
- 소스코드 가독성 증가
- 유지보수의 용이
- 동적인 화면 활용
- 책임 분산.

## Creating Subscreen

- Subscreen은 Subscreen이 존재할 공간인 **SUBSCREEN AREA**가 필요하다.  
- 다수의 Subscreen을 이용해    
    1개 Subscreen Area에서 동적으로 변화시키며 활용이 가능하다.    

- 1개의 Subscreen을 이용해서   
    여러 SUBSCREEN AREA에서 사할 수 있다.  

---
### Subscreen의 특징

1. 서브 스크린에서는 OK_CODE를 사용할 수 없다.  
2. 서브 스크린은 STATUS를 가질 수 없다.  
당연하다. 메인 스크린 내부에서 스크린 프로그램이 돌고 있기때문에.  

### Subscreen Area 속성

1. Resizable   
    메인스크린의 크기 변화에 맞춰서 교정될 것인지   
2. Minimum Size  
    최소 스크린 크기 설정

---
### 필수 정의

1. Subscreen Area 설정 및 Naming  
    - Main screen의 레이아웃에서 Screen Area설정.  
    - 다른 Screen Elements와 마찬가지고 이름을 기준으로 Identification.  

2. Module 설치

```abap
    * PBO 모듈에
        Call subscreen <서브스크린 에어리어 이름>  
        Including <프로그램이름> <표시할 서브 스크린 넘버>.  

    * PAI 모듈에
        Call subscreen <서브스크린 에어리어 이름>.
```

### Subscreen Flow

1. 메인 프로그램 실행  
---------------------------------------------
2. 메인 프로그램의 PBO 시작   

    1. 서브 스크린 CALL 실행     

        1. Included 서브스크린의 PBO 실행   

    2. 메인 프로그램 복귀  

3. 메인 프로그램의 PBO 완료  

---------------------------------------------
4. 메인 프로그램 스크린 구현 시작    
  
    1. Included 서브스크린 구현     
  
5. 메인 프로그램 스크린 구현 완료
---------------------------------------------
6. User input 발생   
---------------------------------------------
7. 메인 프로그램 PAI 실행  

    1. 서브 스크린 CALL 실행  

        1. Included 서브스크린 PAI 실행   
  
    2. 메인 프로그램 복귀   

---------------------------------------------
### Special Case

#### Visibility of Data
1개의 Subscreen Area에는 한번에 1개의 Subscreen만 올 수 있다.

1개의 Subscreen에 여러개의 Subscreen을 변동시키며 호출할 때는  
TOP에 Subscreen의 Number를 입력할 전역변수를 선언하고(Type sy-dynnr)  
PBO에 included Subscreen 이름을 변수로 호출한다면 가능.

간단하게 보자면
```abap
    *-----------------------------
    *     TOP INCL
    dynpro TYPE sy-dynnr.    
    *-----------------------------
    *     PBO INCL 
    if 1번 Subscreen이 와야할 조건.   
        dynpro = (1번 서브스크린 번호).  

    eleif 2번 Subscreen이 와야할 조건. 
        dynpro = (2번 서브스크린 번호).

    endif.  
    *-----------------------------
    *     FLOW LOGIC PBO
    call subscreen "에어리어" 
        including sy-cprog dynpro.  
```

---
## 다른 프로그램에서 SUBSCREEN을 호출
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**결론 : FUNCTION GROUP을 이용한다.**

펑션 그룹은 스크린을 가질 수 있다.  
펑션 모듈을 통해 펑션 그룹의 TOP Pool에서   
호출 하는 등으로 Data Transport가 가능하다.

### 호출의 흐름
**B4.P494.**  

서브 스크린에서 필요한 값은     
메인프로그램의 PBO에 익스포팅용 모듈 실행  
해당 모듈에 설치한 펑션 모듈(F1)의 익스포팅으로   
펑션 그룹으로 데이터 전달    
  
펑션 모듈을 통해 전달 받은 데이터를 통해    
펑션 그룹의 TOP에서 서브스크린 동적 정보 호출     
펑션 모듈의 임포팅을 통해     
메인 프로그램으로 데이터 전달.    
  
유저 커맨드 발생  

메인프로그램의 PAI에 임포팅용 모듈 실행  
해당 모듈에 설치한 펑션 모듈(F2)의 임포팅으로     
메인 프로그램으로 데이터 전달.  

---
펑션그룹 실습
---
zbc400_e01_FUNCGROUP을 이용.

스크린 번호100으로 스크린 크리에이션
Subscreen 으로 선택 
레이아웃으로 진입
필요사항 작성ㅎ하고 저장 Active

---
펑션그룹의 TOP INCL에다가 
스크린에 만든 테이블 변수 선언.

```
    FUNCTION-POOL ZBC400_E01_FUNCGROUP.         "MESSAGE-ID ..

    * INCLUDE LZBC400_E01_FUNCGROUPD...          " Local class definition

    TABLES : scarr.

```

해당 펑션 그룹에 펑션 모듈 생성   zimport_carrid_e01

    임포팅에 carrid 인자

    소스코드에 입력인자를 조건으로 SCARR 테이블 조회 문 작성

---

불러오고 싶은 프로그램으로 이동.
sapmzscreen_e01

