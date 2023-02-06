# DOWNCAST
    전제 조건은 상속(Inheritance)

## 기본 문법  
```ABAP
    <go_자식오브젝트> ?= <go_부모오브젝트>
```
## 사용시기

- UPCAST된 Object는  
    SUPERCLASS에서 **상속받은 Component만** 접근할 수 있다.

- 따라서 SUBCLASS에서 새로 **확장한 Attribute**는  
    SUBCLASS에 DOWNCAST하여 접근할 수 있다????


- 아래 예시에서 알 수 있듯이,  
    DOWNCAST를 활용할 떄는 **에러 처리를 필수적으로 선언**해야한다.

---

## 예시
```abap
    class lcl_truck IMPLEMENTATION.
        METHOD get_max_cargo.
            data lo_vehicle REF TO LCL_vehicle.
                LOOP AT mt_vehicle INTO LO_vehicle.

                    TRY.
                        lo-truck ?= lo_vehicle.
                            ...
                    CATCH cx_sy_move_cast_error.
                            ...(에러 이후 처리)
                    ENDTRY.
                ENDLOOP
        ENDMETHOD.
    ENDCLASS.
```


1. mt_vehicle은 부모 클래스인 LCL_VEHICLE의 오브젝트로 구성된 테이블이다.  

2. 현재 자식 클래스가 아닌 다른 자식 클래스의 오브젝트는 UPCAST되어  
부모 클래스에서 오류 없이 접근할 수 있다.  

3. **하지만**, 자식클래스에서는  
다른 자식클래스의 REDEFINITION된 사항을 알 수 없다.

4. **따라서**,LOOP 문을 통해 다운 클래스된 항목을 찾아,    
    필요한 로직을 수행하고.  

5. 이외 **알 수 없는 항목**에 대해서는 오류가 발생할테니,  
    TRY CATCH 구문을 통해 ERROR HANDLING한다.  