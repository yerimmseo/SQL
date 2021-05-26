/*    
    # DML (Data Manipulation Language, ������ ���۾�) �� DB�� CRUD
    - SELECT : ���̺��� ������ ��ȸ
    - INSERT : ���̺��� ������ ����
    - DELETE : ���̺��� ������ ����
    - UPDATE : ���̺��� ������ ����
    
      �� CRUD - Creat. Read. Update. Delete. ��� ���α׷����� CRUD�� �پ��� ���·� �����Ѵ�.
    
    # DDL (Data Definitaion Language, ������ ���Ǿ�)
    - ���̺�, ������, �� ... �� DB���� ����ϴ� ������Ʈ ������ ������ �� ����ϴ� ��ɾ�
    - CREATE : DB ������Ʈ ����
    - DROP : DB ������Ʈ ����
    - ALTER : DB ������Ʈ ����
    - TRUNCATE : DB ������Ʈ ���� ����
    
    # DCL (Data Control Language, ������ ���� ��ɾ�)
    - DB�� ����ڵ��� �����ϴ� ��ɾ�
    - GRANT : ����ڿ��� ������ �ο�
    - REVOKE : ������� ��ȯ�� ȸ��
*/
-- CREATE TABLE ���̺�� (�÷��̸�1 �÷�Ÿ��1, �÷��̸�2, �÷�Ÿ��2, ...);
CREATE TABLE coffees (
    coffee_id NUMBER(5),
    cname VARCHAR2(50),
    price NUMBER(5)
);

DESC coffees;

-- DROP TABLE ���̺��;
DROP TABLE coffees;

-- ������ ���̺��� ������(recyclebin)�� ����ִ�
show recyclebin;
SELECT * FROM recyclebin;

-- ������ �����ϱ�
flashback table coffees to before drop;
SELECT * FROM coffees;

-- ������ ����
purge recyclebin;

/*
    # ������ ��ųʸ�
    - �����Ϳ� ���� ������ (��Ÿ ������)
    - DB�� �츮�� �߰��� �����͸� �˾Ƽ� �����Ѵ�
    - ���� ���´� DB�� ������ ��ųʸ��� ���ؼ��� �� �� �ִ�
    - ����ڰ� ���� ������ ��ųʸ��� ������ ���� ����
    
    # ������ ��ųʸ� ��
    - ������ ��ųʸ� ����ڰ� Ȯ���ϱ� ���� ���·� �����ϴ� ��
    - user_�� ������ �ش� ������ ������ ��ųʸ� ���� ��Ÿ����
    - all_�� ������ ��� ������ ������ ��ųʸ����� ��Ÿ����
*/
SELECT * FROM tabs;
SELECT * FROM user_tables;
SELECT * FROM all_tables WHERE table_name LIKE '%emp%';