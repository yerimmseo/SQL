/*
    # ������
    - �⺻Ű�� ����ϱ� ���ϵ��� ����� �ڵ� ��ȣ ������
    - user_sequences ������ ��ųʸ��� Ȯ���� �� �ִ�
    
    CREATE SEQUENCE ��������
                                [START WITH n]                - �������� ���� ��ȣ ����
                                [INCREMENT BY n]            - �������� ������ ���� 
                                [MAXVALUE n | NOMAXVALUE] - �ִ� ����
                                [MINVALUE n | NOMINVALUE]  - �ּڰ� ����
                                [CYCLE | NOCYCLE]           - �ִ񰪿� �������� �� ��ȯ ���� ����
                                [CACHE n | NOCACHE]       - �޸𸮻� �̸� ����� ���� �������� ���� ����
*/

-- ������ ������ ��ųʸ�
SELECT * FROM user_sequences;
SELECT * FROM all_sequences;

CREATE TABLE sodas (
    pid NUMBER(4) CONSTRAINT SODA_PID_PK PRIMARY KEY,
    pname VARCHAR2(30) CONSTRAINT SODA_PNAME_NN NOT NULL
);

INSERT INTO sodas VALUES(1, '���̴�');
INSERT INTO sodas VALUES(2, 'û���� ���̵�');
INSERT INTO sodas VALUES(3, '�ڸ� ���̵�');

-- 4���� �����ϰ� 1�� �����ϴ� ������ ����
CREATE SEQUENCE sodas_seq START WITH 4 INCREMENT BY 1;

SELECT * FROM user_sequences;

-- ������ ����غ���
INSERT INTO sodas VALUES(sodas_seq.nextval, '��Ʈ���ڶ�');
INSERT INTO sodas VALUES(sodas_seq.nextval, 'ȯŸ');
INSERT INTO sodas VALUES(sodas_seq.nextval, '��Ű��');
INSERT INTO sodas VALUES(sodas_seq.nextval, '�Ϲٻ�');

DELETE FROM sodas WHERE pid > 3;

SELECT * FROM sodas ORDER BY pid;


CREATE TABLE soda_categories (
    cate_id NUMBER(4),
    cate_name VARCHAR2(40),
    CONSTRAINT SC_ID_PK PRIMARY KEY (cate_id)
);

/*
    soda_categories ���̺��� ����� �������� �����غ�����
    1. ������ 10������
    2. 10�� ������ ��
    3. CACHE 10���� ����
    4. ��ȯ���� ���� ��
    5. �ִ밪�� 9000
    
    ������ ���� �� ���̺� �����͵� 3�� �־����
*/
CREATE SEQUENCE soda_cate_seq START WITH 10 INCREMENT BY 10 CACHE 10 NOCYCLE MAXVALUE 9000;

INSERT INTO soda_categories VALUES(soda_cate_seq.nextval, '���̴�');
INSERT INTO soda_categories VALUES(soda_cate_seq.nextval, '�ݶ�');
INSERT INTO soda_categories VALUES(soda_cate_seq.nextval, '���̼Ҵ�');

SELECT * FROM soda_categories;

-- ���� �� ��° ��ȣ���� ��������� �˰� ���� ��
SELECT sodas_seq.currval FROM dual; -- ������.currval
SELECT soda_cate_seq.currval FROM dual;

/*
    # ������ ����
       DROP SEQUENCE ��������;
    
    # ������ ����
       ALTER SEQUENCE ��������;
       �� �ɼ��� CREATE SEQUENCE�� ����
*/