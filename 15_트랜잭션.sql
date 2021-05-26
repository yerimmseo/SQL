/*
    # 트랜잭션 (Transaction)
    - 데이터 처리의 한 단위
    - 하나의 논리적인 작업이 완전하게 마무리 될 때 까지의 절차
    - ex: 송금 트랜잭션
           1. 보내는 사람의 통장에서 돈이 줄어든다
           2. 받는 사람의 통장의 돈이 늘어난다
    - 하나의 트랜잭션은 여러 명령어의 집합이다
    - 트랜잭션이 정상적으로 완료되는 경우에만 변경 사항을 확정짓는다 (all or nothing)
    - 트랜잭션을 관리하기 위해 사용되는 TCL로는 COMMIT, ROLLBACK, SAVEPOINT 등이 있다
    - 트랜잭션은 마지막으로 실행된 커밋 (또는 롤백)이후 부터 새로운 커밋을 실행하는 시점까지 수행하는 모든 DML을 의미한다
      (DB의 데이터 객체는 트랜잭션의 관리 대상이 아니다)
    
    COMMIT -> INSERT1 -> INSERT2 -> UPDATE -> CREATE TABLE -> DELETE1 -> 문제발생(ROLLBACK) -> COMMIT
*/
COMMIT;

-- 테이블의 모든 내용을 자른다. DROP TABLE과 다르게 구조는 남긴다
-- CREATE TABLE, DROP TABLE, TRUNCATE TABLE 등의 DDL은 트랜잭션으로 관리할 수 없다
TRUNCATE TABLE coffees; 
ROLLBACK;

-- 연습1 : coffees 테이블에 원하는 새로운 컬럼을 추가해보세요
ALTER TABLE coffees ADD (origin VARCHAR2(30));
ALTER TABLE coffees ADD (ice VARCHAR(10));
ALTER TABLE coffees ADD (caffeine NUMBER(5));

-- 연습2 : 컬럼의 이름도 몇 개 변경해보세요
ALTER TABLE coffees RENAME COLUMN name TO cname;

-- 연습3 : 제대로 된 메뉴를 5개 이상 넣어보세요
INSERT INTO coffees VALUES (1, '아메리카노', 4000, '콜롬비아', 'Y', 80);
INSERT INTO coffees VALUES (2, '카페라떼', 4500, '콜롬비아', 'N', 40);
INSERT INTO coffees VALUES (3, '카페모카', 5000,  '과테말라', 'Y', 40);
INSERT INTO coffees VALUES (4, '카라멜마끼아또', 5000, '에티오피아', 'N', 40);
INSERT INTO coffees VALUES (5, '드립커피', 3000, '케냐', 'N', 80);
-----------------------------------------------------------------------------------------
INSERT INTO coffees(coffee_id, cname, price) VALUES(1, '아메리카노', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(2, '아이스 아메리카노', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(3, '카페라떼', 3000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(4, '아인슈페너', 8000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(5, '카푸치노', 6500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(6, '카페 비엔나', 7000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(7, '에스프레소', 1500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(8, '콜드 브루', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(9, '에스프레소 콘파나', 5000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(10, '카페오레', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(11, '카푸치노', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(12, '비너 멜랑쉬', 7500);

INSERT INTO coffees(coffee_id, cname, price) VALUES(13, '크랜베리아몬드 쿠키', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(14, '모카초코칩 쿠키', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(15, '더블초코칩 쿠키', 3500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(16, '치즈 케이크', 4500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(17, '초코무스 케이크', 4500);

ALTER TABLE coffees ADD(bitter CHAR(5));
ALTER TABLE coffees MODIFY(bitter CHAR(15));

UPDATE coffees SET bitter = '★★★☆☆';

COMMIT;

-- INSERT, UPDATE, DELETE는 DML이기 때문에 ROLLBACK으로 다시 되돌릴 수 있다
INSERT INTO coffees VALUES(18, '감자탕', 8000, null);
SAVEPOINT save01;

DELETE FROM coffees WHERE coffee_id BETWEEN 3 AND 10;
SAVEPOINT save02;

UPDATE coffees SET cname = replace(cname, '아메리', '이탈리') WHERE cname LIKE '%아메리%';
SAVEPOINT save03;

ROLLBACK;
ROLLBACK TO save03;
ROLLBACK TO save02;
ROLLBACK TO save01;
-- save01로 돌아가면 save02는 없는 상태이므로 나중에 생성된 세이브 포인트로는 돌아갈 수 없다
ROLLBACK TO save02;

SELECT * FROM coffees;