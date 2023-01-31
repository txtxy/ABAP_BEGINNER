# Perfomance Access
<B>&nbsp;&nbsp;&nbsp;&nbsp;B3.P85</B>  

## Create Index

    OPEN SQL로 pk로 DB를 조회할때는  
    Primary Index를 자동으로 생성해서  
    바이너리 서치를 이용하게된다.

- 따라서 OPEN sql로 PK를 이용하는게 성능면에서 좋다.

- PK가 아닌 일반 필드를 바이너리 서치로 접근하고자 한다면  
    세컨더리 인덱스를 생성하여 바이너리 서치로 접근할 수 있다.

- 아밥 딕셔너리에서 크리에이트 인덱스를 통해 세컨더리 인덱스를 생성할 수 있다.  

- 인덱스 이름은 3글자인데 일반적으로 Z나 Y로 시작함

- 인덱스는 데이터 생성 및 업데이트에 부담이 되곤함,

★★★ mandt는 인덱스 선택에 필수임 ★★★

<B>&nbsp;&nbsp;&nbsp;&nbsp;B3.P95</B>  

---
## Table buffering
    실무에서 거의 사용되지 않음.

### Full Buffering
<B>&nbsp;&nbsp;&nbsp;&nbsp;B3.P97</B>  

1. 테이블의 모든 데이터를 조회
2. 테이블 버퍼에 테이블 전체 데이터 저장
3. 이후 버퍼를 이용해서 출력

### Generic Buffering
<B>&nbsp;&nbsp;&nbsp;&nbsp;B3.P98</B>  

이중 조건 쿼리문의 경우 첫번재 조건에 해당하는 내용들만 버퍼에 저장
     
### single Buffering
<B>&nbsp;&nbsp;&nbsp;&nbsp;B3.P99</B>  

조회한 레코드 딱 1개만 버퍼에 저장

---
### Table buffering Setting

데이터 테이블 생성할때 버퍼링 세팅할떄 버퍼링 사용 방법을 설정할 수 있음,

이때 제네릭 버퍼를 사용할때 제네릭키를 설정해야함,

이때에는 제네릭 키는 해당 테이블 키필드 개수 - 1개만 가능함.

* 테이블을 제네릭키에 따라 그룹화해서 버퍼에 저장한다고 생각하면 될듯.

### Table buffering의 문제점

각각의 APS에 버퍼테이블이 저장되고 관리되기 떄문에

트랜잭션 독립성에 위험함.

---
<h4 align = center><b>문제해결을 위한  Table buffering SYNC</b></h4>
<br>

1. &nbsp;1번서버에서 테이블 조회하여 전체 테이블을 버퍼에 저장
2. &nbsp;2번서버에서 테이블 조회하여 전체 테이블을 버퍼에 저장<hr>
3. &nbsp;1번서버에서 로우1개를 삭제
4. &nbsp;1번 서버 버퍼에 변경된 테이블 저장
5. &nbsp;syncronization 테이블에 1번 서버의 테이블 변경이력을 저장<hr>
6. &nbsp;2번 서버에서는 3~5번 에서 변경된 테이블은 없고,  
   2번에서 저장한 테이블만 버퍼에 존재함<hr>
7. &nbsp;설전된 시간이 지나면 테이블 버퍼는 자동적으로 DB와 동기화를 시도함
8. &nbsp;이때 2번서버는 syncronization 테이블이 존재하는 것을 확인
9. &nbsp;기존 2번 서버 테이블 버퍼 전체 삭제<hr>
10. &nbsp;syncronization 테이블과 DB 동기화
11. &nbsp;2번 서버는 DB에서 테이블 버퍼에 테이블 불러옴.
<hr>

<p align= center ><b>실무에서는</b></p>

<p>
    테이블 변경이 자주 일어나는 테이블은 버퍼에 사용하지않고<br>
    항공사 코드표 같은 변경이 자주 일어나지 않고<br>
     주로 테이블 조회만 시행하는
     마스터 테이블에 테이블 버퍼를 사용하곤한다.
</p>

---
### 테이블 버퍼 적용 알고리즘 권장사항
<B>&nbsp;&nbsp;&nbsp;&nbsp;B3.P107</B>  

|알고리즘 Start||판단|
|:---:|:---:|:---:|
|1. Temp 테이블이 아닌가?<br>2. 데이터 불일치가 용인되는가?<br>3. Read Only 접근이 대부분인가?|NO<br>→|버퍼 사용 불가|
|YES ↓|||
|예상된 Table 사이즈가<br> 32KB이하인가?|YES<br>→|Full Buffering|
|NO ↓|||
|주로 SELECT SINGLE로 <br>접근하는가?|YES<br>→|Single Record <br>Buffering|
|NO ↓|||
|예상된 Table 사이즈가<br> 1MB보다 큰가?|YES<br>→|상황에 따라 판단|
|NO ↓|||
|PK혹은 그룹 컬럼으로|YES<br>→|Generic Buffering|
|대부분 접근하는가?|NO<br>→|Full Buffering|


---

<h2 align =center><b>quiz 08 - 09 실습</b></h2>

---

값이 들어오지 않더라도 결과값을 내보여주기위해서는 
range 데이터 타입을 사용 할 수 있음.


