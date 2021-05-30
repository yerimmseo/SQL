/*
    # ���������� ���̺� �����ϱ�
       CREATE TABLE ���̺�� AS (���� ����)�� ���̺��� ������ �� �ִ�
*/
CREATE TABLE coffees2 AS (SELECT * FROM coffees);

DESC coffees2;

CREATE TABLE bingsu AS (SELECT * FROM coffees WHERE cname LIKE '%����');

SELECT * FROM bingsu;

/*
    # �� �÷� �߰��ϱ�
       ALTER TABLE ���̺�� ADD (�÷��� �÷�Ÿ��, ...)
*/
ALTER TABLE bingsu ADD (sirup VARCHAR2(20));

/*
    # ���̺��� �÷� �̸� �����ϱ�
       ALTER TABLE ���̺�� RENAME COLUMN �����̸� TO �ٲ��̸�;
*/
ALTER TABLE bingsu RENAME COLUMN sirup TO syrup;

/*
    # ���̺� �̸� �����ϱ�
       RENAME �������̺�� TO �ٲ����̺��;
*/
RENAME bingsu TO bingsoo;

SELECT * FROM bingsoo;
SELECT * FROM bingsu;

SELECT * FROM tabs;

/*
    # �÷� Ÿ�� �����ϱ�
       ALTER TABLE ���̺�� MODIFY (�÷��� �÷�Ÿ��, ...);
*/
SELECT * FROM bingsoo;

ALTER TABLE bingsoo MODIFY (cname VARCHAR2(30));

UPDATE bingsoo SET cname = '����';
INSERT INTO bingsoo VALUES (101, '��Ʈ����ī������ξ��ø������', 7500, '����');

/*
    # �÷� �����ϱ�
       ALTER TABLE ���̺�� DROP COLUMN �÷���;
*/
SELECT * FROM bingsoo;
ALTER TABLE bingsoo DROP COLUMN syrup;



---------------------------------------------------------------------------------------
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
    TO_CHAR(ROUND((salary * (1 + NVL(commission_pct, 0)) - min_salary) / (max_salary - min_salary) * 100, 2), '990.99') AS "%"
FROM
         employees
    INNER JOIN jobs USING ( job_id );
    

-- salary - min_salary : ���� ���� �޴� ���(0%)���� ���� �� �޴� �ݾ�
-- max_salary - min_salary : �� ���� �� �ִ� �ִ� �ݾ�
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