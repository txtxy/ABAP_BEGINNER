# Docking Container

스크린 레이아웃에 에어리어 생성하지 않아도 됨.

 
```abap
    CREATE OBJECT gv_docking_container
      EXPORTING
        REPID      = SY-REPID
        DYNNR     = SY-DYNNR
        SIDE         = gv_docking_container->DOCK_AT_TOP
        EXTENSION = 3000.
```

---

# Split Container
 

2. CREATE splitter container

```abap
    CREATE OBJECT gv_splitter
      EXPORTING
        PARENT  = gv_docking_container
        ROWS    = 2      *몇개의 행으로 나눌것인지 최대 16
        COLUMNS = 1.   *몇개의 열로 나눌것인지
```
 

 

---

3. 분할한 컨테이너를  gird를 올릴 컨테이너와 연결

```abap
    CALL METHOD gv_splitter->GET_CONTAINER
      EXPORTING
        ROW         = 1    
        COLUMN    = 1
      RECEIVING
        CONTAINER = gv_container_1.
  
```
    => 첫번째 행의 첫번째 열을 gv_container_1 과 연결하겠다는 구문

---

```abap
  CALL METHOD gv_splitter->GET_CONTAINER
    EXPORTING
      ROW         = 2   
      COLUMN    = 1
    RECEIVING
      CONTAINER = gv_container_2.
  ```

    => 두번째 행의 첫번째 열을 gv_container_2 과 연결하겠다는 구문

 
---
 
# 예시 

<변수선언>

 

```abap
    DATA : gv_docking_container TYPE REF TO cl_gui_docking_container,  
              gv_splitter                TYPE REF TO cl_gui_splitter_container,
              gv_container_1          TYPE REF TO  cl_gui_container,
              gv_container_2          TYPE REF TO  cl_gui_container,
              gv_grid_1                TYPE REF TO cl_gui_alv_grid,
              gv_grid_2                TYPE REF TO cl_gui_alv_grid,
```
 

 

 

<화면 분할>

 

1. CREATE docking_container

 
```abap
    CREATE OBJECT gv_docking_container
      EXPORTING
        REPID      = SY-REPID
        DYNNR     = SY-DYNNR
        SIDE         = gv_docking_container->DOCK_AT_TOP
        EXTENSION = 3000.
```
 

 

 

2. CREATE splitter container


  CREATE OBJECT gv_splitter
    EXPORTING
      PARENT  = gv_docking_container
      ROWS    = 2      *몇개의 행으로 나눌것인지 최대 16
      COLUMNS = 1.   *몇개의 열로 나눌것인지

 

 

 

3. 분할한 컨테이너를  gird를 올릴 컨테이너와 연결


  CALL METHOD gv_splitter->GET_CONTAINER
    EXPORTING
      ROW         = 1    
      COLUMN    = 1
    RECEIVING
      CONTAINER = gv_container_1.
  

    => 첫번째 행의 첫번째 열을 gv_container_1 과 연결하겠다는 구문


  CALL METHOD gv_splitter->GET_CONTAINER
    EXPORTING
      ROW         = 2   
      COLUMN    = 1
    RECEIVING
      CONTAINER = gv_container_2.
  

    => 두번째 행의 첫번째 열을 gv_container_2 과 연결하겠다는 구문

 

 

 

4. gird를 올릴 컨테이너 높이(너비) 설정

  CALL METHOD gv_splitter->SET_ROW_HEIGHT
    EXPORTING
      ID      = 1
      HEIGHT  = 50.

 

=> 해당 컨데이터는 두개의 행과 한개의 열로 분리했기 때문에 SET_ROW_HEIGHT를 사용하여

     행의 높이를 설정하는것입니다. (두개의 행으로 나눴으니 순서대로 IID = 1, 2 이다)

     만약 여러개의 열로 분리를 했으면 SET_COLUMN_WIDTH 로 가로너비를 설정해주면됩니다.

 

 

5. ALV GIRD와 연결

 

    CREATE OBJECT gv_grid_1

      EXPORTING
        i_parent = gv_container_1.

 

    CREATE OBJECT gv_grid_2

      EXPORTING
        i_parent = gv_container_2.

 

 

 **참고:  메소드 간단하게 사용방법

    gv_container_1  = gv_splitter->get_container( row = 1 column = 1 ).
