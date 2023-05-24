# 배포 순서

1.
 npm run build 
 패키지 빌드
2. 
  npm run deploy-config

  - 수행 중 오류 나면 
    npm install -g yo



3. npm run deploy
Target  -> ABAP
Target System -> http://edu.bgis.co.kr:8001 [SYNC-e-01]
Client -> 100
Repository -> ZUI5APP_E01_01
DESCRIPTION ->  설명은 자유
PACKAGE ENTER -> MANUALLY 
PACKAGE -> $TMP
Transport Request ->  MANUALLY 
무지성 엔터 하면 끝

이렇게 Deploy하면 SAP gui 해당하는 페키지에 빌드 패키지가 업로드됨.


## 런치 패드 띄우기
Tcode : /n/ui2/flp (원하는 BSP 디렉토리에서)

## 런치패드 만들기
Tcode : /n/ui2/flpd_cust (원하는 BSP 디렉토리에서)
### 타일 생성
+ 기호로 새로운 런치패드 타일 생성
이름은 적당히하고
타이틀과 id 를 설정한 뒤에
시멘틱 오브젝트를 유니크한 이름으로 생성 네이밍 컴벤션

시멘틱 오브젝트 : ZSO_E01
액션 : dISPLAY

까지하고 저장


이렇게 타일 껍데기를 만들었으면 타겟매핑을 통해 
페이지와 연결 
### 타일  타겟 매핑

타일 껍데기 만들떄 사용한 시멘틱 오브젝트 이름과
액션을 가져옴

이 떄 id는 빌딩한 패키지의 data -SAP-UI-RESOURCEROOTS 에 값이 존재한다.
그걸 고대로 옮겨 넣기


여기까지가 카탈로그 생성

### 그룹생성해야함

런치패드 생성  화면에서 
그룹 탭으로 이동 
\+ 버튼을 눌러 그룹 생성
타이틀은 임의대로 
아이디는 시멘틱 오브젝트와 동일하도록
ZSO_E01로 생성


이후 플러스 버튼으로 보여주고 싶은 런치패드를 찾아서 + 해주면됨

그룹에서 뺴내고 싶다면 드래그 앤 드롭으로 가능함.

### 이그룹을 볼수 있는 권한을 설정해야함
Tcode -> PFCG

ROLE 이름을 작성하고 SINGLE ROLE 로 생성

1. 메뉴 설정
    - 카탈로와 그룹을 등록
    1. 피오리 런치패드 카탈로그 등록
    2. 피오리 런치패드 그룹 등록
    
2. 유저설정
    - 볼수 있는 유저를 설정
순으로 진행
## YEOMAN
