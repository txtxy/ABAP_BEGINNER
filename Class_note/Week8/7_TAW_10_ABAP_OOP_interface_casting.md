# INTERFACE A.K.A PROTOCOL


    인터페이스는 정의만 있고 구현은 없다.

- 언제 사용하는 것인가?  

    <p align = center>
        클래스와 클래스의 관계를 상속 관계로 설정할 수 없는데, <br>
        공통적으로 사용하는 Component가 있을때.
    </p>

##  소스코드 정의
- 명시성 선언을 하지 않는다.
- 모든 컴포넌트는 퍼블릭으로 생성된다.
    - 왜냐면, 연결된 모든 클래스에서 접근해야하니까.  
- INTERFACE의 내부 구분자는 "~"를 이용한다.
  
    
### 인터페이스 정의

```ABAP
    INTERFACE lif_partner.
        METHOD display_partner.
    ENDINTERFACE.
```

### 서버 클래스에 인터페이스 사용 선언.

```ABAP
    CLASS lcl_rental DEFINITION.
    PUBLIC SECTION.
        INTERFACES lif_partner.
    ENDCLASS
```

### 서버 클래스의 인터페이스 구현

```ABAP
    CLASS lcl_rental IMPLEMENTATION.
        METHOD lif_partner~display_partner.   " '~' 틸트로 내부 구조 표현함.
            display_attributes( ).
        ENDMETHOD.
    ENDCLASS
```

### 메인 코드 인터페이스 사용 예시.

```ABAP
    go_rental->lif_partner~display_partner( ).
```

## Simple Access Using ALIASES

```ABAP
    CLASS lcl_rental DEFINITION.
    PUBLIC SECTION.
        INTERFACES lif_partner.
        ALIASES display_partner1
            for lif_partner~display_partner.
            
    ENDCLASS
    --------------------------------------------------------------------

    go_rental->display_partner1( ).

```

## Interface Polymorphism USING UPCAST 

- 인터페이스 




## DOWN-CAST  in the Interfaces

상속 클래스의 DOWN CAST와 동일함.

# Interface의 상속
MULTIPLE 상속이 가능하다.
여러개의 인터페이스를 가지고 각기 다른 클래스와의 상속관게를 만들어 낼 수 있다.


## COMPONENT INTERFACE
 부모 인터페이스

## COMPOUND INTERFACE
 자식 인터페이스