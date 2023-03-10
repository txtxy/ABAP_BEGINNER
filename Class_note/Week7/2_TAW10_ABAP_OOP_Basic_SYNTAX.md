

# Local class   
## Local class 정의  
  
Class는
- Public Components와
- Private Components   
로 구분된다.

---

**일반적으로!**  
Public Section에는  `METHODS`와 `EVENT`를 선언하고 
  
Private Section에는 `TYPES`와 `Attribute`를 선언한다.
  
- Public 부분은 ABAP의 어느 프로그램에서든 접근이 가능하다.  
- 하지만 Private section의 Components는 해당 Class에서만 접근할 수 있다.  
    - 예시  
        a Class의 \<Pri\> Method는 \<Publ\> Method의 내부 계산을 위해 선언함.  
        따라서, 외부 프로그램에서는 \<Pri\> Method를 호출할 수 없도록 Private Method로 설계했음.
        
---  

## 명명법
|단위|접두사|설명|예시|
|---|---|---|---|
|클래스| LCL |로컬 클래스|`CLASS lcl_class DEFINITION. `|
|오브젝트| GO |메인 프로그램 전역에서 사용할 오브젝트 변수|`DATA : GO_OBJECT TYPE REF TO lcl_class`|
|오브젝트| LO |메쏘드 내부 등에서 활용할 로컬 오브젝트 변수| `DATA : lo_object TYPE REF TO lcl_class`|


## CLASS 정의(DEFINITION)와 구현(IMPLEMENTATION)
Class를 정의하면   
Class를 설치하는 선언이 필요하다.  
  
**즉**,  
```abap  
    CLASS lcl_class DEFINITION.  
    ENDCLASS.  
  
    CLASS lcl_class IMPLEMENTATION.  
    ENDCLASS.  
```  
  
---

## Attribute 정의  
  
일반적인 데이터같은 Attribute도 존재하는데   
다른 오브젝트를 Pointing하는 Attribute도 존재할 수 있다.  
  
abap 프로그램과 동일한 방식으로 타입 선언하고 상수 선언하고 변수 선언하는 방식은 완전 동일함.  

- 다른 오브젝트를 포인팅하는 Attribute는 `DATA \<해당 Attribute\> TYPE REF to \<다른 오브젝트의 Attribute\>`  
- Class의 Attribute에는 `READ-ONLY` 라는 추가 구문이 올 수 있다.  
    - 말 그대로 읽을 수만 있는 변수이다.(변경할 수 없음.)  
  
- Public에 선언된 Attribute는 어디서든 접근할 수 있고  
    Private에 선언된 Attribute는 해당 Class에서만 접근이 가능하다.  
    Public에서 Attribute를 선언할 수 있지만 데이터 캡슐화를 위해 Private으로 보호하는게 좋다.  
  
- Class로 생성하는 오브젝트마다 새롭게 생성되는 데이터를 Instance Attribute라고함.  
    - 일반적인 방식으로 선언하는 데이터 `DATA : mv_maker TYPE string.`  
  
- 해당 Class에서 인스턴스가 몇개가 생기 던지 유일하게 존재하는 것이 Static Attribute이다.  
    - `CLASS-DATA : gv_n_o_vehicles TYPE i.`  
  
---  
  
## Creation of Method  
  
- Class의 Method에서 사용하는 Parameter는 signiture라고 한다.  
    - Method로  보내는 것은   IMPORTING  
    - Method에서 나가는 거는  EXPORTING  
    - 왔다갔다   하는 거는    CHANGING  
  
- Method를 다른 언어의 함수처럼 사용할 수 있는 것이 있다.
    - Method의 시그니처를 RETURNING VALUE로 선언하면
    - 오직 한 개의 Signiture만 입력되고 반환된다.
    - 즉, `return <value>`와 같은 구조가 된다.

- 에러 처리를 위한 EXCEPTION Class도 올 수 있다.  
    - cs_로 시작하는 에러 Class가 존재한다.
    - Exception Class로 에러 처리를 한다면 `TRY catch` 구문을 사용한다  
        대표적으로 `cx_sy_move_cast_error`
- Classic Exception handling 방식
    - 계속사용해왔던 `Exceptions erro1 = 1.` sy-subrc로 호출하는 그방식.

