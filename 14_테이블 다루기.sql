/*
    # 서브쿼리로 테이블 복사하기
       CREATE TABLE 테이블명 AS (서브 쿼리)로 테이블을 생성할 수 있다
*/
CREATE TABLE coffees2 AS (SELECT * FROM coffees);

DESC coffees2;

CREATE TABLE bingsu AS (SELECT * FROM coffees WHERE cname LIKE '%빙수');

SELECT * FROM bingsu;

/*
    # 새 컬럼 추가하기
       ALTER TABLE 테이블명 ADD (컬럼명 컬럼타입, ...)
*/
ALTER TABLE bingsu ADD (sirup VARCHAR2(20));

/*
    # 테이블의 컬럼 이름 변경하기
       ALTER TABLE 테이블명 RENAME COLUMN 현재이름 TO 바꿀이름;
*/
ALTER TABLE bingsu RENAME COLUMN sirup TO syrup;

/*
    # 테이블 이름 변경하기
       RENAME 현재테이블명 TO 바꿀테이블명;
*/
RENAME bingsu TO bingsoo;

SELECT * FROM bingsoo;
SELECT * FROM bingsu;

SELECT * FROM tabs;

/*
    # 컬럼 타입 변경하기
       ALTER TABLE 테이블명 MODIFY (컬럼명 컬럼타입, ...);
*/
SELECT * FROM bingsoo;

ALTER TABLE bingsoo MODIFY (cname VARCHAR2(30));

UPDATE bingsoo SET cname = '빙수';
INSERT INTO bingsoo VALUES (101, '민트초코카페라떼파인애플마라빙수', 7500, '딸기');

/*
    # 컬럼 삭제하기
       ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
*/
SELECT * FROM bingsoo;
ALTER TABLE bingsoo DROP COLUMN syrup;



---------------------------------------------------------------------------------------
SELECT * FROM employees;

SELECT * FROM jobs;

-- employees의 직원들이 자신이 받을 수 있는 월급 범위내에서 몇 퍼센트 수준의 월급을 받고 있는지 조회해보세요
-- (커미션도 포함)

SELECT * FROM employees INNER JOIN jobs USING ( job_id );

SELECT
    first_name,
    job_id,
    salary * (1 + NVL(commission_pct, 0)) AS comission_apply,
    min_salary,
    max_salary,
    TO_CHAR(ROUND((salary * (1 + NVL(commission_pct, 0)) - min_salary) / (max_salary - min_salary) * 100, 2), '990.99') AS "%"
FROM
         employees
    INNER JOIN jobs USING ( job_id );
    

-- salary - min_salary : 가장 적게 받는 사람(0%)보다 내가 더 받는 금액
-- max_salary - min_salary : 더 받을 수 있는 최대 금액
SELECT
    employee_id,
    first_name,
    salary,
    commission_pct,
    TO_CHAR(
        (salary * (1 + NVL(commission_pct, 0)) - min_salary) / (max_salary - min_salary) * 100 
        , '990.99') || '%' AS "Salary Percentage"
FROM
         employees
    INNER JOIN jobs USING ( job_id )
ORDER BY
    "Salary Percentage" DESC;