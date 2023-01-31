# 기본 사항 작성
[참고 예제](../../ABAP_source_code/Week7/zquiz_15_E00.abap)

## **필요 변수 작성**.

### ABAP_Dicc 변수 생성
- tables 생성 및 Display할 DATA의 Structure를 ABAP_Dicc에 전역 변수로 생성.
    - 기본 Field 생성
    - Booking_count ABAP Dicc DE 생성(Int).
    - Cust_Grade ABAP Dicc DE 생성(Char).

---

### Incl 생성
1. TOP
2. CLS
3. O01
4. I01
5. F01

---

### 전역 변수 생성
1. 주요 DATA 항목 Itab 및 WA 생성.

2. SYSTEM 변수 생성
    - OK_CODE
    - GO_con ALV    Container       /  TYPE cl_gui_custom_container
    - GO_alv_grid   ALV Grid Object /  TYPE cl_gui_ALV_Grid

3. ALV GRID 내장 변수 생성
    - gs_layo       Layout_Setting  /  TYPE lvc_s_layo
    - GT_FCAT       Field_catalog   /  TYPE lvc_t_fcat

4. PARAMETER  및 SELECT-OPTIONS 생성
    - selection screen Block 생성
        - 각 변수에 `MEMORY ID` 부여함
        - SO_CID / 필수 입력값 S-O 생성
        - SO_BID / 미입력시 전체 조회해야할 필드
            1.  S-O로 생성 ,`NO interval no-extension`.
            2.  RANGE Table과 WA를 생성해서 pa를 table로 만들어서 처리할 수 있다.
        - pa_name / LIKE 조회 가능한 필드
            - parameter 변수로 생성.

## 기본 DATA 조회
- LIKE 조회를 위한 지역 변수 생성
    ```ABAP
        lv_name type string.
        lv_NAME = '%' && PA_NAME && '%'.
    ```
- 기본 조건 설정
    - S-O 의 IN 조건
    - `NAME LIKE lV_NAME`

- 계산 값 설정
    - 반복문을 통한 CUSTOMID 별 sbook count(*) 조건 : cancelled = ''.
    - 위의 SBOOK count 수를 기준으로 등급 부여(반복문 내부에 Record별 조건문으로 부여)
    - 등급부여와 동시에 excp_field 설정 `gs_data-excp = <해당등급>`
    - 마지막에 꼭 MODIFY하자!!!!

---
# ALV - GRID 생성
1. Screen 생성
    - PBO statsus 및 title 생성
    - 기본 Standard menubar FUCTION 설정 
    - PAI exit 및 user_command 설정
2. Custom Container 생성
3. ALV-Grid 생성
