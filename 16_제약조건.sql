/*
    # ������ ���Ἲ
    - �����Ϳ��� ������ ����� �Ѵٴ� ��
    - ��ü ���Ἲ, ���� ���Ἲ, ������ ���Ἲ ...
    
    # ��ü ���Ἲ
    - ���̺��� �����ʹ� �ݵ�� �� ���� ������ �� �־�� �Ѵ�
    - ��ü ���Ἲ�� ��Ű�� ���� ���� �������� PK�� ����Ѵ�
    
    # ���� ���Ἲ
    - ���� ���迡 �ִ� �����ʹ� �׻� �ϰ��� ���� ������ �Ѵ�
      (employees�� department_id�� departments�� department_id�� �����ϴ� ���� ����ؾ� �Ѵ�)
    - ���� ���Ἲ�� ��Ű�� ���� ���� �������� FK�� ����Ѵ�
    
    # ������ ���Ἲ
    - �ش� �������� �����ϴ� ��ü���� �׻� Ÿ���� �����ؾ��Ѵ�
    - ���̺��� �÷� Ÿ�� ���� �� CHECK�� ���ؼ� ������ ���Ἲ�� ��ų �� �ִ�
    
    # ������ ���Ἲ ���� ����
    - NOT NULL : �ش� �÷��� null�� ������� �ʴ� ��Ģ
    - UNIQUE : �ش� �÷��� �ߺ��Ǵ� ���� ������� �ʴ� ��Ģ, �׻� ������ ���� ������ �Ѵ�
    - PRIMARY KEY : �ش� �÷��� �⺻Ű�� �����Ѵ�. NOT NULL + UNIQUE. ���̺�� �ϳ��� ���� ����.
    - FOREIGN KEY : �ش� �÷��� �ܷ�Ű�� �����Ѵ�.
    - CHECK : ���ϴ� �������� ������ ���� �����Ͽ� ������ ���Ἲ�� ������ �� �ִ�
*/

-- # ���� ���� ������ ��ųʸ��� ���� ���� ������ ��� �������ǵ��� Ȯ���� �� �ִ�
SELECT * FROM user_constraints; -- ���� ������ ���� ����
SELECT * FROM all_constraints; -- ���� �������� �� �� �ִ� ��� ���� ����

/*
    # ���� ���� ���̺��� CONSTRAINT_TYPE
       P : Primary Key
       R : Foreign Key
       C : CHECK / NOT NULL
       U : UNIQUE
*/

-- ���� ���ǵ� �� ���� �߰��غ���
CREATE TABLE fruits(
    fid NUMBER(2) PRIMARY KEY,
    fname VARCHAR2(20) NOT NULL
);

-- UNIQUE
ALTER TABLE fruits MODIFY (fname VARCHAR(20) UNIQUE);
-- CHECK() ���ο� ���ϴ� ������ �߰�
ALTER TABLE fruits ADD (fcolor VARCHAR2(5) CHECK(fcolor IN ('RED', 'GREEN', 'BLUE')));

DESC fruits;

INSERT INTO fruits VALUES (2, 'Apple', 'RED');
INSERT INTO fruits VALUES (3, 'Banana', 'BLUE');

SELECT * FROM fruits;

/*
    # ���̺� �����ϴ� ���� ���� �����ϱ�  
    - ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
*/

ALTER TABLE fruits DROP CONSTRAINT SYS_C007420;
ALTER TABLE fruits DROP CONSTRAINT SYS_C007418;
ALTER TABLE fruits MODIFY (fcolor VARCHAR(10));

UPDATE fruits SET fcolor = 'Yellow' WHERE fname = 'Banana';

/*
    # ���̺��� �̹� �����ϴ� �÷��� �������� �߰��ϱ�
    - ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������(����� �÷�);
    - ALTER TABLE ���̺�� MODIFY �÷��� (���� ����);
*/
ALTER TABLE fruits ADD CONSTRAINT FRUITS_FID_PK PRIMARY KEY(fid);

SELECT * FROM user_constraints;
DESC fruits;

-- �� ���� ���Ǹ��� �ڵ������Ǵ� �̸����� ���� ������ �� �ִ� ���� ���� �̸����� �����ؾ� �Ѵ�
INSERT INTO fruits VALUES(1, 'Orange', 'Orange');


/*
    # ���� ������ �߰��ϴ� ���
    1. ���̺� ������ ���ÿ� ���� ���� �߰��ϱ�
        - �÷��� �÷�Ÿ�� CONSTRAINT �������Ǹ� ��������Ÿ��
        - �ݵ�� ���� ���� �̸��� �� ��Ģ�� �°� ������ ����
    2. ���̺� ���� �� ���� ������ �߰��ϱ�
*/
-- #1
CREATE TABLE fruits2 (
    fid         NUMBER(4)       
        CONSTRAINT FRUITS2_FID_PK PRIMARY KEY,
    fname    VARCHAR2(20)   
        CONSTRAINT FRUITS2_FNAME_NN NOT NULL
        CONSTRAINT FRUITS2_FNAME_UK UNIQUE,
    fcolor     VARCHAR2(10)
        CONSTRAINT FRUITS2_FCOLOR_NN NOT NULL,
    fsize      CHAR(1)
        CONSTRAINT FRUITS2_FSIZE_CHK CHECK (fsize IN ('L', 'N', 'S'))    
);
DESC fruits2;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS2';


