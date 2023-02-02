# Local class 
## Local class 정의

클래스에는 퍼블릭 컴포넌트와 프라이빗 컴포넌트로나눠짐
그리고 메쏘드를 설치하는 부분이 존재한다.


퍼블릭에는 주로 메쏘드와 이벤트가 존재하고

프라이빗에넌 데이터 타입과 어트리뷰트가 존재한다.


- 일반적으로!
    - 퍼블릭 부분은 ABAP의 어느 프로그램에서든 접근이 가능하다.

    - 하지만 프라이빗에서는 해당 클래스에서만 접근이 가능하다.

---
1. local 클래스는 lcl_로 명명한다.
클래스를 정의하면 
클래스를 설치하는 선언이 필요하다.

즉
```abap
    CLASS lcl_class DEFINITION.
    ENDCLASS.

    CLASS lcl_class IMPLEMENTATION.
    ENDCLASS.
```

## attribute 정의

ㅇ리반적인 데이터같은 어트리뷰트도 존재하는데 
다른 오브젝트를 포인트하는 어트리뷰트도 존재할 수 있다.

abap 프로그램과 동일한 방식으로 타입 선언하고 상수 선언하고 변수 선언하는 방식은 완전 동일함.
- 다른 오브젝트를 포인팅하는 어트리뷰트는 `DATA \<해당 어트리뷰트\> TYPE REF to \<다른 오브젝트의 어트리뷰트\>`
- 클래스의 어트리뷰트에는 `READ-ONLY` 라는 추가 구문이 올 수 있다.
    - 말 그대로 읽을 수만 있는 변수임,

- 퍼블릭에 선언된 어트리뷰는 어디서든 접근할 수 있고
    프라이빗에 선언된 어트리뷰는 해당 클래스에서만 접근이 가능하다.
    퍼블릭에서 어트리뷰트를 선언할 수 있지만 데이터 캡슐화를 위해 프라이빗으로 보호하는게 좋다.

- 클래스로 생성하는 오브젝트마다 새롭게 생성되는 데이터를 인스턴스 어트리뷰트라고함.
    - 일반적인 방식으로 선언하는 데이터 `DATA : mv_maker TYPE string.`

- 한개 클래스에서 인스턴스가 몇개가 생기 던지 유일하게 존재하는 것이 스태틱 어트리뷰트이다.
    - `CLASS-DATA : gv_n_o_vehicles TYPE i.`


---

## 메쏘드 생성

클래스의 메소데ㅡ에서 사용하는 파라마터는 시그니처라고 불른다.

메쏘드로 전달하는 것은 IMPORTING 
나가는거는 EXPORTING
왔다갔다 하는 거는 CHANGING

RETURNING VALUE 라는 특별 한것이 있는데, 오직 파라미터 하나만 선언해서 쓸수 있다

에러 처리를 위한 EXCEPTION 클래스도 올 수 있다.
    - exce
    - 

위의 사항을 준수해서 메쏘드를 선언하면

메쏘드 설치가 필요하다
```abap
    CLASS lcl_class DEFINITION.
        METHOD method_name.

    ENDCLASS.

    CLASS lcl_class IMPLEMENTATION.
        method method_name
            ...
        endmethod.

    ENDCLASS.
```

---
### 스테틱 메쏘드와 인스턴스 메쏘드
 인스턴스가 생성될때마다 생기는 메쏘드가 인스턴스 메쏘드
`METHODS method_name` 으로 선언할 수 있고.
인스턴스 어트리뷰트든 스태틱 어트리뷰트든 상관없이 모두 접근할 수이따.


 클래스에 오직 1개만 존재만 존재하는 메쏘드가 스태틱 메소트
`CLASS-METHODS method_name`으로 선언할 수 있다.
스태틱 메쏘드는 오직 스태틱 컴포넌트만 ACCESS 할 수 있다.


---
실습 프로그램 ZABAP_E01_044

---

# CREATE OBJECT

오브젝트의 생성은 `DATA : go_인스턴스명 TYPE REF TO 클래스명 ` 문법을 사용한다.

```abap
    DATA : go_vehicle1 TYPE REF TO lcl_vehicle,
           go_vehicle2 LIKE go_vehicle1.
           go_vehicle3 LIKE go_vehicle1.
    CREATE OBJECT go_vehicle1 .
    go_vehicle2 = go_go_vehicle1.    " go_vehicle1과 같은 오브젝트를 포인팅한다.
    CREATE OBJECT go_vehicle3 .       " 새로운 vehicle 오브젝트가 생성됨.
  
```

## GArbage collector

63페이지 다시보자

     각각의 레퍼ㅓㄴ스 베리어블이 다른 오브젝트를 포인트하고 있고 한개 레퍼런스 오브젝트가 다른 오브젝트를 포인팅하고 있을깨
     포인으 연걸된 클래스가 삭제됐을때 오ㅡ젝트의 레퍼런스의 베리어블을 포인트 하고있는 옵ㅈ젝트가 자동으로 삭제되고 있는데

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
        exporting iv_par = val_ex ...
        imporitn ev_par = val_im ...
        changing dv_par = val_chg ...
        RECEIVING rv_par = val_res ...
        EXCEPTIONS exception = val_rc ... .

    * METHOD 압축 문법
    <ref>-><method_name>(
        exporting iv_par = val_ex ...
        imporitn ev_par = val_im ...
        changing dv_par = val_chg ...
        RECEIVING rv_par = val_res ...
        EXCEPTIONS exception = val_rc ...
    ).

```

오브젝트를 생성 한 이후에 메쏘드를 호출 할 수 있따!!!!!!!!!!!!!!!!!!

## STATIC METHOD



## FUNCTIONAL METHOD
returning parameter가 선언된 메쏘드를 함수형 METHOD라고 한다.

RETURN은 오직 1개만 할 수 있다.

7.4 이전 버전에서는 리터닝 파라미터가 존재할 때 익스포팅과 체인징 파라미터를 쓸 수 없다.

리턴을 사용했을때는 명시적으로 RECEIVING을 선언하거나 
1. 
2. 
3. 
구문을 사용하여 묵시적으로 받을 수있다.

리터닝 파라미터는 1개만 존재할 수 있으니까 이렇게 받ㅇ르 수도 있다.
```
    result = 
    result = class_name=>func_method_name (iv_par1 = val_ex1 ...).

```



실제 예시는 75페이지를 보자.


결론 METHOD를 함수로 사용하는 방법이다. 함수는 무조건 RETURN값이 하나이니까.


## Public Attribute access
만약에 PUBLIC SECTION에 attribute가 선언됐다면  
`gv_maker = go_vehicle->mv_maker. `  
이렇게 값을 전달 받을 수 있다.


# IMPLEMENT CONSTRUCTOR
    오브젝트를 생성하는 특별한 메쏘드

# IMPLEMENT CLASS CONSTRUCTOR
  