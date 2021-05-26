/*
    # ANSI JOIN
    - ANSI (American National Standards Institute) : �������� ǥ���� �����ϴ� �ΰ� ��ü
    - �̱� ���� ǥ�� ��ȸ���� ���� ǥ���� ������ JOIN ����
    - �ٸ� RDBMS���� �� ������ �����Ѵ�
*/

-- ANSI CROSS JOIN
SELECT
    *
FROM
         employees
    CROSS JOIN departments;
    
    
-- ANSI INNER JOIN - ���ǿ� �´� �ุ �����ϴ� JOIN
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;
    
    
-- ANSI OUTER JOIN - ���ǿ� ���� �ʴ� �൵ �����ϴ� JOIN. LEFT/RIGHT/FULL�� �����ؾ� �Ѵ�.
SELECT
    e1.employee_id,
    e1.first_name,
    e2.employee_id AS manager_id,
    e2.first_name
FROM
    employees  e1
    FULL OUTER JOIN employees  e2 ON e1.manager_id = e2.employee_id
ORDER BY
    e1.employee_id;
-- LEFT OUTER JOIN : ������ ������ �ƿ��� ����, �� �����ʿ� (+)�� ���� �Ͱ� ����
-- RIGHT OUTER JOIN : �������� ������ �ƿ��� ����, �� ���ʿ� (+)�� ���� �Ͱ� ����
-- FULL OUTER JOIN : ������ ������ �ƿ��� ����, �� ���ʿ� (+)�� ���� �Ͱ� ����
   
    
-- JOIN�� �̿�Ǵ� �÷����� ���� ��� USING�� �̿��� �������� ����ȭ �� �� �ִ� 
SELECT
    first_name,
    department_id,
    department_name,
    job_id,
    job_title,
    location_id,
    city
FROM
         employees e
    INNER JOIN departments USING ( department_id )
    INNER JOIN jobs USING ( job_id )
    RIGHT OUTER JOIN locations USING ( location_id );
    
-- ANSI JOIN�� ����ϸ� ���� ���ǰ� WHERE �������� �����Ͽ� ����� �� �ְ� 
-- USING�� ���� �÷��� ��� ���̺��� �÷����� ����� �ʿ䰡 ��������


-- ANSI JOIN�� �̿��� ���� �������� Ǯ�����
-- ����1 : first_name�� Valli�� ����� �����ȣ/Ǯ����/�μ����� ��ȸ�غ�����
SELECT
    employee_id,
    first_name,
    last_name,
    department_name
FROM
         employees
    INNER JOIN departments USING ( department_id )
WHERE
    first_name = 'Valli';

-- ����2 : job_id�� IT_PROG�� ������� �̸�/�μ���ȣ/�μ����� ��ȸ�غ�����
SELECT
    first_name,
    department_id,
    department_name
FROM
         employees
    INNER JOIN departments USING ( department_id )
    INNER JOIN jobs USING ( job_id )
WHERE
    job_id = 'IT_PROG';

-- ����3 : �þ�Ʋ���� �ٹ��ϴ� ��� ����� �̸��� ��å�� �޿��� ����غ�����
SELECT
    first_name,
    job_id,
    salary
FROM
         employees
    INNER JOIN departments USING ( department_id )
    INNER JOIN locations USING ( location_id )
WHERE
    city = 'Seattle';
    
-- ����4 : �����/�μ���ȣ/�μ��̸��� ����ϵ� ����� �Ѹ� ������ ���� �μ��� ��ȸ�غ�����
SELECT
    first_name,
    department_id,
    department_name
FROM
    employees
    RIGHT OUTER JOIN departments USING ( department_id )
ORDER BY
    department_id;

-- ����5 : �μ���/�ּ�/���ø��� ����ϵ� �Ҽӵ� �μ��� ���� ���õ� �Բ� ��ȸ�غ�����
SELECT
    department_name,
    street_address,
    city
FROM
    departments
    RIGHT OUTER JOIN locations USING ( location_id )
ORDER BY 
    department_name;