# T Version


## Module

1. 테이블 제작할때 PK를 식별이 가능한 필드까지 설정해야한다.

2. 제작한 Domain의 Fixed value 설정해야함.

3. 스크린마다 필요한 내용을 ABAP DIcc에서 Global Structure로 생성하여 활용.

    1. BOOKING TAB

        - SBOOK의 필요부분.
        - SCUSTOM의 NAME.
        - Class, Custtype Value text.

    2. FLIGHT CONNECTION TAB

        - SPFLI
        - Country text

    3. CUSTOMER TAB

        - SCUSTOM
        - Country text

    4. MEAL Dialog Box

        - SMENU, SMEALT

---
## VIEW

4. Screen과 Suvscreen 제작.

    - 각 TAB 마다 필요사항이 보일 수 있도록.

5. Main Screen UI 설정.

    - GUI STAUTS bar, Title 설정
    - GUI Application bar 설정

6. Subscreen UI 구성

## Control

7. Subscreen SELECT문을 통해 값 부여.

    1. BOOKING TAB의 경우

        - 기본 정보를 SELECT문으로 조회
        - Class와 CUSTTYPE의 Shot Value 값을  

            'GET_DOMAIN_NAME' 함수를 사용.
            서브루틴으로 만들때 USING VALUE에  
            'S_CUSTTYPE'으로 설정한다면 다중 사용가능
            이때 DOMAIN NAME을 받는 인자의 TYPE을 DOMNAME으로 해야함.

    ```abap
        PERFORM GET_DOMAIN_NAME USING 'S_CUSTTYPE'
                                       wa_sbook-custtype 
                                       cust_type.
        *---------------------------------------------------------
        FORM GET_DOMAIN_DATA  USING    PV_DOMAIN TYPE DOMNAME
                                       PV_VALUE  TYPE CHAR1
                                       PV_TEXT   TYPE TEXT20.

          DATA: LT_VALUE TYPE TABLE OF DD07V,
                LS_VALUE LIKE LINE OF LT_VALUE.

          CALL FUNCTION 'GET_DOMAIN_VALUES'

            EXPORTING
              DOMNAME         = PV_DOMAIN
            TABLES
              VALUES_TAB      = LT_VALUE
            EXCEPTIONS
              NO_VALUES_FOUND = 1
              OTHERS          = 2.

          IF SY-SUBRC <> 0.

          ENDIF.

          READ TABLE LT_VALUE INTO LS_VALUE
            WITH KEY DOMVALUE_L = PV_VALUE.

          IF SY-SUBRC = 0.
            PV_TEXT = LS_VALUE-DDTEXT.
          ENDIF.
    ```
        이렇게 하면 서브루틴을 진짜 서브루틴 처럼 사용가능함!!!

    2. Flight Connection TAB의 경우

        - 기본 정보를 SELECT문으로 조회  
        - Subroutine으로 국가명 조회 SELECT문 작성  
            spras = sy-langu 조건을 이용해 언어 조건 추가.
        - Subroutine으로 공항명 조회 SELECT문 작성

    3. Customer TAB의 경우

        - 기본 정보를 SELECT문으로 조회  
        - Subroutine으로 국가명 조회 SELECT문 작성  
            spras = sy-langu 조건을 이용해 언어 조건 추가.

    4. MEAL Menu Dialog Box

        - starter와 MAIN, DEsert를 각각 SELECT 문으로 텍스트 조회

8. Subscreen 호출 구문 작성.

    - OK_CODE 구문에 각기 TAB의 FUNCTION코드 포함

    - SET_SUBSCREEN 모듈생성

        - TAB의 OK_CODE에 따라 DYNNR을 해당 Subscreen Number로 할당.
        - DYNNR을 저장할 변수는 TOP에 생성 TYPE sy-dynnr.

    - PBO에 CALL subscreen SUB   
            INCLUDING sy-cprog gv_dynnr

    - PAI에 CALL subscreen SUB.

9. TRANSACTION CODE 생성.

10. INPUT CHECK 선언
    - CHAIN구문으로 입력 필드 묶음.
    - MODULE INPOUT_CHECK. 생성
    ```abap
        SELECT COUNT(*) from sbook
        WHERE carrid = ztreqmenu_e01-carrid AND
              connid = ztreqmenu_e01-connid AND
              fldate = ztreqmenu_e01-fldate AND
              bookid = ztreqmenu_e01-bookid.
        IF sy-subrc <> 0.

        MESSAGE '데이터 없음' TYPE 'I'.

        ELSE.
    ```

버전 관리 기록은 RELEASE가 기준임.