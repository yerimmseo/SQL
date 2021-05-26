SELECT * FROM employees;

SELECT * FROM jobs;

-- employees�� �������� �ڽ��� ���� �� �ִ� ���� ���������� �� �ۼ�Ʈ ������ ������ �ް� �ִ��� ��ȸ�غ�����
-- (Ŀ�̼ǵ� ����)

SELECT * FROM employees INNER JOIN jobs USING ( job_id );

SELECT
    first_name,
    job_id,
    salary * (1 + NVL(commission_pct, 0)) AS comission_apply,
    min_salary,
    max_salary,
    TO_CHAR(ROUND((salary *(1 + NVL(commission_pct, 0)) - min_salary) / (max_salary - min_salary) * 100, 2), '990.99') AS "%"
FROM
         employees
    INNER JOIN jobs USING ( job_id );