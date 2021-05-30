/*
    # �� (View)
    - �������� �⺻ ���̺���� �̿��� ������ ������ ������ ���̺�
    - �⺻ ���̺��� �Ļ��� DB ��ü
    - �並 ���� �����(������)�� �⺻ ���̺��� ���������� ����ϰԲ� �� �� �ִ�
    
    CREATE [OR REPLACE] VIEW ���̸� 
        AS �������� 
                [WITH CHECK OPTION | WITH READ ONLY];
                
    - CREATE OR REPLACE : �̹� �����ϴ� ���� ������ �Ѵ�. ���ٸ� �����Ѵ�.
    - WITH CHECK OPTION : �ش� ���� ������ �����ϴ� DML�� ����������. (�������� DML)
    - WITH READ ONLY : �ش� ��� SELECT�� ����������. (DML ����)
*/

-- �� ������ ��ųʸ�
SELECT * FROM user_views;
SELECT * FROM all_views;

-- �⺻ �ɼ� ��
CREATE OR REPLACE VIEW dept30_view AS
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 30;
        
SELECT * FROM dept30_view;

-- �⺻ �ɼ� �並 ���ؼ� �����ο� INSERT�� �����ϴ�. (�����ڰ� INSERT�� ������ �� �ִ�)
INSERT INTO dept30_view 
    VALUES(1, 'Gildong', 'Hong', 'GHong', '515.127.4444', sysdate, 'IT_PROG', 1000, null, 100, 70);


-- �б� ���� ��
CREATE OR REPLACE VIEW dept50_view_readonly AS
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 50
WITH READ ONLY;

SELECT * FROM dept50_view_readonly;

-- �б� ���� �並 ���ؼ��� DML �۾��� ������ �� �����ϴ�.
INSERT INTO dept50_view_readonly
    VALUES(3, 'Jeedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 70);


-- üũ �ɼ� ��
CREATE OR REPLACE VIEW dept80_view_check AS
    SELECT
        employees.*
    FROM
        employees
    WHERE
        department_id = 80
WITH CHECK OPTION;

-- 80�� �μ� ����鸸 ��ȸ�ϴ� ���̱� ������, 80�� �μ��� ���õ� DML�� ����� �� �ְ� �ȴ�
SELECT * FROM dept80_view_check;
INSERT INTO dept80_view_check
    VALUES(3, 'Jaedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 70);
    
-- 80�� �μ����� DML�� �����ϴ�    
INSERT INTO dept80_view_check
    VALUES(3, 'Jaedong', 'Hong', 'HJaedong', '515.127.4446', sysdate, 'IT_PROG', 1000, null, 100, 80);

SELECT * FROM dept80_view_check;
SELECT * FROM employees;