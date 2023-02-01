# 다중 DB TABLE 조회

1. DB View 사용
    ABAP Dicc에 DB view를 생성해서 활용
2. INNER JOIN or LEFT OUTER JOIN
    SQL의 기본 Join 활용
    - OLD OPEN SQL의 outer JOIN의 경우 where절에 우측 DB의 컬럼을 조건으로 사용할 수 없다.

3. FOR ALL ENTRIES
    - **B.BC405 P.308.**
    - 기본 SELECT를 통해 인터널테이블에 정보 획득한 이후.
    ```abap
        SORT gt_spfli.                               " 정렬을 먼저해야지 중복 데이터가 삭제됨!
        DELETE ADJACENT DUPLICATES FROM gt_spfli.    " 중복된 데이터 삭제!

        SELECT *
        INTO TABLE gt_flights 
        FROM sflight
        FOR ALL ENTRIES IN gt_spfli
        WHERE carrid = gt_spfli-carrid and
              connid = gt_spfli-connid.
    ```
    - 위의 구문은 아래와 같다
    ```abap
        select *
        into corresponding table gt_flights
        from spfli
        wehre ( carrid = 'LH' and connid = '0400' ) or
              ( carrid = 'LH' and connid = '0402' ) or
              ( carrid = 'AA' and connid = '0017' )
    ```
    - 주의사항 !  
        for all entries in \<인터널 테이블\>  
        - 인터널 테이블에 조건이 없으면 모든 데이터를 가져온다!!!
            - 그래서 `if \<인터널 테이블 \> is not initial.`을 조건으로 주고 시작해라.
        - 인터널 테이블에 중복 데이터가 존재하면 안된다!  
        - 인터널 테이블이 SORT 되어있지 않다면, 중복 데이터 삭제가 안된다!
        - [collect Keyword](../../%EC%B0%B8%EA%B3%A0%EC%9E%90%EB%A3%8C/COLLECT_KEYWORD.md)

4. NESTED SELECT STATEMENT
    select endselect를 중첩해서 사용 하는 것.

5. Subqueries
