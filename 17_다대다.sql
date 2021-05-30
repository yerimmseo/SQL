/*
    # ��ƼƼ���� �ٴ�� ���谡 �߻��ϴ� ��쿡 ���Ͽ�
    1. �� ���� 1:�� ���踦 ����� �ذ��Ѵ� (������ �ſ� ���ϵȴ�)
    
    �޴�           �մ�                         �޴�          �ֹ�          �մ�
                                                    PK            FK      FK     PK            
    ¥���         A               =>         ¥���       ¥���  A      A
    «��            B                            «��          «��     A      B
    ������         C                            ������       ������  A      C
    «�͹�         D                            «�͹�       ¥��     B      D
                      E                                            «��    B       E
                                                                   ��¥��  C
    
    2. �׳� �����ϰ� �� ���̺� �� ���´� (������ �������� �ʴ´�, ������ �뷮�� �� ���� �����Ѵ�)
*/
CREATE TABLE chinese_menu (
    cname VARCHAR2(40) CONSTRAINT CMENU_CNAME_NN NOT NULL,
    price NUMBER(10),
    CONSTRAINT CMENU_CNAME_PK PRIMARY KEY (cname)
);

CREATE TABLE menu_order (
    cname VARCHAR2(40),
    cus_name VARCHAR2(10),
    CONSTRAINT MENU_NAME_FK FOREIGN KEY (cname) REFERENCES chinese_menu (cname),
    CONSTRAINT MENU_CUSNAME_FK FOREIGN KEY (cus_name) REFERENCES customer (cus_name)
);

CREATE TABLE customer (
    cus_name VARCHAR2(10) CONSTRAINT CUS_NAME_NN NOT NULL,
    CONSTRAINT CUS_NAME_PK PRIMARY KEY (cus_name)
);
ALTER TABLE customer ADD (limited NUMBER(10));

INSERT INTO chinese_menu VALUES ('¥���', 6000);
INSERT INTO chinese_menu VALUES ('«��', 7000);
INSERT INTO chinese_menu VALUES ('������', 13000);
INSERT INTO chinese_menu VALUES ('«�͹�', 7000);
INSERT INTO chinese_menu VALUES ('��¥��', 8000);

INSERT INTO customer VALUES ('A', 20000);
INSERT INTO customer VALUES ('B', 10000);
INSERT INTO customer VALUES ('C', 30000);
INSERT INTO customer VALUES ('D', 40000);
INSERT INTO customer VALUES ('E', 20000);

INSERT INTO menu_order VALUES ('¥���', 'A');
INSERT INTO menu_order VALUES ('«��', 'A');
INSERT INTO menu_order VALUES ('������', 'A');
INSERT INTO menu_order VALUES ('¥���', 'B');
INSERT INTO menu_order VALUES ('«��', 'B');
INSERT INTO menu_order VALUES ('��¥��', 'C');

SELECT * FROM chinese_menu;
SELECT * FROM customer;
SELECT * FROM menu_order;

/*
    1. A���� ��Ų ��� �޴��� ��ȸ
    2. B���� ��Ų ��� �޴��� ������ ��ȸ
    3. ��Ų �޴��� ������ �ѵ��� �Ѵ� �մԵ��� ������ ��ȸ 
*/
SELECT cname FROM menu_order WHERE cus_name = 'A';
SELECT SUM(price) FROM menu_order INNER JOIN chinese_menu USING (cname) WHERE cus_name = 'B';

SELECT
    cus_name
FROM
         customer
    INNER JOIN menu_order USING ( cus_name )
    INNER JOIN chinese_menu USING ( cname )
WHERE limited < ALL (SELECT SUM(price) FROM menu_order GROUP BY cus_name)
ORDER BY 
    cus_name;

SELECT
    SUM(price),
    cus_name
FROM
         customer
    INNER JOIN menu_order USING ( cus_name )
    INNER JOIN chinese_menu USING ( cname )
GROUP BY 
    cus_name
ORDER BY 
    cus_name;

COMMIT;
INSERT INTO menu_order VALUES ('��¥��', 'C');
INSERT INTO menu_order VALUES ('��¥��', 'C');
INSERT INTO menu_order VALUES ('��¥��', 'C');
ROLLBACK;
