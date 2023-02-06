# UPCAST
&nbsp;&nbsp;&nbsp;&nbsp;**P.135**

전제조건은 **상속관계일때**만 가능하다.

SUBCLASS에서 생성한 Attribute를 SUPERCLASS에게 전달하는것.

SUBCLASS의 Object를 SUPERCLASS의 Object에 할당하는것을 UPCAST라고 하고

UPCAST가 되면 SUPERCLASS의 Referance Value는 자식클래스가 상속받은 Component에 Access됨.

---

간단한 활용을 보자면

부모 클래스를 레퍼런스로 부모 테이블을 생성했다.

그러면 부모_테이블의 구성 요소는 부모 오브젝트인데,

부모 클래스로부터 상속 받은 자식 오브젝트가 존재한다면,

자식 클래스를 부모 테이블에 입력할때

상속받은 내용과 더불어 Redefinition한 부분까지 부모 클래스의 테이블에 입력될 수 있다.



---
## static type of reference variable
- Defined using `TYPE REF To`
- Remains the same throughout the program flow
- 

## dynamic type of reference variable
- determined by the assignment


