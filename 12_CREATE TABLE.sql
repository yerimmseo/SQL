/*    
    # DML (Data Manipulation Language, 데이터 조작어) ※ DB의 CRUD
    - SELECT : 테이블의 데이터 조회
    - INSERT : 테이블의 데이터 생성
    - DELETE : 테이블의 데이터 삭제
    - UPDATE : 테이블의 데이터 수정
    
      ※ CRUD - Creat. Read. Update. Delete. 모든 프로그램에는 CRUD가 다양한 형태로 존재한다.
    
    # DDL (Data Definitaion Language, 데이터 정의어)
    - 테이블, 시퀀스, 뷰 ... 등 DB에서 사용하는 오브젝트 구조를 생성할 때 사용하는 명령어
    - CREATE : DB 오브젝트 생성
    - DROP : DB 오브젝트 삭제
    - ALTER : DB 오브젝트 수정
    - TRUNCATE : DB 오브젝트 완전 삭제
    
    # DCL (Data Control Language, 데이터 제어 명령어)
    - DB의 사용자들을 관리하는 명령어
    - GRANT : 사용자에게 권한을 부여
    - REVOKE : 사용자의 권환을 회수
*/
-- CREATE TABLE 테이블명 (컬럼이름1 컬럼타입1, 컬럼이름2, 컬럼타입2, ...);
CREATE TABLE coffees (
    coffee_id NUMBER(5),
    cname VARCHAR2(50),
    price NUMBER(5)
);

DESC coffees;

-- DROP TABLE 테이블명;
DROP TABLE coffees;

-- 삭제한 테이블은 휴지통(recyclebin)에 담겨있다
show recyclebin;
SELECT * FROM recyclebin;

-- 휴지통 복구하기
flashback table coffees to before drop;
SELECT * FROM coffees;

-- 휴지통 비우기
purge recyclebin;

/*
    # 데이터 딕셔너리
    - 데이터에 대한 데이터 (메타 데이터)
    - DB는 우리가 추가한 데이터를 알아서 관리한다
    - 현재 상태는 DB의 데이터 딕셔너리를 통해서만 알 수 있다
    - 사용자가 직접 데이터 딕셔너리를 수정할 수는 없다
    
    # 데이터 딕셔너리 뷰
    - 데이터 딕셔너리 사용자가 확인하기 편리한 형태로 제공하는 뷰
    - user_가 붙으면 해당 계정의 데이터 딕셔너리 임을 나타낸다
    - all_가 붙으면 모든 계정의 데이터 딕셔너리임을 나타낸다
*/
SELECT * FROM tabs;
SELECT * FROM user_tables;
SELECT * FROM all_tables WHERE table_name LIKE '%emp%';