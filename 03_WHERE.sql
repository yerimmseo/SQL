/*
    # SELECT �÷��� FROM ���̺�� WHERE ������;
    - SELECT���� WHERE���� �߰��Ͽ� �ش� ������ �����ϴ� �����͸� ��ȸ�� �� �ִ�
    - 
*/

-- ������ 15000�޷� �̻��� ����鸸 ��ȸ�ϱ�
SELECT * FROM employees WHERE salary >= 15000;

/*
    # ����Ŭ�� �� �����ڵ�
    = : ����
    <, >, <=, >= : ��
    !=, <>, ^= : �ٸ���
*/
SELECT * FROM employees WHERE salary = 17000;
SELECT * FROM employees WHERE salary != 17000;

-- ����Ŭ�� ���ڿ� ���ͷ��� ' '�� ����Ѵ�
SELECT * FROM employees WHERE first_name = 'Sarah';
SELECT * FROM employees WHERE last_name = 'Smith';

-- ��¥ Ÿ�Ե� ������ �񱳰� �����ϴ�
SELECT * FROM employees WHERE hire_date < '2004/01/01';
SELECT * FROM employees WHERE hire_date < '2005/01/01';
SELECT * FROM employees WHERE hire_date < '2006/01/01';
SELECT * FROM employees WHERE hire_date < '2007/01/01';

-- AND, OR, NOT
SELECT * FROM employees WHERE hire_date >= '2006/01/01' AND hire_date < '2007/01/01';
SELECT * FROM employees WHERE job_id = 'IT_PROG' OR job_id = 'ST_CLERK';


/*
    ����1 : 2000���� 3000������ ������ �޴� ��� ������� ��� ������ ��ȸ�غ�����
    
    ����2 : �μ���ȣ�� 30���̰��� 60���̰ų� 90���� ��� ������� �̸�/��å/��ȭ��ȣ/�μ���ȣ�� ��ȸ�غ�����
*/
SELECT * FROM employees WHERE salary >= 2000 AND salary <= 3000;
SELECT
    first_name,
    job_id,
    phone_number,
    department_id
FROM
    employees
WHERE
    department_id = 30
    OR department_id = 60
    OR department_id = 90;
    
-- ����� ¦���� ����� ��ȸ�غ��� 
-- �� MOD() �� ���� ������ ������ �� �� �ִ�. %�� ���Ѵ�.
SELECT * FROM employees WHERE MOD(employee_id, 2) = 0;



-- COLUMN BETWEEN A AND B : �ش� �÷� ���� A�̻� B���� �� ��� true
SELECT
    *
FROM
    employees
WHERE
    salary BETWEEN 2000 AND 3000;

-- COLUMN IN (A, B, C ...) : ()���� ���뿡 ���� �����ϴ� ��� true
SELECT
    *
FROM
    employees
WHERE
    department_id IN ( 30, 60, 90 );

-- Ŀ�̼� �ۼ�Ʈ�� NULL�� ����� ��� ��ȸ�غ���
SELECT * FROM employees WHERE commission_pct = NULL; -- �ƹ��͵� �ȳ���

-- ���� NULL�� ������ ���� ���� = NULL �� �ƴ϶� IS NULL�� ����ؾ� �Ѵ� (NULL�� ũ�� �񱳰� �Ұ����ϴ�)
SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;

-- NOT�� ��ġ�� ���� �����Ӵ�
SELECT * FROM employees WHERE department_id NOT IN (30, 60, 90);
SELECT * FROM employees WHERE NOT department_id IN (30, 60, 90);

SELECT * FROM employees WHERE commission_pct IS NOT NULL;
SELECT * FROM employees WHERE NOT commission_pct IS NULL;

SELECT * FROM employees WHERE salary NOT BETWEEN 2000 AND 3000;
SELECT * FROM employees WHERE NOT salary BETWEEN 2000 AND 3000;


/*
    # LIKE
    - �������� �Ϻκ����� ���ϴ� ������ �˻��� �� �ִ�
    - ���� Ÿ�԰� ��¥ Ÿ�Կ� ����� �� �ִ�
    - % : ���� ���� ���� �ƹ� ���ڿ��̳� �͵� �Ǵ� ���ϵ� ī�� (������ ���� �͵� ����)
    -  _ : �ϳ��� �ƹ� ���ڰ� �ݵ�� �;��ϴ� ���ϵ� ī��
*/

-- �̸��� J�� �����ϴ� ��� ����� ��ȸ
SELECT first_name FROM employees WHERE first_name LIKE 'J%';

-- �̸��� �� ��° ���ڰ� u�� ��� ����� ��ȸ
SELECT first_name FROM employees WHERE first_name LIKE '_u%';

-- �̸��� �� ��° ���ڰ� e�� ��� ����� ��ȸ
SELECT first_name FROM employees WHERE first_name LIKE '__e%';

-- �̸��� x�� ���ԵǾ� �ִ� ��� ����� ��ȸ
SELECT first_name FROM employees WHERE first_name LIKE '%x%';


/*
    ����1 : �̸��� �ڿ��� �� ��° ���ڰ� a�� ��� ����� ��ȸ�غ�����
    
    ����2 : �̸��� e�� �� �� �̻� ���Ե� ��� ����� ��ȸ�غ�����
    
    ����3 : �̸��� �ټ� �����̸鼭 a�� ������ ��� ����� ��ȸ�غ�����
*/
SELECT first_name FROM employees WHERE first_name LIKE '%a__';
SELECT first_name FROM employees WHERE first_name LIKE '%e%e%';
SELECT first_name FROM employees WHERE first_name LIKE '____a';























