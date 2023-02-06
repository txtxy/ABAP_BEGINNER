# Implementating Polymorphism
&nbsp;&nbsp;&nbsp;&nbsp;**P.144**
## 전제조건
    1. 상속되어있을 것
    2. UPCAST가 되어있을 것.(Generic Access)

## **폴리모피즘이란?** 
* 하나의 Method로 다양하게 표현하는 것!

* SUPERCLASS의 제너럴한 Method를 실행했을 뿐인데,  
    SUBCLASS의 특징적인 Method 구문을 자동을 진행할 수 있도록 하는 것!

- 예를 들어

    - 렌탈 CLASS에서 오브젝트 목록을 저장하는  
        Table Attribute가 있고  
        이 테이블에 APPEND하는 Method가 있을 때

    - 각 차량 CLASS에 따라 Method를 별도로 정의하지 않고

    - SUPERCLASS의 오브젝트로 저장하는 것으로 지정한다면

    - SUPERCLASS 오브젝트는 자동으로 SUBCLASS의 오브젝트 특징을 같이 땡겨와서

    - 렌탈 CLASS 테이블 어트리뷰트에 저장된다.

## 실제 적용


