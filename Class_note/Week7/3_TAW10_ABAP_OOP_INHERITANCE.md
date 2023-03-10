# Implementation Of Inheritance

클래스 간에는 상속의 관계가 존재한다.

- 부모 클래스는 Super Class라고 부름
    - 서브 -> 슈퍼 = 일반화 (Generalization)
- 자식 클래스는 Sub Class라고 부름
    - 슈퍼 -> 서브 = 특별화 (Spetialization)

- Sub Class들의 공통적인 컴포넌트를 슈퍼클래스에서 정의 
- 각기 서브클래스에서는 Sub Class만의 특별한 부분만 선언  

* Sub Class들의 공통적인 부분은 부모클래스에서 상속 받아오면 됨.  

---- 
## 예시 

차량 Super Class에는   
트럭 Sub Class / 승용차 Sub Class / 버스 서브클래스  
<br>  
공통적인 어트리뷰트 :  색상, 매이커 등등    
  
공통적인 메쏘드    :     앞으로가기 , 좌회전,우회전, 정지 등등

<br>
트럭만의 어트리뷰트 화물칸, 화물 리프트    
   
트럭만의 메쏘드 화물칸 열기. 화물리프트 오르내리기.


---

## 문법

```abap
    CLASS cl_truck DEFINITION INHERITING FROM lcl_vehicle.
        METHODs diplay_attributes REDEFINITION. 

        * 부모의 메쏘드와 같은이름으로 정의하되, 
        * REDEFINITION임을 선언

    ENDCLASS.
```

아무리 상속을 받았다 해도 프라이빗 섹션에 있는 부분은 Sub Class에서 바로 접근할 수는 없다,

Sub Class에서 수퍼클래스의 메쏘드를 호출할 때에는

```abap
    CLASS cl_truck IMPLEMETATION.
        METHOD diplay_attributes.
            super-><메쏘드 이름> ( ... ).
        ENDMETHOD.
```



## Sub Class의 컨스트럭터
&nbsp;&nbsp;&nbsp;&nbsp;**P.120**

자식만의 컨스트럭터 메소드를 정의할 수 있다.
자식 클래스에서는 무조건 명시적으로 슈퍼클래스의 컨스트럭터를 호출해줘야한다.

```abap
    *----------------------------------------------------
    CLASS lcl_truck IMPLEMETATION.    
        METHOD constructor.
            super->constructor ( iv_make_v = iv_make_t ).
            mv_cargo = iv_cargo_t.
        ENDMETHOD.
    ENDCLASS.    
```
스태틱컨스트럭터가 슈퍼와 서브에 동시에 존재할때에는

1. Super Class의 스태틱 컨스트럭터가 먼저 실행되고
2. 다음으로 Sub Class의 스태틱 컨스트럭터가 실행
3. 다음으로 Sub Class의 인스턴스 컨스트럭터가 실행
4. 다음으로 Super Class의 인스턴스 컨스트럭터가 실행


## 상속과 명시성

Super Class에는 `PROTECTED SECTION`을 생성할 수 있다.

`PUBLIC SECTION`과 `PRIVATE SECTION`사이에 선언해야한다.

클래스안에서 확인가능하고 모든 서브클래스에서 활용가능함.


Super Class의 Public Section과 protected Section에 Sub Class는 접근이 가능하다.

Super Class의 Private Section은 Sub Class에서 직접 접근이 불가능하다.


123페이지 정리가 필요하다.

- 퍼브

- 스테틱 메쏘드는 리디피니션이 불가능하다

- 슈퍼클래스에 스태틱 컨스트럭터는 자식 클래스에 처음 억세스되어질때 자동적으로 호출된다.

- 자식클래스는 부모클래스의 스태틱 컨스트럭터와 무관하게 자신만의 스태틱 컨스트럭터를 선언할 수 있다.

- 스태틱 컨스트럭터의 실행 순서는 ( 부모 클래스 -> 자식클래스 ) 순서로 생성된다.