# Generic Data Types
&nbsp;&nbsp;&nbsp;&nbsp;p.478
    이해만 한다면 복잡한 프로그램을 간단하게 만들수 있다.

## 데이터 타입
|Generic Data Type| 설명 | 비교 사항 |
|---|---|---|
|`any`<br>`data`|
|`simple`| 모든 엘리먼트 데이터 타입 또는 캐릭터 스트럭쳐
|NUMERIC|
|CLIKE|
|XSEQUENCE|

---
## 테이블 타입
|Generic Data Type| 설명 | 비교 사항 |
|---|---|---|
|`any TABLE`|
|index table||스탠다드  또는 소티드|
|standard table|||
|sorted table|||
|hashed table|||

실습
ZABAP_E01_046


# Field Symbol
다른 데이터 타입의 address할 수있다.
LIKE C의 Pointer

문법

```ABAP
    FIELD-SYMBOLS :
        <fs_tab> TYPE ANY TABLE.   " 필드 심벌의 선언

    CASE gv_table_name.
        WHEN 'SCARR'.
            ASSIGN gt_scarr to <fs_tab>. " 필드 심벌을 통해 다른 데이터를 포인팅

        WHEN 'SBOOK'.
            ASSIGN gt_sbook to <fs_tab>.
    ENDCASE.

    IF <fs_tab> IS ASSIGNED.             " 뭐가 됐던 다른 데이터를 포인팅 중임.
                                         " 반대 구문은 IS NOT ASSIGNED 
        SELECT * FROM (gv_table_name)    " 괄호 사이에 공간이 있으면 안된다.
        UP TO 100 ROWS
        INTO TABLE <fs_tab>.
    ENDIF.

```
---
실습
ZABAP_E01_047

---

## Type Casting With Field Symbols
&nbsp;&nbsp;&nbsp;&nbsp;p.484

필드 심벌을 이용해서  형변환이 필요 할떄에는 CASTING을 이용한다.

```ABAP
    


```

## Dynami Access to Data Objects

```ABAP
    gv_name = 'GV_CARRID'
    ASSIGN (gv_name) to <fs>  " 'GV_CARRID'를 포인팅한다.
    ASSIGN gv_name to <fs>  " gv_name을 포인팅한다.
```
![](../screenShot/Week8/Dynamic_Access.png)


---

```abap

    gv_name = 'GV_CARRID'.
   
    ASSIGN gv_name TO <fs>.
    WRITE :/ <fs>.                          " 결과값 GV_CARRID
 
    ASSIGN (gv_name) TO <fs>.
    WRITE :/ <fs>.                          " 결과값 'AA'

    gv_name = 'LS_SCARR-CARRNAME'.

    ASSIGN (gv_name) TO <fs>.
    WRITE: / <fs>.                          " 결과 값 : ls_scarr 스트럭쳐의 carrname 컴포넌트의 값.

    gv_name = 'CARRID'.

    ASSIGN COMPONENT gv_name
      OF STRUCTURE ls_scarr TO <fs>.
    WRITE :/ 'Carrid : ' , <fs>.
                                            " 결과 값 : ls_scarr의 'CARRID' 컴포넌트의 값.
    ULINE.

    ASSIGN COMPONENT 4
      OF STRUCTURE ls_scarr to <FS>.
    WRITE : <fs>.
                                            " 결과 값 : ls_scarr의 4번째 컴포넌트의 값.

    ULINE.

    DO .
      ASSIGN COMPONENT sy-index OF STRUCTURE ls_scarr
              to <fs>.
      IF sy-subrc <> 0.
        EXIT.
        else.
          WRITE : <fs>.
      ENDIF.


    ENDDO.
```