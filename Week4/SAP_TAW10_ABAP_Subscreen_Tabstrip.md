# Tabstrip Controls

연관된 Subscreen을 TAB으로 묶어서   
보기 편하게 만드는 목적으로 생성   

## Tabstrip 생성

상단의 탭 제목을 선택해서 각 탭을 교체하며 볼수 있음.  
각각의 탭페이지는 Subscreen Area과 Subscreen으로 만들어짐.  

### Tabstrip Attributes

### 생성 실습
1. #### **Tabstrip Area 생성** 
    - Screen 레이아웃에서 기본 생성
    - Tab이름과 Tab 개수 선언.
    - 다른 Screen Elements와 마찬가지로 이름을 통해 Identification
     ![TAB_quantity_Setting](../screenShot/Week4/TAB_quantity_Setting.png)


2. #### **Tabstrip Setting** 
   **TOP INCL**  
    - 레이아웃과 동일하게 TOP에 생성  
    - TOP에 선언 방식   
    `CONTROLS : my_tabStrip TYPE TABSTRIP.`  

   **스크린 레이아웃**

    - Tab 선택 User Action을 받아 줄 Function Code 생성
        - Tab에 따라 UNIQUE하게 작성.
        - 사용하는 FCT CODE 종류는 호출 방식에 따라 달라짐

    - Tab별 Title과 Subscreen 호출 방식 선택
        - Local Scrolling 방식
        - PAI Scrolling 방식
            1. Normal TYPE EQ 'NONE'
            2. 'P' type LOCAL GUI Function

3. **Subscreen 설정**   
    - 호출 방식에 따라 Subscreen 생성 및 Tab과 연결

## Tabstrip 처리

tabstrip을 명확하게 방식을 구분해서 코드를 작성해야한다.

Local Scrolling의 경우
    1. Subscreen을 Main screen 생성시 모든 스크린이 동시에 구현된다.

---
### Local Scrolling

    각각의 TabPage에 subscreen Area를 각각 사용하는 방법.

탭페이지를 선택 했을 때 탭페이지가 이동되지만,  

1. TOP에 TABstrip 변수 생성

2. 레이아웃에서 탭 스트립 생성
    1. 탭 스트립 박스 생성
    2. 탭 개수 설정
    3. 각 탭 NAME 설정
    4. 
    5. 
     

FCT는 P를 이용해서 Tab Page 사용  
메인 screen의 PAI가 실행되지 않음.  

PBO에는 `CALL SUBSCREEN`이 모두 와야함.      

따라서

PAI에서는
 유저가 선택한 TabPage를 Active tab으로 설정하기

PBO에서는 
Display 하고자 하는 TabPage의 subscreen을 지정해야한다.

---
### PAI Scrolling
    Subscreen AREA 1개로 여러 TabPage를 이용하는 방법.
    
펑션 타입은 노말로 온다
동적 Subscreen 설정하는 방식 처럼 
active TAB을 펑션 코드로 선택함. 

 PAI에서는 