/*
    # 서브 쿼리
    - 하나의 SELECT문 내부에 포함된 또 하나의 SELECT문
    - 서브 쿼리를 포함하고 있는 쿼리를 메인 쿼리라고 한다
    - 서브 쿼리는 메인 쿼리가 실행되기 전에 한 번만 실행된다
    
    # 단일 행 서브 쿼리
    - 서브 쿼리의 수행 결과가 단 하나의 행만 반환하는 서브 쿼리
    - =, >, <=, <, <= 등의 비교 연산자들은 단일 값끼리 비교하는 연산자이므로
      단일행 서브쿼리와 함께 사용해야 한다
*/

-- Sigal과 같은 부서에 근무하는 모든 사원을 조회해보기
SELECT
    *
FROM
    employees
WHERE
    department_id = (SELECT department_id FROM employees WHERE first_name = 'Sigal');
    
-- 서브 쿼리의 실행 결과
SELECT department_id FROM employees WHERE first_name = 'Sigal';


-- 서브 쿼리를 이용해 다음 문제를 해결해보세요
-- 연습1 : EMAIL이 DRAPHEAL인 사원보다 급여를 더 많이 받는 사원들의 이름/직책/급여를 조회해보세요
SELECT 
    first_name,
    job_id, 
    salary 
FROM 
    employees 
WHERE 
    salary > (SELECT salary FROM employees WHERE email = 'DRAPHEAL');

-- 연습2 : Purchasing 부서에서 근무하는 사원들의 이름과 직책과 부서번호를 조회해보세요
SELECT 
    first_name,
    job_id,
    department_id
FROM 
    employees
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'Purchasing');


/*
    # 다중 행 서브 쿼리
    - 서브 쿼리의 실행 결과로 반환되는 행이 2줄 이상인 서브 쿼리
    - 다중 행 연산자와 함께 사용해야 한다
    - IN : 여러 개의 값들 중 포함되어 있으면 참
    - ANY, SOME : 여러 개의 값들 중 하나 이상 만족시키면 참
    - ALL : 여러 개의 값들 중 모두 만족시켜야 참
    - EXISTS : 서브 쿼리의 실행 결과가 존재하면 참
*/

SELECT * FROM employees ORDER BY salary DESC;

SELECT DISTINCT department_id FROM employees WHERE salary >= 13000;

-- 급여가 13000$ 이상인 사원이 소속된 부서에서 근무하는 모든 사원을 조회
SELECT
    employee_id,
    first_name,
    department_id
FROM
    employees
WHERE
    department_id IN (SELECT DISTINCT department_id FROM employees WHERE salary >= 13000)
ORDER BY
    department_id;
    
    
-- ALL 연산자
SELECT
    first_name,
    job_title,
    salary
FROM 
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > ALL (SELECT salary FROM employees WHERE job_id = 'IT_PROG');


-- ANY 연산자
SELECT
    first_name,
    job_title,
    salary
FROM 
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary = ANY (SELECT salary FROM employees WHERE job_id = 'IT_PROG');
    
    
-- SOME 연산자    
SELECT
    first_name,
    job_title,
    salary
FROM 
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > SOME (SELECT salary FROM employees WHERE job_id = 'IT_PROG');    
    

SELECT * FROM job_history;


-- EXISTS : 서브 쿼리 실행 결과가 1행이라도 존재하면 참
SELECT
    * 
FROM 
    employees e1
WHERE 
    NOT EXISTS (SELECT 1 FROM employees e2 WHERE e1.salary < e2.salary);
    
SELECT 1 FROM employees WHERE salary < 0;