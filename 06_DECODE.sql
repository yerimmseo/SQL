/*
    # DECODE
    - Ư�� �÷��� ���� ���ؼ� ǥ���� �����͸� �����Ѵ�
    - switch case ���� ������ �Ѵ�
    - 
*/
SELECT * FROM employees;

SELECT
    last_name,
    department_id,
    DECODE(department_id, 
        90, 'Executive',
        100, 'Finance',
        60, '�ٺ�',
        30, 3 + 5
    ) AS department_name
FROM
    employees;
    
/*
    ����1 : ���޿� ���� �޿��� �ٸ��� �λ��Ͽ� ����غ�����
        IT_PROG : 15% �λ�
        FI_ACCOUNT : 10% �λ�
        ��� ������ CLERK : 5% �λ�
        
    ������ �޿��� before_salary��, �λ�� �޿��� after_salary�� �̸�/���ް� �Բ� ���
*/
SELECT * FROM employees;
SELECT DISTINCT
    job_id
FROM
    employees
WHERE
    job_id LIKE '%CLERK%'; SELECT
      last_name,
      job_id,
      salary        AS before_salary,
      NVL(DECODE(job_id, 'IT_PROG', salary * 1.15, 'FI_ACCOUNT', salary * 1.1),
          salary) AS after_salary
  FROM
      employees
  WHERE
      job_id NOT LIKE '%CLERK%'
UNION
SELECT
    last_name,
    job_id,
    salary           AS before_salary,
    salary * 1.05    AS after_salary
FROM
    employees
WHERE
    job_id LIKE '%CLERK%';

/*
    # DECODE�� �ش� �÷��� ���� ��Ȯ�ϰ� ��ġ�ϴ� ���� �̿��� �� ������
       CASE���� ������ ����� �� �ִ�
*/
SELECT
    last_name,
    job_id,
    salary  AS before_salary,
    CASE
        WHEN job_id = 'IT_PROG' THEN
            salary * 1.15
        WHEN job_id = 'FI_ACCOUNT' THEN
            salary * 1.1
        WHEN job_id LIKE '%CLERK%' THEN
            salary * 1.05
        ELSE
            salary
    END     AS after_salary
FROM
    employees;