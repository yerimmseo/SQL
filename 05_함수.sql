/*
	# dual ���̺�
	- ������ ���̺�
	- �ϳ��� �ุ ������ ����
*/
SELECT 3 * 2, employees.* FROM employees;
SELECT 3 * 2 FROM dual;
SELECT 1 FROM dual;

-- ABS(n) : ���밪
SELECT ABS(-123) FROM dual;

-- FLOOR(n) : ����
SELECT FLOOR(123.355) FROM dual;

-- ROUND(n) : �ݿø�
SELECT ROUND(123.555) FROM dual;

-- CEIL(n) : �ø�
SELECT CEIL(123.111) FROM dual;

-- MOD(n, m) : ������ ����
SELECT MOD(13, 10) FROM dual;

-- TRUNC(d, m) : ������ �ڸ� �� ���ϸ� �߶󳽴�
SELECT TRUNC(123.1234, 3) FROM dual;
SELECT TRUNC(123.1234, 2) FROM dual;
SELECT TRUNC(123.1234, 1) FROM dual;
SELECT TRUNC(123.1234, -1) FROM dual;
SELECT TRUNC(123.1234, -2) FROM dual;

SELECT sysdate FROM dual;

SELECT TRUNC(sysdate, 'YEAR') FROM dual;
SELECT TRUNC(sysdate, 'MONTH') FROM dual;
SELECT TRUNC(sysdate, 'DAY') FROM dual;

-- TO_CHAR�� DATEŸ�� �����͸� ���ϴ� �������� �����ϱ�
SELECT TO_CHAR(sysdate, 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'YEAR'), 'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'MONTH'),'YYYY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TRUNC(sysdate, 'DAY'),'YYYY/MM/DD HH24:MI:SS') FROM dual;

SELECT LOWER('ABC') FROM dual;
SELECT UPPER('abc') FROM dual;

SELECT SUBSTR('Hello, world!!', 1, 5) FROM dual; -- 1 base (����� �ε����� 1���� ����)
SELECT SUBSTR('Hello, world!!', 5) FROM dual; -- ���ڸ� �ϳ��� ������ �� �ڱ��� �ڸ���

SELECT LENGTH('of the people, by the people, for the people.') FROM dual;

-- LPAD(����, ����, ä�﹮��)
-- RPAD(����, ����, ä�﹮��)
-- �� ä�� ���ڰ� ������ ��� ���� ����
SELECT LPAD('title', 10, '#') FROM dual;
SELECT RPAD('title', 10) FROM dual;

-- LTRIM(����, ������ ����)
-- RTRIM(����, ������ ����)
-- �� ������ ���ڰ� ������ ��� ���� ����
SELECT LTRIM('#####TITLE', '#') FROM dual;
SELECT LTRIM('        TITLE') FROM dual;
SELECT '          TITLE' FROM dual;
 
-- TRIM() : �� ���� Ư�����ڸ� �����Ѵ�
SELECT TRIM('          title    ') FROM dual;
SELECT TRIM('#' FROM '#####title##') FROM dual;

-- ��¥ ���� �ϱ�
SELECT
    sysdate - 1 AS ����,
    sysdate AS ����,
    sysdate + 1 AS ����,
    sysdate + 2 AS "���� ��"
FROM
    dual;

-- ��¥���� �����ϸ� �� ��¥ ������ �ð��� ���� �� �ִ�
SELECT last_name, FLOOR(sysdate - hire_date) AS �ٹ��� FROM employees;

-- MONTHS_BETWEEN : �� ��¥ ������ �������� ���Ѵ�
SELECT last_name, FLOOR(MONTHS_BETWEEN(sysdate, hire_date)) AS "�ٹ� ����" FROM employees;

-- ADD_MONTHS(date, n) : DATEŸ�� �����Ϳ� ���ϴ� ��ŭ ���� ���� ���Ѵ�
SELECT ADD_MONTHS(sysdate, 5) FROM dual;

-- NEXT_DAY(date, ����) : DATEŸ�� �����͸� �������� ���� ������ ã�´�
SELECT NEXT_DAY(sysdate, 'ȭ����') FROM dual;
SELECT NEXT_DAY(sysdate, 'ȭ') FROM dual;

-- LAST_DAY(date) : DATEŸ�� �����͸� �������� �ش� ���� ������ ��¥�� ��ȯ�Ѵ�
SELECT LAST_DAY(sysdate) FROM dual;

/*
    # ����Ŭ�� ��¥ ����
       YYYY : �⵵
       YY : �⵵ (2�ڸ�)
       MM : ��
       MON : ���� ���ڷ�
       DD : ��¥
       DAY : ����
       DY : ���� (����)
       HH, HH12 : 12��
       HH24 : 24��
       MI : ��
       SS : ��
       AM, PM : ���� ���� ǥ��
    
    # ����Ŭ�� ���� ����
       0 : �ڸ����� ��Ÿ����. ���ڰ� ��� 0���� ä���.
       9 : �ڸ����� ��Ÿ����. ���ڰ� ��� ��ĭ���� ä���.
       L : �� ������ ��ȭ ��ȣ�� ���δ�
        . : �Ҽ����� ����Ѵ�
        , : õ ������ �����ϴ� ��ǥ�� ����Ѵ�
*/

-- TO_CHAR : ���ڸ� ���ڷ� �ٲٰų�, ��¥�� ���ڷ� �ٲ۴�. �ٲ� �� ������ �̿��� �� �־ ���ϴ�.
SELECT TO_CHAR(sysdate, 'MON MM MI DAY DY') FROM dual;
SELECT TO_CHAR(sysdate, 'CC HH12:MI:SS PM') FROM dual;

SELECT TO_CHAR(15000000, '999,999,999.9999L') FROM dual;
SELECT TO_CHAR(15000000, '000,000,000.0000L') FROM dual;

-- TO_NUMBER : ���ڸ� ���ڷ� ��ȯ. ������ �̿��� �ٽ� ���ڷ� ��ȯ�� �� �ִ�.
SELECT TO_NUMBER('15,000,000��', '99,999,999L') FROM dual;
