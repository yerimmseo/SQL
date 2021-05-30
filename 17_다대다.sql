/*
    # 엔티티간의 다대다 관계가 발생하는 경우에 대하여
    1. 두 개의 1:다 관계를 만들어 해결한다 (성능이 매우 저하된다)
    
    메뉴           손님                         메뉴          주문          손님
                                                    PK            FK      FK     PK            
    짜장면         A               =>         짜장면       짜장면  A      A
    짬뽕            B                            짬뽕          짬뽕     A      B
    탕수육         C                            탕수육       탕수육  A      C
    짬뽕밥         D                            짬뽕밥       짜장     B      D
                      E                                            짬뽕    B       E
                                                                   탕짜면  C
    
    2. 그냥 포기하고 한 테이블에 다 적는다 (성능이 떨어지지 않는다, 물리적 용량을 더 많이 차지한다)
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

INSERT INTO chinese_menu VALUES ('짜장면', 6000);
INSERT INTO chinese_menu VALUES ('짬뽕', 7000);
INSERT INTO chinese_menu VALUES ('탕수육', 13000);
INSERT INTO chinese_menu VALUES ('짬뽕밥', 7000);
INSERT INTO chinese_menu VALUES ('탕짜면', 8000);

INSERT INTO customer VALUES ('A', 20000);
INSERT INTO customer VALUES ('B', 10000);
INSERT INTO customer VALUES ('C', 30000);
INSERT INTO customer VALUES ('D', 40000);
INSERT INTO customer VALUES ('E', 20000);

INSERT INTO menu_order VALUES ('짜장면', 'A');
INSERT INTO menu_order VALUES ('짬뽕', 'A');
INSERT INTO menu_order VALUES ('탕수육', 'A');
INSERT INTO menu_order VALUES ('짜장면', 'B');
INSERT INTO menu_order VALUES ('짬뽕', 'B');
INSERT INTO menu_order VALUES ('탕짜면', 'C');

SELECT * FROM chinese_menu;
SELECT * FROM customer;
SELECT * FROM menu_order;

/*
    1. A씨가 시킨 모든 메뉴를 조회
    2. B씨가 시킨 모든 메뉴의 총합을 조회
    3. 시킨 메뉴의 총합이 한도를 넘는 손님들의 정보를 조회 
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
INSERT INTO menu_order VALUES ('탕짜면', 'C');
INSERT INTO menu_order VALUES ('탕짜면', 'C');
INSERT INTO menu_order VALUES ('탕짜면', 'C');
ROLLBACK;
