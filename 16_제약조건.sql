/*
    # 데이터 무결성
    - 데이터에는 결점이 없어야 한다는 뜻
    - 개체 무결성, 참조 무결성, 도메인 무결성 ...
    
    # 개체 무결성
    - 테이블의 데이터는 반드시 한 행을 구분할 수 있어야 한다
    - 개체 무결성을 지키기 위한 제약 조건으로 PK를 사용한다
    
    # 참조 무결성
    - 참조 관계에 있는 데이터는 항상 일관된 값을 가져야 한다
      (employees의 department_id는 departments의 department_id에 존재하는 값만 사용해야 한다)
    - 참조 무결성을 지키기 위한 제약 조건으로 FK를 사용한다
    
    # 도메인 무결성
    - 해당 도메인을 구성하는 개체들은 항상 타입이 일정해야한다
    - 테이블의 컬럼 타입 설정 및 CHECK를 통해서 도메인 무결성을 지킬 수 있다
    
    # 데이터 무결성 제약 조건
    - NOT NULL : 해당 컬럼에 null을 허용하지 않는 규칙
    - UNIQUE : 해당 컬럼에 중복되는 값을 허용하지 않는 규칙, 항상 유일한 값을 갖도록 한다
    - PRIMARY KEY : 해당 컬럼을 기본키로 설정한다. NOT NULL + UNIQUE. 테이블당 하나만 설정 가능.
    - FOREIGN KEY : 해당 컬럼을 외래키로 설정한다.
    - CHECK : 원하는 데이터의 조건을 직접 지정하여 도메인 무결성을 유지할 수 있다
*/

-- # 제약 조건 데이터 딕셔너리를 통해 현재 계정의 모든 제약조건들을 확인할 수 있다
SELECT * FROM user_constraints; -- 현재 계정의 제약 조건
SELECT * FROM all_constraints; -- 현재 계정으로 볼 수 있는 모든 제약 조건

/*
    # 제약 조건 테이블의 CONSTRAINT_TYPE
       P : Primary Key
       R : Foreign Key
       C : CHECK / NOT NULL
       U : UNIQUE
*/

-- 제약 조건들 한 번씩 추가해보기
CREATE TABLE fruits(
    fid NUMBER(2) PRIMARY KEY,
    fname VARCHAR2(20) NOT NULL
);

-- UNIQUE
ALTER TABLE fruits MODIFY (fname VARCHAR(20) UNIQUE);
-- CHECK() 내부에 원하는 조건을 추가
ALTER TABLE fruits ADD (fcolor VARCHAR2(5) CHECK(fcolor IN ('RED', 'GREEN', 'BLUE')));

DESC fruits;

INSERT INTO fruits VALUES (2, 'Apple', 'RED');
INSERT INTO fruits VALUES (3, 'Banana', 'BLUE');

SELECT * FROM fruits;

/*
    # 테이블에 존재하는 제약 조건 제거하기  
    - ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
*/

ALTER TABLE fruits DROP CONSTRAINT SYS_C007420;
ALTER TABLE fruits DROP CONSTRAINT SYS_C007418;
ALTER TABLE fruits MODIFY (fcolor VARCHAR(10));

UPDATE fruits SET fcolor = 'Yellow' WHERE fname = 'Banana';

/*
    # 테이블의 이미 존재하는 컬럼에 제약조건 추가하기
    - ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건(적용될 컬럼);
    - ALTER TABLE 테이블명 MODIFY 컬럼명 (새로 설정);
*/
ALTER TABLE fruits ADD CONSTRAINT FRUITS_FID_PK PRIMARY KEY(fid);

SELECT * FROM user_constraints;
DESC fruits;

-- ※ 제약 조건명은 자동생성되는 이름보다 쉽게 구분할 수 있는 보기 좋은 이름으로 설정해야 한다
INSERT INTO fruits VALUES(1, 'Orange', 'Orange');


/*
    # 제약 조건을 추가하는 방법
    1. 테이블 생성과 동시에 제약 조건 추가하기
        - 컬럼명 컬럼타입 CONSTRAINT 제약조건명 제약조건타입
        - 반드시 제약 조건 이름을 팀 규칙에 맞게 짓도록 하자
    2. 테이블 생성 후 제약 조건을 추가하기
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
-- NOT NULL과 CHECK는 ADD CONSTRAINT 대신 MODIFY를 이용해 추가/수정한다
ALTER TABLE fruits3 ADD CONSTRAINT FRUITS3_FID_PK PRIMARY KEY (fid);
ALTER TABLE fruits3 ADD CONSTRAINT FRUITS3_FNAME_UK UNIQUE (fname);
ALTER TABLE fruits3 MODIFY (fname VARCHAR2(20) CONSTRAINT FRUITS3_FNAME_NN NOT NULL);
ALTER TABLE fruits3 MODIFY (fcolor VARCHAR2(10) CONSTRAINT FRUITS3_FCOLOR_NN NOT NULL);
ALTER TABLE fruits3 MODIFY (fsize CHAR(1) CONSTRAINT FRUITS3_FSIZE_CHK CHECK (fsize IN('L', 'N', 'S')));
DESC fruits3;
SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';


/*
    # default 제약 조건
    - 해당 컬럼에 기본값을 설정해놓는 제약 조건
    - default가 설정된 컬럼은 행 추가시 값을 넣지 않으면 null대신 default로 설정한 값이 추가된다
*/
ALTER TABLE fruits3 ADD (fprice NUMBER(7) DEFAULT 0);
ALTER TABLE fruits3 MODIFY (fprice NUMBER(7) DEFAULT 10);

SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';
DESC fruits3;

/*
    # Foreign Key 제약 조건
    - 제약 조건을 설정할 때 어떤 테이블의 어떤 컬럼을 참조할 지 반드시 지정해야 한다
    - 다른 테이블의 PK 또는 UK 제약 조건이 걸린 컬럼만 지정할 수 있다
*/
CREATE TABLE fruit_locations (
    lid NUMBER(2),
    addr VARCHAR2(200),
    city VARCHAR2(40)
);

INSERT INTO fruit_locations VALUES(10, '충청북도 청주시', '청주');
INSERT INTO fruit_locations VALUES(20, '경상북도 안동시', '안동');
INSERT INTO fruit_locations VALUES(30, '전라남도 고흥군', '고흥');
INSERT INTO fruit_locations VALUES(40, '충청남도 논산시', '논산');

-- ※ UNIQUE 또는 PRIMARY KEY 제약 조건이 걸리지 않은 컬럼은 외래키로 참조될 수 없다
ALTER TABLE fruit_locations ADD CONSTRAINT FLO_LID_UK UNIQUE(lid);
ALTER TABLE fruits3 ADD (lid NUMBER(2) CONSTRAINT FRUITS3_LID_FK REFERENCES fruit_locations(lid));

SELECT * FROM user_constraints WHERE constraint_name LIKE 'FRUITS3%';

SELECT * FROM fruits3;

INSERT INTO fruits3(fid, fname, fcolor, fsize, lid) VALUES(1, 'Apple', 'Red', 'L', 10);
INSERT INTO fruits3(fid, fname, fcolor, fsize, lid) VALUES(2, 'Banana', 'Yellow', 'N', 20);

SELECT * FROM fruits3 INNER JOIN fruit_locations USING (lid);


/*
    # 제약 조건 추가하는 방법3 (테이블 레벨로 추가하기)
    - 컬럼을 모두 정의한 CREATE TABLE의 맨 뒤에 따로 제약 조건을 지정하는 방식
    - DEFAULT와 NOT NULL은 테이블 레벨 방식으로 정의할 수 없다
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
    # 1 : N 관계를 가지는 두 테이블을 생성한 후 연결해보세요
    ※ 여태까지 배운 모든 제약 조건을 최소 한 번씩 사용할 것, 각 테이블에 데이터 3개씩 넣어볼 것
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
INSERT INTO student_major VALUES (10, '기계공학과');
INSERT INTO student_major VALUES (20, '컴퓨터공학과');
INSERT INTO student_major VALUES (30, '기계항공학과');
INSERT INTO student_major VALUES (40, '전자공학과');

INSERT INTO student VALUES (1, '홍길동', '수원시 영통구', 10);
INSERT INTO student VALUES (2, '김길동', '수원시 권선구', 40); 
INSERT INTO student VALUES (3, '박길동', '수원시 권선구', 20); 
INSERT INTO student VALUES (4, '이길동', '수원시 장안구', 30); 

SELECT * FROM student INNER JOIN student_major USING (smajor_id) ORDER BY stu_id;

----------------------------------------------
-- 다른 테이블에서 FK로 참조되는 테이블의 행을 아무생각없이 삭제하면 무결성을 해칠 위험이 있음
SELECT * FROM fruits3;
SELECT * FROM fruit_locations;

INSERT INTO fruits3(fid, fname, fcolor, fsize, lid) VALUES(3, 'Kiwi', 'Olive', 'S', 10);

COMMIT;

DELETE FROM fruit_locations WHERE lid = 40;

ROLLBACK;

/*
    # ON DELETE 제약 조건
    - 자식 레코드가 참조하고 있는 부모 레코드를 삭제할 때의 정책을 결정할 수 있다
    - CASCADE, SET NULL, RESTRICT
    
    # ON DELETE CASCADE
    - 부모 레코드를 삭제하면 자식 레코드를 모두 함께 삭제한다
    
    # ON DELETE SET NULL
    - 부모 레코드를 삭제하면 참조하던 자식 레코드의 값을 null로 변경한다
    
    # RESTRICT
    - 자식 레코드가 있으면 부모 레코드를 삭제할 수 없게 한다
    - ON DELETE를 설정하지 않으면 된다
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