-- #2
CREATE TABLE fruits3 (
    fid         NUMBER(4),       
    fname    VARCHAR2(20),   
    fcolor     VARCHAR2(10),
    fsize      CHAR(1)
);
-- NOT NULL�� CHECK�� ADD CONSTRAINT ��� MODIFY�� �̿��� �߰�/�����Ѵ�
ALTER TABLE fruits3 ADD CONSTRAINT FRUITS3_FID_PK PRIMARY KEY (fid);
ALTER TABLE fruits3 ADD CONSTRAINT FRUITS3_FNAME_UK UNIQUE (fname);
ALTER TABLE fruits3 MODIFY (fname VARCHAR2(20) CONSTRAINT FRUITS3_FNAME_NN NOT NULL);
ALTER TABLE fruits3 MODIFY (fcolor VARCHAR2(10) CONSTRAINT FRUITS3_FCOLOR_NN NOT NULL);
ALTER TABLE fruits3 MODIFY (fsize CHAR(1) CONSTRAINT FRUITS3_FSIZE_CHK CHECK (fsize IN('L', 'N', 'S')));
DESC fruits3;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';


/*
    # default ���� ����
    - �ش� �÷��� �⺻���� �����س��� ���� ����
    - default�� ������ �÷��� �� �߰��� ���� ���� ������ null��� default�� ������ ���� �߰��ȴ�
*/
ALTER TABLE fruits3 ADD (fprice NUMBER(7) DEFAULT 0);
ALTER TABLE fruits3 MODIFY (fprice NUMBER(7) DEFAULT 10);

SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';
DESC fruits3;

/*
    # Foreign Key ���� ����
    - ���� ������ ������ �� � ���̺��� � �÷��� ������ �� �ݵ�� �����ؾ� �Ѵ�
    - �ٸ� ���̺��� PK �Ǵ� UK ���� ������ �ɸ� �÷��� ������ �� �ִ�
*/
CREATE TABLE fruit_locations (
    lid NUMBER(2),
    addr VARCHAR2(200),
    city VARCHAR2(40)
);

INSERT INTO fruit_locations VALUES(10, '��û�ϵ� û�ֽ�', 'û��');
INSERT INTO fruit_locations VALUES(20, '���ϵ� �ȵ���', '�ȵ�');
INSERT INTO fruit_locations VALUES(30, '���󳲵� ���ﱺ', '����');
INSERT INTO fruit_locations VALUES(40, '��û���� ����', '���');

-- �� UNIQUE �Ǵ� PRIMARY KEY ���� ������ �ɸ��� ���� �÷��� �ܷ�Ű�� ������ �� ����
ALTER TABLE fruit_locations ADD CONSTRAINT FLO_LID_UK UNIQUE(lid);
ALTER TABLE fruits3 ADD (lid NUMBER(2) CONSTRAINT FRUITS3_LID_FK REFERENCES fruit_locations(lid));

SELECT * FROM user_constraints WHERE constraint_name LIKE 'FRUITS3%';

SELECT * FROM fruits3;

INSERT INTO fruits3(fid, fname, fcolor, fsize, lid) VALUES(1, 'Apple', 'Red', 'L', 10);
INSERT INTO fruits3(fid, fname, fcolor, fsize, lid) VALUES(2, 'Banana', 'Yellow', 'N', 20);

SELECT * FROM fruits3 INNER JOIN fruit_locations USING (lid);


/*
    # ���� ���� �߰��ϴ� ���3 (���̺� ������ �߰��ϱ�)
    - �÷��� ��� ������ CREATE TABLE�� �� �ڿ� ���� ���� ������ �����ϴ� ���
    - DEFAULT�� NOT NULL�� ���̺� ���� ������� ������ �� ����
*/
CREATE TABLE fruits4 (
    fid         NUMBER(4),
    fname    VARCHAR2(20) CONSTRAINT F4_FNAME_NN NOT NULL,
    fcolor     VARCHAR2(10) CONSTRAINT F4_FCOLOR_NN NOT NULL,
    fsize       CHAR(1),
    fprice     NUMBER(7) DEFAULT 123,
    lid         NUMBER(2),
    CONSTRAINT F4_FID_PK PRIMARY KEY (fid),
    CONSTRAINT F4_FNAME_UK UNIQUE (fname),
    CONSTRAINT F4_FSIZE_CHK CHECK (fsize IN ('L', 'N', 'S')),
    CONSTRAINT F4_LID_FK FOREIGN KEY (lid) REFERENCES fruit_locations (lid)
);
SELECT * FROM user_constraints WHERE table_name = 'FRUITS4';


