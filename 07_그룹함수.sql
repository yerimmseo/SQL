/*
    # �׷� �Լ�
    - ���� ���� ���� Ư�� �÷��� �������� �׷�ȭ �ϴ� �Լ���
    - Ư�� ������ ����, ����, ��� ���� ���� �� �ִ�
    - �׷��� ������ �Ǵ� �÷��� GROUP BY���� ���� �����Ѵ�
    - �׷� �Լ��� ����� �Ϲ� �÷��� �Բ� ��µ� �� ����
*/
SELECT SUM(salary) FROM employees;

-- ��å�� �� ����
SELECT job_id, SUM(salary) FROM employees GROUP BY job_id;

-- ��å�� ��� ����
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id;


-- SUM(column) : �׷� ���� �ش� �÷��� �� ���� ���Ѵ�
SELECT department_id, sum(salary) FROM employees GROUP BY department_id;

-- AVG(column) : ���
-- MAX(column) : �ִ밪
SELECT department_id, max(salary) FROM employees GROUP BY department_id;

-- MIN(column) : �ּҰ�
-- COUNT(column) : ����
SELECT department_id, count(*) FROM employees GROUP BY department_id;


-- ����1 : �μ����� ���� �ֱٿ� ����� �Ի��� ��¥�� ���� �������� �Ի��� ��¥�� ������ִ� �������� �ۼ�
SELECT
    department_id,
    MAX(hire_date) AS "���� �ֱ�",
    MIN (hire_date) AS "���� ������ �ΰ�"
FROM
    employees
GROUP BY
    department_id;
SELECT min(hire_date), max(hire_date) FROM employees GROUP BY department_id;

-- ����2 : ���ʽ��� �޴� ����� �� �μ��� ��� �ִ��� ����� �������� �ۼ�
SELECT
    department_id,
    COUNT(commission_pct)
FROM
    employees
GROUP BY
    department_id;

-- ����3 : �� ���޺� ��� ������ ���غ����� (�� ���� �ƴ�, Ŀ�̼� ����, �Ҽ��� ��° �ڸ����� ���)
SELECT
    job_id,
    SUM(salary * 12 *(1 + NVL(commission_pct, 0))) / COUNT(*) AS "JOB�� ��� ����"
FROM
    employees
GROUP BY
    job_id;
    
SELECT
    job_id,
    TO_CHAR(AVG(salary * 12 *(1 + NVL(commission_pct, 0))), '999999999.99') AS "JOB�� ��� ����"
FROM
    employees
GROUP BY
    job_id;

SELECT
    job_id,
    ROUND(AVG(salary * NVL((1 + commission_pct), 1)) * 12, 2) AS "��� ����"
FROM
    employees
GROUP BY
    job_id;



