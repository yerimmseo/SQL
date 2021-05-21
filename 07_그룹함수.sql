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
    
-- GROUP BY�� ���� �÷��� ������ ���� �ִ�
SELECT
    job_id, department_id,
    TO_CHAR(AVG(salary * 12 *(1 + NVL(commission_pct, 0))), '999999999.99') AS "JOB�� ��� ����"
FROM
    employees
GROUP BY
    job_id, department_id
ORDER BY
    job_id;

SELECT
    job_id,
    ROUND(AVG(salary * NVL((1 + commission_pct), 1)) * 12, 2) AS "��� ����"
FROM
    employees
GROUP BY
    job_id;


-- GROUP BY�� ������ �׷쿡 ������ �ְ� ���� ���� HAVING���� �̿��Ѵ�
SELECT job_id, count(*) FROM employees GROUP BY job_id;

-- �� WHERE�� �׷��� �����Ǳ� ���� ��� �࿡ ����Ǵ� �����̴�
SELECT job_id, count(*) FROM employees WHERE salary <= 5000 GROUP BY job_id;

-- ȸ�翡 5�� ���Ϲۿ� ���� ��å�� ��� ���
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 5;

-- ȸ�翡 3�� ���Ϲۿ� ���� ��å�� ��� ���
SELECT job_id, count(*) FROM employees GROUP BY job_id HAVING count(*) <= 3;


-- ����1 : �μ��� �ִ� �޿��� �ּ� �޿��� ����ϵ� �ִ� �޿��� 5000�̻��� �μ��� ����غ�����
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

-- ����2 : �μ��� ��� �޿��� ����ϵ� �ش� �μ��� �Ҽӵ� ����� 10�� �̻��� �μ��� ����غ�����
SELECT
    department_id,
    round(AVG(salary), 2)
FROM
    employees
GROUP BY
    department_id
HAVING
    COUNT(*) >= 10;
    