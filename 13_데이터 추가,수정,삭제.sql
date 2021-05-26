DESC coffees;
SELECT * FROM coffees;
/*
    # ���̺� ������ �߰��ϱ�
       INSERT INTO ���̺��(�÷���, ...) VALUES(��, ...)    
*/
INSERT INTO coffees(coffee_id, cname, price) VALUES(1, '�Ƹ޸�ī��', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(2, '���̽� �Ƹ޸�ī��', 2500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(3, 'ī���', 3000);

-- �Ϻ� �÷����� ������ �߰��ϱ� (�����͸� ���� ���� �÷��� null�� ��)
INSERT INTO coffees(cname, price) VALUES('�Ϻ���', 5500);
INSERT INTO coffees(cname) VALUES('�������');

-- �÷����� �����ϰ� ������ �߰��ϱ� (�ݵ�� ��� �����͸� �÷� ������� �־���� �Ѵ�)
INSERT INTO coffees VALUES(6, '���ɺ���', 6500);
INSERT INTO coffees VALUES(6, '�������', 6500);

-- �÷����� ��� �����ָ� ������ �������
INSERT INTO coffees(price, cname, coffee_id) VALUES(4000, 'ī���ī', 8);
INSERT INTO coffees(price, coffee_id, cname) VALUES(4000,  6, 'ī��� �����ƶ�');

-- INSERT INTO ���̺�� (���� ����) : ���� ������ ���̺� INSERT �� �� �ִ�
INSERT INTO coffees (SELECT * FROM coffees);


SELECT * FROM coffees ORDER BY coffee_id;

/* 
    # ���̺� ������ �����ϱ�
    - UPDATE ���̺�� SET �÷�=�� WHERE ����;
    - UPDATE ������ �������� ������ ��� ���� �����Ѵ�
    - ������ �ִٸ� ������ �����ϴ� ��� ���� �����Ѵ�
    - �ϳ��� ���� ������ �� �ִ� �⺻Ű�� �Բ� ���Ǵ� ��찡 ����
*/
UPDATE coffees SET price = 1000;
UPDATE coffees SET price = 2000 WHERE cname LIKE '%�Ƹ޸�ī��%';
UPDATE coffees SET price = price + 500 WHERE cname LIKE '%���̽�%';

-- ���� �÷��� ������ ���� ��ǥ�� ����Ѵ�
UPDATE coffees SET price = 5000, coffee_id = 100 WHERE cname LIKE '%����';

SELECT * FROM coffees;

-- ����1 : ������ �ƴϰ�, �Ƹ޸�ī�뵵 �ƴ� ��� ��ǰ���� ������ 3õ������ �����غ�����
UPDATE coffees
SET
    price = 3000
WHERE
    cname NOT LIKE '%�Ƹ޸�ī��%'
    AND cname NOT LIKE '%����%';
    
/*
    # ���̺� ������ �����ϱ�
    - DELETE FROM ���̺�� WHERE ����
    - ���ǿ� �´� �� ��ü�� �����Ѵ�. (Ư�� �÷� ���� �����ϴ� ���� UPDATE�� �ش��Ѵ�)
    - ���� ������ �������� ������ ��� ���� �����Ѵ�
    - ������ �ִٸ� ������ �����ϴ� ��� ���� �����Ѵ�
    - �ϳ��� ���� ������ �� �ִ� �⺻Ű�� �Բ� ���Ǵ� ��찡 ����
*/
COMMIT;

SELECT * FROM coffees;

DELETE FROM coffees WHERE cname LIKE '%����';

ROLLBACK;