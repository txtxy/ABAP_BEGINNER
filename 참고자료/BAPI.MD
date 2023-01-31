# 개요

BAPI란 Business Application Programming Interface의 약자
입니다. 즉, 이런저런 API 함수의 모음이 아니라, Business
흐름을 직간접적으로 만들어내는 API라는 얘깁니다.


# 진짜 도움말

SAP 온라인 Help를 참조하세요.

SAP Library
           --> Basis Components
                               --> Middleware
                                             --> BAPI


# 쓰임새

BAPI는 타 시스템과의 Integration을 염두에 두고 만들어졌습니다.
즉, 비주얼베이직, 자바, C++, Lotus Notes 등의 타 시스템에서
SAP의 Business Flow를 이용할 수 있게 되어있답니다.

예) Sales Order Creation, Purchase Order Creation, FI Document Creation
등 SAP의 핵심 기능들이 BAPI로 새롭게 조직되어있답니다.


# 관련매뉴

버전마다 차이는 있지만, 다음매뉴를 참고하세요.

Tools  
--> Business Framework  
--> BAPI Browser  

다양한 계층구조가 나타납니다. 맘에 드는 놈을 골라서
펼쳐보세요.

예)
  
 |  
 |-----영업/유통  
 |         |  
 |        영업  
 |         |  
 |         |-- CustomerInquiry            고객문의  
 |         |-- CustomerQuotation          고객견적  
 |         |-- SalesOrder                 판매오더  
 |

여기서 SalesOrder를 더블클릭해보세요.  
......  

Methods가 다섯개가 나옵니다(*버전마다 틀림*).  

  
SalesOrder              판매오더  
 |  
 |----- 키필드   
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|  
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- SalesDocument                          영업문서  
 |  
 |  
 |----- 방법  
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|   
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- CreateFromDat1                         판매오더: 판매오더생성  
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- CreateFromData                         판매오더 생성  
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- GetList                                고객의 모든 오더리스트  
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- GetStatus                              판매오더상태조회  
 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- Simulate                               판매오더시뮬레이션  
  

이제 Function Builder에 가셔서 BAPI_SALESORDER* 를 입력하고  
F4를 눌러보세요. 역시 다섯개의 함수리스트가 나올겁니다.  
대충 감을 잡았겠지만, Methods들과 1:1로 대응되는 함수들입니다.  

\=====================================================================  
Function 그룹                            Function 그룹단문  
\=====================================================================   
Function 모듈                  짧은이름  
\=====================================================================  
2032                                     Business Object Sales Order  
\---------------------------------------------------------------------  
BAPI_SALESORDER_CREATEFROMDAT1 판매오더: 판매오더생성  
BAPI_SALESORDER_CREATEFROMDATA 판매오더: 판매오더생성  
BAPI_SALESORDER_GETLIST        판매오더: 고객에 대한 전체 오더 리스트  
BAPI_SALESORDER_GETSTATUS      판매오더: 상태조회  
BAPI_SALESORDER_SIMULATE       판매오더: 판매오더 시뮬레이트  
\---------------------------------------------------------------------  
  
BAPI_SALESORDER_CREATEFROMDATA 함수의 쏘스를 한 번 분석해보세요.  
조금만 해보라는겁니다. 
 
SD_ORDER_CREATE_WWW 함수를 호출합니다.  
다시 SD_ORDER_CREATE_WWW 함수는 SD_ORDER_CREATE 함수를 호출합니다.  

SD_ORDER_CREATE는 Sales Order를 생성하는 트랜젝션인 VA01 에서 젤 나중에
호출되는 중요한 Business 관련 함수죠.  


# 분석 및 추측

- SAP의 많은 비지니스FLOW가 이미 BAPI로 구현되어 있습니다.  
- BAPI의 BO(Business Object)마다 키필드와 Methods가 있습니다.  
- 각 Methods는 Function과 1:1로 매칭됩니다.  
  즉, Methods를 이용하는 것과 Function을 호출하는 것은 완전 동일합니다.  
- BAPI_ 로 시작되는 함수들은 다른 시스템 및 언어에서 쉽게 호출할 수 있으며.  
  SAP의 핵심 함수들을 자체에서 호출하는 기능을 갖고 있습니다.  


# 이용방법

ABAP        : 일단 함수 호출하듯이 BAPI_~ 함수를 호출하면 됩니다.  
              아마 BDC 보다는 Performance가 좋을걸요?  
C           : 일반 RFC 호출하듯이 BAPI_~함수를 호출하면 됩니다.   
C++         : BO를 만들고 Methods를 이용합니다.  
JAVA        : BO를 만들고 Methods를 이용합니다.  
Visual Basic: BO를 만들고 Methods를 이용합니다.  
기타        : 언어의 스타일에 맞춰서 BO를 만들거나 Function을 호출합니다.  


# 주의?

BAPI_~ 함수는 상당히 많은 Import, Export, Tables 파라미터를 가지고 있습니다.  
그러나, 지레 겁먹지 마세요. 대부분은 필수입력이 아니랍니다.  

BAPI_SALESORDER_CREATEFROMDAT1 함수에 입력해야 할 것이라곤, 일반적으로
화면에서 Sales Order를 생성할 때, 넣어주는 거래선, 제품, 수량 정도 밖에
없으니까요.

아마, 다른 함수들도 대동소이할 겁니다.