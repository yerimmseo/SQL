/*
    # SELECT �÷��� FROM ���̺��;
    - �����͸� ��ȸ�ϴ� ������
    - �÷��� *�� ���� ���� ��� �÷��� ���Ѵ�
    - �÷���/���̺���� ��ҹ��ڸ� �������� �ʴ´�
    - �������� ��ҹ��ڸ� �������� �ʴ´�
    - �����ʹ� ��ҹ��ڸ� �����Ѵ� (�� �߿�)
*/

-- tab, tabs�� � ���̺���� �ִ��� Ȯ���� �� �ִ�
SELECT * FROM tab;
SELECT * FROM tabs;
SELECT table_name FROM tabs;

-- *�� ������ ��� �÷��� ��ȸ�ϰ�, �÷����� ������ �ش� �÷��� ��ȸ�Ѵ�
SELECT * FROM employees;
SELECT first_name FROM employees;
SELECT first_name, salary FROM employees;

/*
    # ������ ���̺� ����
       EMPLOYEES : ��� ������ ������ ���̺� 
       DEPARTMENTS : �μ� ������ ������ ���̺�
       JOBS : ���� ������ ������ ���̺�
       LOCATIONS : ���� ������ ������ ���̺�
       COUNTRIES : ���� ������ ������ ���̺�
       REGIONS : ��� ������ ������ ���̺�
*/
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM jobs;
SELECT * FROM countries;
SELECT * FROM regions;

-- ���̺� ���� ����
DESC employees;
DESC departments;
DESC jobs;
DESC countries;
DESC regions;

/*
    # NUMBER(n), NUMBER(n, m)
    - ���� �����͸� ������ �� �ִ� �÷�
    - ���ڰ� �ϳ��� ���������� ������ ����, ���ڰ� �ΰ� ���������� �Ǽ��� ����
    - NUMBER(10) : 10�ڸ� ������ �����ϴ� �÷��� �ȴ�
    - NUMBER(10, 4) : 6�ڸ� ������ �Ҽ��� 4�ڸ��� �����ϴ� �÷��� �ȴ�
    
    # VARCHAR2(n)
    - ���� ���� ���� �����͸� �����ϴ� �÷� Ÿ��
    - ����Ǵ� �������� ũ�⿡ ���� �˸��� ������ ����Ѵ�
    - VARCHAR2(10)���� ������ �÷��� �����ͷ� 2���ڰ� ������ 2����Ʈ�� ����Ѵ�
    - �������� �����͸� ������ ���� �����Ͱ� ��������� ũ�� ����� �ʿ��ϴ�
    
    # CHAR(n)
    - ���� ���� ���� �����͸� �����ϴ� �÷� Ÿ��
    - ������ ���̺��� ���� ���� �����Ͱ� �������� ������ ���̸� ��� �����Ѵ�
    - CHAR(10)���� ������ �÷��� �����ͷ� 2���ڰ� ������ 10����Ʈ�� ��� ����Ѵ�
    - �����Ͱ� ����� ���� ������ ���ʿ��� ũ�� ����� ���� ������ �ӵ��� �� ������
    
    # DATE
    - ��¥ �� �ð��� �����ϴ� �÷� Ÿ��
*/
SELECT * FROM countries;

-- ����1 : ��� ����� �����ȣ/�̸�/����/�μ���ȣ�� ��ȸ�غ�����
DESC employees;
SELECT employee_id, first_name, salary, department_id FROM employees;

-- AS�� �̿��� ���ϴ� �÷������� ��ȸ�� �� �ִ�
SELECT 
    employee_id AS �����ȣ,
    first_name AS �̸�,
    salary AS ����, 
    department_id AS �μ���ȣ
FROM 
    employees;

-- ��� �����ڸ� �̿��� ���� �� ����ϱ�
SELECT last_name, salary FROM employees;
SELECT last_name, salary + 500 FROM employees;
SELECT last_name, salary * 2 FROM employees;
SELECT last_name, salary * 0.9 AS �谨�ȿ��� FROM employees;

SELECT * FROM employees;

SELECT last_name, salary, commission_pct FROM employees;
SELECT last_name, salary * (1 + commission_pct) FROM employees;

-- NVL(�÷���, ��ü��) : �ش� �÷����� NULL���� ������ �� ��ü���� ����Ѵ�
SELECT last_name, salary * (1 + NVL(commission_pct, 0)) AS ���ʽ������� FROM employees;


-- ����2 : ��� ������� ���/�����̸�/������ ����غ����� (salay�� �����Դϴ�, ��Ī ����� ��)
SELECT 
    employee_id AS ���, 
    last_name AS �����̸�,
    job_id,
    salary * 12 * (1 + NVL(commission_pct, 0)) AS ���� 
FROM 
    employees;
    
-- SELECT DISTINCT : �ߺ��Ǵ� ������ ������ �־ �� ���� ��µȴ�

-- employees�� �����ϴ� ��� ��å�� ���� ���� ���
SELECT DISTINCT job_id FROM employees;
SELECT DISTINCT department_id FROM employees;
SELECT DISTINCT manager_id FROM employees;

