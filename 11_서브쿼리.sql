/*
    # ���� ����
    - �ϳ��� SELECT�� ���ο� ���Ե� �� �ϳ��� SELECT��
    - ���� ������ �����ϰ� �ִ� ������ ���� ������� �Ѵ�
    - ���� ������ ���� ������ ����Ǳ� ���� �� ���� ����ȴ�
    
    # ���� �� ���� ����
    - ���� ������ ���� ����� �� �ϳ��� �ุ ��ȯ�ϴ� ���� ����
    - =, >, <=, <, <= ���� �� �����ڵ��� ���� ������ ���ϴ� �������̹Ƿ�
      ������ ���������� �Բ� ����ؾ� �Ѵ�
*/

-- Sigal�� ���� �μ��� �ٹ��ϴ� ��� ����� ��ȸ�غ���
SELECT
    *
FROM
    employees
WHERE
    department_id = (SELECT department_id FROM employees WHERE first_name = 'Sigal');
    
-- ���� ������ ���� ���
SELECT department_id FROM employees WHERE first_name = 'Sigal';


-- ���� ������ �̿��� ���� ������ �ذ��غ�����
-- ����1 : EMAIL�� DRAPHEAL�� ������� �޿��� �� ���� �޴� ������� �̸�/��å/�޿��� ��ȸ�غ�����
SELECT 
    first_name,
    job_id, 
    salary 
FROM 
    employees 
WHERE 
    salary > (SELECT salary FROM employees WHERE email = 'DRAPHEAL');

-- ����2 : Purchasing �μ����� �ٹ��ϴ� ������� �̸��� ��å�� �μ���ȣ�� ��ȸ�غ�����
SELECT 
    first_name,
    job_id,
    department_id
FROM 
    employees
WHERE 
    department_id = (SELECT department_id FROM departments WHERE department_name = 'Purchasing');


/*
    # ���� �� ���� ����
    - ���� ������ ���� ����� ��ȯ�Ǵ� ���� 2�� �̻��� ���� ����
    - ���� �� �����ڿ� �Բ� ����ؾ� �Ѵ�
    - IN : ���� ���� ���� �� ���ԵǾ� ������ ��
    - ANY, SOME : ���� ���� ���� �� �ϳ� �̻� ������Ű�� ��
    - ALL : ���� ���� ���� �� ��� �������Ѿ� ��
    - EXISTS : ���� ������ ���� ����� �����ϸ� ��
*/

SELECT * FROM employees ORDER BY salary DESC;

SELECT DISTINCT department_id FROM employees WHERE salary >= 13000;

-- �޿��� 13000$ �̻��� ����� �Ҽӵ� �μ����� �ٹ��ϴ� ��� ����� ��ȸ
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
    
    
-- ALL ������
SELECT
    first_name,
    job_title,
    salary
FROM 
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > ALL (SELECT salary FROM employees WHERE job_id = 'IT_PROG');


-- ANY ������
SELECT
    first_name,
    job_title,
    salary
FROM 
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary = ANY (SELECT salary FROM employees WHERE job_id = 'IT_PROG');
    
    
-- SOME ������    
SELECT
    first_name,
    job_title,
    salary
FROM 
    employees INNER JOIN jobs USING (job_id)
WHERE
    salary > SOME (SELECT salary FROM employees WHERE job_id = 'IT_PROG');    
    

SELECT * FROM job_history;


-- EXISTS : ���� ���� ���� ����� 1���̶� �����ϸ� ��
SELECT
    * 
FROM 
    employees e1
WHERE 
    NOT EXISTS (SELECT 1 FROM employees e2 WHERE e1.salary < e2.salary);
    
SELECT 1 FROM employees WHERE salary < 0;