---

### Implementaion Method  
  
클래스와 마찬가지로 Method 또한 정의 이후에 구현이 필요하다  
```abap  
    CLASS lcl_class DEFINITION.  
        METHOD method_name.  
  
    ENDCLASS.  
    ---------------------------------------------
    CLASS lcl_class IMPLEMENTATION.  
        method method_name  
            ...  
        endmethod.  
  
    ENDCLASS.  
```  
  
---  

### 스테틱 Method와 인스턴스 Method  

#### Instance Method

인스턴스에 종속되는 Method가 인스턴스 Method   
`METHODS method_name` 으로 선언할 수 있고.    
인스턴스 Attribute든 스태틱 Attribute든 상관없이 모두 접근할 수 있다..    
  

#### Static Method
  
Class에 오직 1개만 존재만 존재하는 Method가 스태틱 메소트  
`CLASS-METHODS method_name`으로 선언할 수 있다.  
스태틱 Method는 오직 스태틱 Components만 ACCESS 할 수 있다.  
  
  
---  

실습 프로그램 ZABAP_E01_044  
  
---  
  
# CREATE OBJECT  
  
오브젝트의 생성은 `DATA : go_인스턴스명 TYPE REF TO Class명 ` 문법을 사용한다.  
  
```abap  
    DATA : go_vehicle1 TYPE REF TO lcl_vehicle,  
           go_vehicle2 LIKE go_vehicle1,  
           go_vehicle3 LIKE go_vehicle1.  

    CREATE OBJECT go_vehicle1 .  
    go_vehicle2 = go_go_vehicle1.    " go_vehicle1과 같은 오브젝트를 포인팅한다.  
    CREATE OBJECT go_vehicle3 .       " 새로운 vehicle 오브젝트가 생성됨.  
    
```  
  
## Garbage Collector  
  
63페이지 다시보자  
  
     각각의 레퍼런스 베리어블이 다른 오브젝트를 포인트하고 있고 한개 레퍼런스 오브젝트가 다른 오브젝트를 포인팅하고 있을깨  
     포인으 연걸된 Class가 삭제됐을때 오ㅡ젝트의 레퍼런스의 베리어블을 포인트 하고있는 옵ㅈ젝트가 자동으로 삭제되고 있는데  
  
     만약에 다른 레퍼런스를 포인팅 하고 있는 오브젝트의 경우에는 삭제되지 않는다.  
  
## MULITPLE INTENCES  
셍성된 오브젝트를 인터널 테이블에 저장할 수있다.  
오브젝트를 선언할때   
`gt_vehicles TYPE TABLE OF REF TO lcl_vehicle.`  
  
```abap  
    create OBject go_vehicle1.  
    append go_vehicle to gt_vehicles.  
  
    create OBject go_vehicle2.  
    append go_vehicle to gt_vehicles.  
  
```  
  
---  
실습 프로그램 ZABAP_E01_044  
  
---  
  
# METHOD AND ATTRTIBUTE ACCESS  
  
P72. 고대로복사하기!  
  
mehtod의 RETURNING VALUE를 통해 값을 보낸 것을   
METHOD를 호출하고서는 RECEVING 으로 값을 받는다!!!!  
  
## INSTANCE METHOD  
  
  
```abap  
    * 기본 호출 문법  
    CALL METHOD <ref>-><method_name>  
        EXPORTING iv_par = val_ex ...  
        IMPORTING ev_par = val_im ...  
        CHANGING dv_par = val_chg ...  
        RECEIVING rv_par = val_res ...  
        EXCEPTIONS exception = val_rc ... .  
  
    * METHOD 압축 문법  
    <ref>-><method_name>(  
        EXPORTING iv_par = val_ex ...  
        IMPORITN ev_par = val_im ...  
        CHANGING dv_par = val_chg ...  
        RECEIVING rv_par = val_res ...  
        EXCEPTIONS exception = val_rc ...  
    ).  
  
```  
  
오브젝트를 생성 한 이후에 Method를 호출 할 수 있다!!!!!!!!!!!!!!!!!!  
  
## STATIC METHOD  
  
  
  
## FUNCTIONAL METHOD  
returning Signiture가 선언된 Method를 함수형 METHOD라고 한다.  
  
