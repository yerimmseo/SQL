DESC coffees;
SELECT * FROM coffees;
/*
    # 테이블 데이터 추가하기
       INSERT INTO 테이블명(컬럼명, ...) VALUES(값, ...)    
*/
INSERT INTO coffees(coffee_id, cname, price) VALUES(1, '아메리카노', 2000);
INSERT INTO coffees(coffee_id, cname, price) VALUES(2, '아이스 아메리카노', 2500);
INSERT INTO coffees(coffee_id, cname, price) VALUES(3, '카페라떼', 3000);

-- 일부 컬럼에만 데이터 추가하기 (데이터를 넣지 않은 컬럼은 null이 됨)
INSERT INTO coffees(cname, price) VALUES('팥빙수', 5500);
INSERT INTO coffees(cname) VALUES('망고빙수');

-- 컬럼명을 생략하고 데이터 추가하기 (반드시 모든 데이터를 컬럼 순서대로 넣어줘야 한다)
INSERT INTO coffees VALUES(6, '눈꽃빙수', 6500);
INSERT INTO coffees VALUES(6, '딸기빙수', 6500);

-- 컬럼명을 모두 적어주면 순서는 상관없다
INSERT INTO coffees(price, cname, coffee_id) VALUES(4000, '카페모카', 8);
INSERT INTO coffees(price, coffee_id, cname) VALUES(4000,  6, '카라멜 마끼아또');

-- INSERT INTO 테이블명 (서브 쿼리) : 서브 쿼리를 테이블에 INSERT 할 수 있다
INSERT INTO coffees (SELECT * FROM coffees);


SELECT * FROM coffees ORDER BY coffee_id;

/* 
    # 테이블 데이터 수정하기
    - UPDATE 테이블명 SET 컬럼=값 WHERE 조건;
    - UPDATE 조건을 설정하지 않으면 모든 행을 수정한다
    - 조건이 있다면 조건을 만족하는 모든 행을 수정한다
    - 하나의 행을 구분할 수 있는 기본키와 함께 사용되는 경우가 많다
*/
UPDATE coffees SET price = 1000;
UPDATE coffees SET price = 2000 WHERE cname LIKE '%아메리카노%';
UPDATE coffees SET price = price + 500 WHERE cname LIKE '%아이스%';

-- 여러 컬럼을 수정할 때는 쉼표를 사용한다
UPDATE coffees SET price = 5000, coffee_id = 100 WHERE cname LIKE '%빙수';

SELECT * FROM coffees;

-- 연습1 : 빙수도 아니고, 아메리카노도 아닌 모든 제품들의 가격을 3천원으로 수정해보세요
UPDATE coffees
SET
    price = 3000
WHERE
    cname NOT LIKE '%아메리카노%'
    AND cname NOT LIKE '%빙수%';
    
/*
    # 테이블 데이터 삭제하기
    - DELETE FROM 테이블명 WHERE 조건
    - 조건에 맞는 행 전체를 삭제한다. (특정 컬럼 값만 삭제하는 것은 UPDATE에 해당한다)
    - 삭제 조건을 설정하지 않으면 모든 행을 삭제한다
    - 조건이 있다면 조건을 만족하는 모든 행을 삭제한다
    - 하나의 행을 구분할 수 있는 기본키와 함께 사용되는 경우가 많다
*/
COMMIT;

SELECT * FROM coffees;

DELETE FROM coffees WHERE cname LIKE '%빙수';

ROLLBACK;