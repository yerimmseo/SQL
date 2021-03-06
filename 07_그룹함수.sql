/*
    # 그룹 함수
    - 여러 행의 값을 특정 컬럼을 기준으로 그룹화 하는 함수들
    - 특정 집단의 총합, 개수, 평균 등을 구할 수 있다
    - 그룹의 기준이 되는 컬럼은 GROUP BY절을 통해 선택한다
    - 그룹 함수의 결과는 일반 컬럼과 함께 출력될 수 없다
*/
SELECT SUM(salary) FROM employees;

-- 직책별 총 월급
SELECT job_id, SUM(salary) FROM employees GROUP BY job_id;

-- 직책별 평균 월급
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id;


-- SUM(column) : 그룹 별로 해당 컬럼의 총 합을 구한다
SELECT department_id, sum(salary) FROM employees GROUP BY department_id;

-- AVG(column) : 평균
-- MAX(column) : 최대값
SELECT department_id, max(salary) FROM employees GROUP BY department_id;

-- MIN(column) : 최소값
-- COUNT(column) : 개수
SELECT department_id, count(*) FROM employees GROUP BY department_id;


-- 연습1 : 부서별로 가장 최근에 사원이 입사한 날짜와 가장 오래전에 입사한 날짜를 출력해주는 쿼리문을 작성
SELECT
    department_id,
    MAX(hire_date) AS "가장 최근",
    MIN (hire_date) AS "가장 오래된"
FROM
    employees
GROUP BY
    department_id;
SELECT min(hire_date), max(hire_date) FROM employees GROUP BY department_id;

-- 연습2 : 보너스를 받는 사원이 각 부서에 몇명 있는지 세어보는 쿼리문을 작성
SELECT
    department_id,
    COUNT(commission_pct)
FROM
    employees
GROUP BY
    department_id;

-- 연습3 : 각 직급별 평균 연봉을 구해보세요 (※ 월급 아님, 커미션 적용, 소수점 둘째 자리까지 출력)
SELECT
    job_id,
    SUM(salary * 12 *(1 + NVL(commission_pct, 0))) / COUNT(*) AS "JOB별 평균 연봉"
FROM
    employees
GROUP BY
    job_id;
    
-- GROUP BY에 여러 컬럼을 설정할 수도 있다
SELECT
    job_id, department_id,
    TO_CHAR(AVG(salary * 12 *(1 + NVL(commission_pct, 0))), '999999999.99') AS "JOB별 평균 연봉"
FROM
    employees
GROUP BY
    job_id, department_id
ORDER BY
    job_id;

SELECT
    job_id,
    ROUND(AVG(salary * NVL((1 + commission_pct), 1)) * 12, 2) AS "평균 연봉"
FROM
    employees
GROUP BY
    job_id;


-- GROUP BY로 나눠진 그룹에 조건을 주고 싶을 때는 HAVING절을 이용한다
SELECT job_id, count(*) FROM employees GROUP BY job_id;

-- ※ WHERE는 그룹이 생성되기 전에 모든 행에 적용되는 조건이다
SELECT job_id, count(*) FROM employees WHERE salary <= 5000 GROUP BY job_id;

-- 회사에 5명 이하밖에 없는 직책을 모두 출력
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 5;

-- 회사에 3명 이하밖에 없는 직책을 모두 출력
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 3;


-- 연습1 : 부서별 최대 급여와 최소 급여를 출력하되 최대 급여가 5000이상인 부서만 출력해보세요
SELECT
    department_id,
    MAX(salary),
    MIN(salary)
FROM
    employees
GROUP BY
    department_id
HAVING
    MAX(salary) >= 5000
ORDER BY
    department_id;

-- 연습2 : 부서별 평균 급여를 출력하되 해당 부서에 소속된 사원이 10명 이상인 부서만 출력해보세요
SELECT
    department_id,
    round(AVG(salary), 2)
FROM
    employees
GROUP BY
    department_id
HAVING
    COUNT(*) >= 10;