/*
    # 1 : N ���踦 ������ �� ���̺��� ������ �� �����غ�����
    �� ���±��� ��� ��� ���� ������ �ּ� �� ���� ����� ��, �� ���̺� ������ 3���� �־ ��
*/
CREATE TABLE student (
    stu_id      NUMBER(7),
    sname     VARCHAR2(10) CONSTRAINT STU_SNAME_NN NOT NULL,
    stu_addr   VARCHAR2(100) CONSTRAINT STU_ADDR_NN NOT NULL,
    smajor_id  NUMBER(7),
    CONSTRAINT STU_ID_PK PRIMARY KEY (stu_id),
    CONSTRAINT STU_MAJOR_ID_CHK CHECK (smajor_id IN (10, 20, 30, 40)),
    CONSTRAINT STU_MAJOR_ID_FK FOREIGN KEY (smajor_id) REFERENCES student_major (smajor_id)
);

CREATE TABLE student_major (
    smajor_id NUMBER(7) CONSTRAINT STUM_MID_ID_NN NOT NULL,
    mname VARCHAR2(20) CONSTRAINT STUM_MNAME_NN NOT NULL,
    CONSTRAINT STUM_MID_ID_UK UNIQUE (smajor_id)
);

SELECT * FROM student;
SELECT * FROM student_major;
SELECT * FROM user_constraints WHERE table_name = 'STUDENT';
SELECT * FROM user_constraints WHERE table_name = 'STUDENT_MAJOR';

ALTER TABLE student_major MODIFY (mname VARCHAR2(20) CONSTRAINT STUM_MNAME_UK UNIQUE);
INSERT INTO student_major VALUES (10, '�����а�');
INSERT INTO student_major VALUES (20, '��ǻ�Ͱ��а�');
INSERT INTO student_major VALUES (30, '����װ��а�');
INSERT INTO student_major VALUES (40, '���ڰ��а�');

INSERT INTO student VALUES (1, 'ȫ�浿', '������ ���뱸', 10);
INSERT INTO student VALUES (2, '��浿', '������ �Ǽ���', 40); 
INSERT INTO student VALUES (3, '�ڱ浿', '������ �Ǽ���', 20); 
INSERT INTO student VALUES (4, '�̱浿', '������ ��ȱ�', 30); 

SELECT * FROM student INNER JOIN student_major USING (smajor_id) ORDER BY stu_id;

----------------------------------------------
-- �ٸ� ���̺��� FK�� �����Ǵ� ���̺��� ���� �ƹ��������� �����ϸ� ���Ἲ�� ��ĥ ������ ����
SELECT * FROM fruits3;
SELECT * FROM fruit_locations;

INSERT INTO fruits3(fid, fname, fcolor, fsize, lid) VALUES(3, 'Kiwi', 'Olive', 'S', 10);

COMMIT;

DELETE FROM fruit_locations WHERE lid = 40;

ROLLBACK;

/*
    # ON DELETE ���� ����
    - �ڽ� ���ڵ尡 �����ϰ� �ִ� �θ� ���ڵ带 ������ ���� ��å�� ������ �� �ִ�
    - CASCADE, SET NULL, RESTRICT
    
    # ON DELETE CASCADE
    - �θ� ���ڵ带 �����ϸ� �ڽ� ���ڵ带 ��� �Բ� �����Ѵ�
    
    # ON DELETE SET NULL
    - �θ� ���ڵ带 �����ϸ� �����ϴ� �ڽ� ���ڵ��� ���� null�� �����Ѵ�
    
    # RESTRICT
    - �ڽ� ���ڵ尡 ������ �θ� ���ڵ带 ������ �� ���� �Ѵ�
    - ON DELETE�� �������� ������ �ȴ�
*/

-- # CASCADE TEST
SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';

ALTER TABLE fruits3 DROP CONSTRAINT FRUITS3_LID_FK;
ALTER TABLE fruits3
    ADD CONSTRAINT fr3_lid_fk FOREIGN KEY ( lid )
        REFERENCES fruit_locations ( lid ) ON DELETE CASCADE;

SELECT * FROM fruits3;
SELECT * FROM fruit_locations;

DELETE FROM fruit_locations WHERE lid = 10;

ROLLBACK;

-- # SET NULL TEST
ALTER TABLE fruits3 DROP CONSTRAINT FRUITS3_LID_FK;
ALTER TABLE fruits3
    ADD CONSTRAINT FRUITS3_LID_FK FOREIGN KEY ( lid )
        REFERENCES fruit_locations ( lid ) ON DELETE SET NULL;

DELETE FROM fruit_locations WHERE lid = 10;