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
