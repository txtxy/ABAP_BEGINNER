# USING NATIVE SQL
    방법은 총 2개임
1. 직접 SQL 실행문.
    **특별한 경우가 아니면 거의 사용하지 않음**
```ABAP
    Exec sql.
    connection ...
    ...
    end sql.
```
2. ADBC 방법

# DB Update with OPEN SQL
- 대표적인 활용 SYS 변수
    sy-subrc : DB 정상 조회 시 RETURN 0.
    sy-dncnt : 조회한 ROW 수
- CLIENT SPECIFIED 구문  - OLD OPEN SQL
    - DB INTERFACE 에서 자체적으로 클라이언트 특정 데이터를 읽어오는데;  
    - NO CLIENT SPECIFIED 구문이 묵시적 적용되어 본인의 클라이언트 DATA 만가져옴
    - CLIENT SPECIFIED  

        - MANDT 조건을 입력하지 않는다면 전체 MANDT의 데이터를 읽어오고
            - 예시
                ```abap
                    SELECT *
                    from <DB>
                    into <iTAB>
                    cliend specified 
                ```

        - 특정 넘버를 입력하면 해당 클라이언트의 DATA를 가져옴.
            - 예시
                ```abap
                    SELECT *
                    from <DB>
                    into <iTAB>
                    cliend specified 
                    where mandt = '400'
                ```
- NEW OPEN SQL의 경우 USING CLIENT 구문을 사용한다.
    - 거의 쓸일 없음?

## DB INSERT
- 예시 구문 ( 두개 다 동일함.)
`INSERT INTO <dbtab> VALUES <WA>.`
`INSERT      <dbtab> FROM   <WA>.`

## DB UPDATE
- 예시 구문
`UPDATE <DB TABLE> FROM <WA>`
`UPDATE <DB TABLE> SET <F1> = <G1> ... <FN> = <GN> WHERE PK = <PK in itab> `
- 실례
```abap
    *UPDATE ztscarr_e01 from gs_carrier.

    update ztscarr_e01 set currcode = gs_carrier-currcode
           where carrid = gs_carrier-carrid.
```
- 여러건의 데이터를 입력
`UPDATE <DB TABLE> FROM TABLE <ITAB>`
`UPDATE <DB TABLE> SET <F1> = <G1> ... <FN> = <GN> WHERE PK = <PK in itab> `

## MODIFY KEYWORD of OPEN SQL
- INSDERT 와 UPDATE 기능을 동시에 가지고 있음.
    - 테이블에 데이터가 존재하면 UPDATE를 하고
    - 테이블에 데이터가 존재하지 않다면 INSERT 기능을 실행
`MODIFY <DB TABLE> FROM <WA>.`
`MODIFY <DB TABLE> TABLE <ITAB>.`

## DB DELETE
- 1건의 DB RECORD를 삭제하는 기능
`DELETE <DB TABLE> FROM <WA>.`
`DELETE <DB TABLE> WHERE PK = <PK in itab> .`

- 다중 DB RECORD를 삭제하는 기능
`DELETE <DB TABLE> FROM TABLE <ITAB>.`
`DELETE FROM <DB TABLE> WHERE <condition> .`
- where 조건없이 삭제한다면 전체 RECORD 삭제.

## 
DB 생성간 오류가 발생했을 때
MESSAGE TYPE 'A' 혹은 'X'의 경우 ROLLBACK WORK 가 발생함

트랜잭션간 DB 변경사항이 휘발됨.

