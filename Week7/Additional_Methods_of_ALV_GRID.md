# cl_gui_alv_grid

SE-24 Class Builder 에서 가능한 Method를 확인할 수 있다.

# Implementing Context Menu
규칙
1. 최대 2 LEVEL로 디자인 하라
2. 메뉴 항목은 최대 10개로 하라
3. 시각적 구분을 위해 구분선을 사용하라.
4. 해당 오브젝트와 관련있는 메뉴가 메뉴 상단에 올 수 있도록 하라

## FLOW
1. 마우스 우클릭
2. CONTECT_MENU_REQUEST 이벤트가 발생
3. 해당 이벤트 햔들러에서 CONTEXT 메뉴가 팝업하도록 진행
4. 특정 메뉴를 context 메뉴에서 선택
5. USER_COMMAND에서 해당 메뉴 실행

## CONTEXT MENU CREATION
1. CREATE-GUI STATUS-context_menu
    - ![create Context menu1](../screenShot/Week7/CONTEXT_MENU.png)
    1. cl_ctmenu 클래스의 load_gui_status 메쏘드 호출
        - Status 파라미터에 생성한 context_menu 이름을 활용.
        - menu 파라미터에 e_object
    2. CL_CTMENU 클래스의 add_function 메쏘드를 호출
        - 펑션 코드와 텍스트를 추가할 수 있음.
        - 즉 CONTEXT MENU를 동적으로 구현할 수 있음.
2. 



### CL_CTMENU CLASS
|METHOD|설명|
|---|---|
|ADD_FUNCTION||
|ADD_SEPARAROT||
|HIDE_FUNCTIONS||
|SHOW_FUNCTIONS||
|DISABLE_FUCTIONS||
|ENABLE_FUNCTIONS||