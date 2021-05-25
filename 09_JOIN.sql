/*
    # �⺻Ű (Primary Key, PK)
    - �� ���̺��� �ϳ��� ���� �����ϰ� ������ �� �ִ� �÷�
    - �� ���̺� �� �ϳ� �ۿ� ������ �� ����
    - �⺻Ű�� �� �� �ִ� �÷������� �⺻Ű�� �������� ���� �÷��� '�ĺ�Ű (Candidate Key)' ��� �Ѵ�
    - �⺻Ű �÷����� �ߺ��� ���� ����� �ϸ�, null (�� ��)�� ������� �ʴ´�
    
    # �ܷ�Ű (Foreign Key, FK)
    - �ٸ� ���̺����� �⺻Ű �Ǵ� �ĺ�Ű������ �ش� ���̺����� �ߺ��Ǵ� ���� �÷� 
      ex: employees�� department_id�� departments�� �⺻Ű����, employees���� �����ͼ� Ȱ��ǰ� �ִ�
    - �ܷ�Ű�� ������ ���̺� ������ ���谡 �����ȴ�
    - �ܷ�Ű�� ������ �÷��� �ݵ�� �����ϴ� ���̺��� �⺻Ű�� �̹� �����ϴ� ���� �߰��� �� �ִ�
*/
SELECT * FROM employees ORDER BY first_name;
SELECT * FROM departments;
SELECT * FROM jobs;

SELECT
    employee_id,
    first_name,
    department_id
FROM
    employees;
    
    
SELECT * FROM departments;

/*
    * �ǻ�Ȱ���� 1:n ����� ������ �� �ִ� ��ʸ� �����غ�����
    
        ���� �Ҽ� ����, �������� ��� ����, �Ҵ���� �д��, ��ǰ�� ����ȸ��
*/

/*
    # ���̺� JOIN
    - �⺻Ű�� �ܷ�Ű�� ���谡 �����Ǿ� �ִ� ���̺���� ������ �����Ͽ� ��ȸ�ϴ� ��
    
    # CROSS JOIN
    - ���ο� ���Ǵ� ���̺���� �����͸� �����Ͽ� ���� �� �ִ� ��� ��츦 ����ϴ� JOIN
    - �׳� ��� ��츦 ����ϴ� ������� ����
*/
SELECT * FROM employees; -- 107 rows
SELECT * FROM departments; -- 27 rows
SELECT * FROM employees, departments; -- 107 * 27 rows

/*
    # EQUI JOIN
    - �� ���̺� ���� ���� ������ ���� ���� �÷�(�⺻Ű�� �ܷ�Ű)�� �̿��Ͽ� 
      CROSS JOIN�� ������� �ǹ��ִ� �����͸� �ɷ����� JOIN
*/
SELECT
    *
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id;


-- ����1 : first_name�� Valli�� ����� �����ȣ/Ǯ����/�μ����� ��ȸ�غ�����
SELECT * FROM employees;
SELECT
    employee_id,
    first_name,
    last_name,
    department_name
FROM
    employees,
    departments
WHERE
        employees.department_id = departments.department_id AND first_name = 'Valli'
ORDER BY
    employee_id;


-- ����2 : job_id�� IT_PROG�� ������� �̸�/�μ���ȣ/�μ����� ��ȸ�غ�����
SELECT
    job_id,
    first_name,
    department_name,
    -- ���� ���̺� ��ο� ���� �̸��� ���� �÷��� �ִ� ��� ��� ���� ������ ��Ȯ�ϰ� ����ؾ� �Ѵ�
    employees.department_id
FROM
    employees,
    departments
WHERE
        employees.department_id = departments.department_id
    AND job_id = 'IT_PROG';


-- ����3 : �þ�Ʋ���� �ٹ��ϴ� ��� ����� �̸��� ��å�� �޿��� ����غ����� (Hint. locations ���̺�)
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;
-- * ���̺� ���� ���� ����ؾ� �ϴ� ��� ��Ī�� ����� �� �ִ� *--
SELECT
    e.first_name,
    e.job_id,
    e.salary
FROM
    employees e,
    departments d,
    locations l
WHERE
        e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND city = 'Seattle';


