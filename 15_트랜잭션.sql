/*
    # Ʈ����� (Transaction)
    - ������ ó���� �� ����
    - �ϳ��� ������ �۾��� �����ϰ� ������ �� �� ������ ����
    - ex: �۱� Ʈ�����
           1. ������ ����� ���忡�� ���� �پ���
           2. �޴� ����� ������ ���� �þ��
    - �ϳ��� Ʈ������� ���� ��ɾ��� �����̴�
    - Ʈ������� ���������� �Ϸ�Ǵ� ��쿡�� ���� ������ Ȯ�����´� (all or nothing)
    - Ʈ������� �����ϱ� ���� ���Ǵ� TCL�δ� COMMIT, ROLLBACK, SAVEPOINT ���� �ִ�
    - Ʈ������� ���������� ����� Ŀ�� (�Ǵ� �ѹ�)���� ���� ���ο� Ŀ���� �����ϴ� �������� �����ϴ� ��� DML�� �ǹ��Ѵ�
      (DB�� ������ ��ü�� Ʈ������� ���� ����� �ƴϴ�)
    
    COMMIT -> INSERT1 -> INSERT2 -> UPDATE -> CREATE TABLE -> DELETE1 -> �����߻�(ROLLBACK) -> COMMIT
*/
COMMIT;

-- ���̺��� ��� ������ �ڸ���. DROP TABLE�� �ٸ��� ������ �����
-- CREATE TABLE, DROP TABLE, TRUNCATE TABLE ���� DDL�� Ʈ��������� ������ �� ����
TRUNCATE TABLE coffees; 
ROLLBACK;

-- ����1 : coffees ���̺� ���ϴ� ���ο� �÷��� �߰��غ�����
ALTER TABLE coffees ADD (origin VARCHAR2(30));
ALTER TABLE coffees ADD (ice VARCHAR(10));
ALTER TABLE coffees ADD (caffeine NUMBER(5));

-- ����2 : �÷��� �̸��� �� �� �����غ�����
ALTER TABLE coffees RENAME COLUMN name TO cname;

-- ����3 : ����� �� �޴��� 5�� �̻� �־����
INSERT INTO coffees VALUES (1, '�Ƹ޸�ī��', 4000, '�ݷҺ��', 'Y', 80);
INSERT INTO coffees VALUES (2, 'ī���', 4500, '�ݷҺ��', 'N', 40);
INSERT INTO coffees VALUES (3, 'ī���ī', 5000,  '���׸���', 'Y', 40);
INSERT INTO coffees VALUES (4, 'ī��Ḷ���ƶ�', 5000, '��Ƽ���Ǿ�', 'N', 40);
INSERT INTO coffees VALUES (5, '�帳Ŀ��', 3000, '�ɳ�', 'N', 80);
-----------------------------------------------------------------------------------------
INSERT INTO coffees(coffee_id, cname, price) VALUES(1, '�Ƹ޸�ī��', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(2, '���̽� �Ƹ޸�ī��', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(3, 'ī���', 3000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(4, '���ν����', 8000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(5, 'īǪġ��', 6500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(6, 'ī�� �񿣳�', 7000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(7, '����������', 1500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(8, '�ݵ� ���', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(9, '���������� ���ĳ�', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(10, 'ī�����', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(11, 'īǪġ��', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(12, '��� �����', 7500);

INSERT INTO coffees(coffee_id, cname, price) VALUES(13, 'ũ�������Ƹ�� ��Ű', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(14, '��ī����Ĩ ��Ű', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(15, '��������Ĩ ��Ű', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(16, 'ġ�� ����ũ', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(17, '���ڹ��� ����ũ', 4500);

ALTER TABLE coffees ADD(bitter CHAR(5));
ALTER TABLE coffees MODIFY(bitter CHAR(15));

UPDATE coffees SET bitter = '�ڡڡڡ١�';

COMMIT;

-- INSERT, UPDATE, DELETE�� DML�̱� ������ ROLLBACK���� �ٽ� �ǵ��� �� �ִ�
INSERT INTO coffees VALUES(18, '������', 8000, null);
SAVEPOINT save01;

DELETE FROM coffees WHERE coffee_id BETWEEN 3 AND 10;
SAVEPOINT save02;

UPDATE coffees SET cname = replace(cname, '�Ƹ޸�', '��Ż��') WHERE cname LIKE '%�Ƹ޸�%';
SAVEPOINT save03;

ROLLBACK;
ROLLBACK TO save03;
ROLLBACK TO save02;
ROLLBACK TO save01;
-- save01�� ���ư��� save02�� ���� �����̹Ƿ� ���߿� ������ ���̺� ����Ʈ�δ� ���ư� �� ����
ROLLBACK TO save02;

SELECT * FROM coffees;