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