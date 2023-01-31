# Screen Error Handling
## SET / GET Parameter
SAP Memory에서 parameter 값을 저장해서 활용이 가능하다.  
Screen Elements의 SET / GET Parameter 속성을 이용해서  
입력값의 오류를 확인할 수 있는 값을 TRANSFER한다.

---

## DIALOG MESSAGE를 이용한 Error Handling

1. Termination Message
    - 프로그램 종료 처리
    1. A Message의 경우 진행중인 프로세스는 정지된다.
    2. X Message의 경우 Short Dump Message를 발생시킨다.
2. Error Message
    - 프로세스 중지 및 복귀
    - New Entries required    
        입력 오류로 Input Parameter의 재입력이 필요하다.
3. Warning  Message 
    - USER의 선택 가능
    1. Input parameter 재입력
    2. 프로그램 forced Execution.
4. Information Message  
    프로세스가 중단될 수 있으나, USER는 무시하고 진행가능하다
5. Success 
    정상 진행

---
## Field input Checks
    Screen Prg에서 "자동으로" 순서대로 진행됨.
1. Mandatory Fields Check
    - 필수 입력 인자 값 존재 확인  
        - Screen Element의 Required Check
2. Field Format Check
    - Field의 TYPE을 확인  
        숫자인데 글자가 들어온다거나  
        연월일인데 월일연이 온다던가  
3. Fixed Values
    - Field의 Domain에 저장된 Fixed Value를 확인함
4. Foreign key Check

- **Check Keyword**  
필드의 이름을 기준으로 체크를 진행함

---
## Ready for input again

    재입력 요청 오류 메시지

```abap
    Flow Logic의 PAI 하단
    FIELD <Field name>
        MODULE chdeck_input.

    *--------------------------------
    *    체크 모듈에서는...
    Module chdeck_input INPUT.
    ...
        message E ... .
    ENDMODULE.
```

### Check on groups of Fields
B4.P460.  
여러건의 필드를 그룹으로 묶어 재입력 요청
그룹으로 묶는 CHAIN키워드는 FLOW LOSIC PAI부분에 작성하고
Check 로직은 PAI Module Include에 작성한다.

```abap 
    Flow Logic의 PAI 하단
    CHAIN.
        FIELD <Field name 1>,
              <Field name 2>, 
              <Field name 3>,
              <Field name 4>.
          MODULE check_input.
    ENDCHAIN.
```

### Controlling of Error Dialogs
B4.P461.  
필드별 순서에 따라 check 모듈을 각각 진행시킴  

```abap 
    Flow Logic의 PAI 하단
    FIELD <A> MODULE chdeck_A.
    FIELD <B> MODULE chdeck_B.
    CHAIN.
        FIELD <C>, <D>.
          MODULE check_CD.
    ENDCHAIN.
    CHAIN.
        FIELD <C>, <B>.
          MODULE check_CB.
    ENDCHAIN.
    *--------------------------------
    *       체크 모듈에서는...
    MODULE check_cb input.
        ...
      MESSAGE E ... .
    ENDMODULE.
```
---
## Conditional Module Calls

    INPUT CHECK의 조건을 걸 수 있는 MODULE의 ADDITIONAL KEY WORD.
    

### Execution when input field is not initial.

- `ON INPUT.`  
Module의 Checck 대상 Field가 Initial이 아닐 때,  
 해당 모듈을 실행해서 인풋 체크 실행

- ` ON CHAIN-INPUT.`  
Chained 인풋 체크할때도 additional Key word를 사용하면됨.

### Execution on Change.
- `ON REQUEST.`  
해당 Module의 Checck 대상 Field에 User Action이 발생했을 때, 인풋 체크 실행

- `ON CHAINED-REQUEST.`    
Chained Field에 변화가 발생했을 때 시행한다는 조건.

### Avoiding of Field Input Checks

    값을 잘못입력했을 때 화면에서 벗어나기

1. Fuction code의 타입을 EXIT로 설정해야 함.
2. 해당 Escape FCT 코드를 이용해여 EXIT 모듈을 새로 생성한다.
3. 해당 모듈은 꼭 `AT EXIT-COMMAND` Additional Key를 사용해야한다.

[펑션코드의 타입 종류들 참고](../Week3/SAP_TAW10_ABAP_SCREEN_PROGRAM.md)

---
## Navigation and INput help Handling

&nbsp;&nbsp;&nbsp;&nbsp;**B4.P467**  


![네비게이션](..\screenShot\Week4\Navigator_image.jpg)



|구분|BACK<br>CHANGE SESSION|EXIT|CANCEL|
|---|:---:|:---:|:---:|
|Save Dialog|가능|가능|불가|
|Check entries|가능|가능|불가|
|Sequence|체크하고<br>Dialog 저장|Dialog 저장하고<br> 체크| - |
|Function Type|' '<br>즉, 노말타입|'E'|'E'|
|예시문|Data를 저장할까요?|Data를 저장할까요?|저장하지 않은 Data는 삭제됩니다.<br>취소할까요?|
|Function Module <br> for Dialog|pop_to_confirm|pop_to_confirm|pop_to_confirm|