/*
    # SELF JOIN
    - �ϳ��� ���̺� ������ �ڱ� �ڽŰ� JOIN�Ͽ� ���ϴ� �����͸� ���� ���� ���
*/
SELECT
    e1.employee_id,
    e1.first_name,
    e1.job_id,
    e1.manager_id,
    e2.first_name AS "MANAGER_NAME"
FROM
    employees e1, employees e2 -- SELF JOIN�� ���̺� ��Ī�� ����� �� �ۿ� ����
WHERE
    e1.manager_id = e2.employee_id
ORDER BY 
    e1.employee_id;


-- ����1 : �Ŵ��� �̸��� Nancy�� ������� ���/�̸�/job_title�� ��ȸ�غ�����
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT
    e1.employee_id,
    e1.first_name,
    e2.first_name,
    job_title
FROM
    employees  e1,
    employees  e2,
    jobs
WHERE
        e1.manager_id = e2.employee_id
    AND e1.job_id = jobs.job_id
    AND e2.first_name = 'Nancy';
    
    
-- ����2 : Curtis�� ������ ��å�� ���� ������� ��� ������ ��ȸ�غ�����
SELECT * FROM employees;

SELECT
    e1.*
FROM
    employees  e1,
    employees  e2
WHERE
        e2.first_name = 'Curtis'
    AND e2.job_id = e1.job_id;
    
SELECT
    e2.*
FROM
    employees  e1,
    employees  e2
WHERE
        e1.job_id = e2.job_id
    AND e1.first_name = 'Curtis';
    

/*
    # OUTER JOIN
    -  JOIN ������ �������� ���ؼ� �������� ���ߴ� ����� Ȯ���� �� ����ϴ� JOIN
    - (+)�� ���� ���� �÷��� null�� �߰��ؼ�, �������� ���ߴ� ����� Ȯ���� �� �ִ�
*/
SELECT
    employee_id,
    first_name,
    e.department_id,
    d.department_id,
    d.department_name
FROM
    employees    e,
    departments  d
WHERE
    e.department_id = d.department_id(+);
    
    
-- ������ ���� �������� ���� �� (+)�� ���ʿ� ���̴� ��� ��ȸ�Ǵ� �������� �ǹ̿�
-- (+)�� �����ʿ� ���̴� ��� ��ȸ�Ǵ� �������� �ǹ̸� ���� �����Ͻÿ� 
-- ���ʿ�(+)�� ���̴� ��� : e2�� employee_id�� ��Ī���� �ʴ� ��츦 ��� null�߰��ؼ� ��� (e1�� �Ŵ��� ���̵� ���� �����)
-- �����ʿ� (+)�� ���̴� ��� : e1�� manager_id�� ��Ī���� �ʴ� ��츦 null�߰�
SELECT
    e1.*,
    e2.first_name
FROM
    employees  e1,
    employees  e2
WHERE
    e1.manager_id(+) = e2.employee_id;
/* 
    ������(+) : e1.manager_id�� ������, e2�� ��ġ�ϴ� ���� ��� ��µ��� ���� ���� ���
                => manager_id�� �߸��� ���, null, �Ŵ����� �������� ���� ���
    ����(+) : e2.employee_id�� ������ e2�� ��ġ�ϴ� ���� ��� ��µ��� ���� ���� ���
                => ���������� ���������� ���� ��찡 ��µ�
*/

SELECT * FROM employees WHERE department_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NULL;


-- ����1 : �����/�μ���ȣ/�μ��̸��� ����ϵ� ����� �Ѹ� ������ ���� �μ��� ��ȸ�غ�����
SELECT
    first_name,
    d.department_id,
    department_name
FROM
    employees e,
    departments d
WHERE
    e.department_id(+) = d.department_id;


-- ����2 : �����/��åID/��å���� ����ϵ� ����� �Ѹ� ������ ���� ��å�� �Բ� ��ȸ�غ�����
SELECT
    first_name,
    j.job_id,
    job_title
FROM
    employees e,
    jobs j
WHERE
    e.job_id(+) = j.job_id;


-- ����3 : �μ���/�ּ�/���ø��� ����ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ�����
SELECT
    department_name,
    street_address,
    city
FROM
    departments d,
    locations l
WHERE
    d.location_id(+) = l.location_id
ORDER BY
    department_name DESC;