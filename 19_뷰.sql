/*
    # 뷰 (View)
    - 물리적인 기본 테이블들을 이용해 생성한 논리적인 가상의 테이블
    - 기본 테이블에서 파생된 DB 객체
    - 뷰를 통해 사용자(개발자)가 기본 테이블을 제한적으로 사용하게끔 할 수 있다
    
    CREATE [OR REPLACE] VIEW 뷰이름 
        AS 서브쿼리 
                [WITH CHECK OPTION | WITH READ ONLY];
                
    - CREATE OR REPLACE : 이미 존재하는 뷰라면 수정을 한다. 없다면 생성한다.
    - WITH CHECK OPTION : 해당 뷰의 조건을 만족하는 DML이 가능해진다. (제한적인 DML)
    - WITH READ ONLY : 해당 뷰는 SELECT만 가능해진다. (DML 금지)
*/

-- 뷰 데이터 딕셔너리
SELECT * FROM user_views;
SELECT * FROM all_views;

-- 기본 옵션 뷰
CREATE OR REPLACE VIEW dept30_view AS
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 30;
        
SELECT * FROM dept30_view;

-- 기본 옵션 뷰를 통해서 자유로운 INSERT가 가능하다. (개발자가 INSERT를 진행할 수 있다)
INSERT INTO dept30_view 
    VALUES(1, 'Gildong', 'Hong', 'GHong', '515.127.4444', sysdate, 'IT_PROG', 1000, null, 100, 70);


-- 읽기 전용 뷰
CREATE OR REPLACE VIEW dept50_view_readonly AS
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 50
WITH READ ONLY;

SELECT * FROM dept50_view_readonly;

-- 읽기 전용 뷰를 통해서는 DML 작업을 수행할 수 없습니다.
INSERT INTO dept50_view_readonly
    VALUES(3, 'Jeedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 70);


-- 체크 옵션 뷰
CREATE OR REPLACE VIEW dept80_view_check AS
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 80
WITH CHECK OPTION;

-- 80번 부서 사람들만 조회하는 뷰이기 때문에, 80번 부서와 관련된 DML만 사용할 수 있게 된다
SELECT * FROM dept80_view_check;
INSERT INTO dept80_view_check
    VALUES(3, 'Jaedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 70);
    
-- 80번 부서에만 DML이 가능하다    
INSERT INTO dept80_view_check
    VALUES(3, 'Jaedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 80);

SELECT * FROM dept80_view_check;
SELECT * FROM employees;