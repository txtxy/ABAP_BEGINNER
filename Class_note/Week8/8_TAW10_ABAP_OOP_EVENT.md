# EVENT in Local CLASS
&nbsp;&nbsp;&nbsp;&nbsp;P224.

오브젝트에서 이벤트가 발생이되면

보내는 것을 센더

받는 것은 핸들러 혹은 RECIPIENT라고함

이벤트가 생성되는 클래스를 레이징 클래스라고함 (Rising Class)

이벤트를 받아서 처리하는 클래스를 Handler Class라고 하고
 이벤트를 처리하는 Method를 handler Method라고 함,


## 이벤트의 정의는
클래스 DEFINITION에
`EVENTS <name> [Exporting value(ev_par) type <typename> ].`

클래스 IMPLEMENTATION에
```abap
    method <methodname>
        raise event <event name> [ exporing rv_par = iv_par ].
```

## 이벤트 핸들러는
    주로 PUBLIC SECTION에서 처리됨.
```abap 
    CLASS <RECIPIENT_class_name> DEFENITION.
        METHOD <handler-name> FOR EVENT <event_name>
                    OF <event_class_name>
                    IMPORTING SENDER.
    ENDCLASS.
    -----------------------------------------------------------
    CLASS <RECIPIENT_class_name> IMPLEMENTATION.    
        METHOD <HANDLER-NAME>.
            ...
        ENDMETHOD.
    ENDCLASS.
```
## 핸들러 등록

```abap
    set handler ref_handler->in_eventname
        [FOR ref_sender | FOR ALL INSTANCES]

```

# EVENT in LOCAL INTERFACE
이벤트 핸들러와의 차이점

1. 인터페이스에 이벤트를 정의
2. 인터페이스룰 상속받은 클래스에서 이벤트 발생
3. 핸들러 클래스에서 이벤트를 구현함.
4. 이벤트 핸들러 등록도 필요함.