RETURN은 오직 1개만 할 수 있다.  
  
7.4 이전 버전에서는 Returning Signiture가 존재할 때 익스포팅과 체인징 Signiture를 쓸 수 없다.  
  
리턴을 사용했을때는 명시적으로 RECEIVING을 선언하거나   
1. MOVE,CASE, LOOP 문  
2. 논리 조건문(if,while,wait until)  
3. 연산문 (Compute)   
구문을 사용하여 묵시적으로 받을 수있다.  

- RETURN 값에 따라 다르지만 한개 변수(Varuable)로 간주하는 것이라고 볼 수있나?

Returning Signiture는 1개만 존재할 수 있으니까 이렇게 받을 수도 있다.  
```  
    result = class_name=>func_method_name (iv_par1 = val_ex1 ...).  
  
```  
  
  
  
실제 예시는 75페이지를 보자.  
  
  
결론 METHOD를 함수로 사용하는 방법이다. 함수는 무조건 RETURN값이 하나이니까.  
  
  
## Public Attribute Access  
만약에 PUBLIC SECTION에 attribute가 선언됐다면    
`gv_maker = go_vehicle->mv_maker. `    
이렇게 값을 전달 받을 수 있다.  
  
 --- 

# IMPLEMENT CONSTRUCTOR  
&nbsp;&nbsp;&nbsp;&nbsp;P.83  

- 오브젝트를 생성하는 특별한 Method를 Constructor 라고 한다.  
- 일반적으로 명시적 호출이 불가능하다.
- 딱, 1가지 예외를 제외하고서 ->  SUBCLASS의 Constructor를 선언할때!!!

- Constructor를 설정해놓았다면.  
    1. 오브젝트가 생성될때 자동적으로 Constructor가 실행되고,
    2.  Constructor에 의해 Object가 생성된다.  
  
- Constructor는 IMPORTING과 EXCEPTION만 가질 수 있다.  
    - 당연하다 오브젝트를 생성할 수 있도록 해주는 것이기에.
  
- Class당 1개의 CONSTRUCTOR만 올 수 있다.  

- 따라서 METHOD 이름은 `CONSTRUCTOR` 라는 이름만 와야한다!!!!!!!!!!!!!!!!!!  
  
- PUBLIC-SECTION에만 선언해야한다.  
    - 당연하다 오브젝트를 생성할 수 있도록 해주는 것이기에.


```ABAP  
    CLASS classname DEFINITION.  
        METHODS constructor  
        [  
            IMPORING  
                iv_par TYPE ...  
            EXEPTIONS  
                exception  
            RAISING   
                exception_class   
        ].  
    ------------------------------------------  
    CREATE OBJECT <ref>  
        EXPORTING   
            iv_par = val_ex ...  
        EXCEPTIONS  
            exception = val_rc ... .  
```  
  
- Constructor로 호출했으나 기준에 맞지않아 오브젝트가 생성되지 않았는데  
생성되지 않은 오브젝트를 호출하려고하면 Short Dump가 발생한다.
- 마찬가지로 오브젝트가 존재하지 않는 데 Method를 호출하거나하면 Dump가 발생한다.

---
  
# IMPLEMENT CLASS CONSTRUCTOR = Static Constructor  
&nbsp;&nbsp;&nbsp;&nbsp;P.96

Static Constructor의 자동 호출은

1. 오브젝트가 생성될 때 
2. 스태틱 어트리뷰트에 접근할 때
3. 스태틱 메쏘드가 호출됐을 떄
4. 이벤트 헨들러가 등록 됐을 때

의 상황중 한가지만이라도 발생하면 프래그램 중 단 한 번만 실행된다.

- PUBLIC SECTION에 만 선언할 수 있다.
- 클래스당 1번만 선언할 수 있다.
- `RETURNING VALUE`, `EXCEPTION` 은 불가능하다.


# Self-Reference


같은 이름으로 메쏘드와 어트리뷰트에 변수가 선언됐을 때!

어트리뷰트를 우선으로 변수를 사용하고자한다면  

`me->\<변수명\>`의 형식을 이용한다면 같은 이름으로 변수를 사용할 수있다.

같은 이름이 없을 때에는 `me->`가 없더라도 크게 지장이 있지않다.