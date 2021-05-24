/*
    # ORDER BY��
    - ���ϴ� �÷� �������� �����Ͽ� ��ȸ�� �� �ִ�
    - ORDER BY �÷��� [ASC | DESC]
    - ASC : ASCENDING, �������� (���� ����)
    - DESC : DESCENDING, ��������
*/

SELECT * FROM employees; -- �⺻�����δ� PK ������ ��ȸ�ȴ�

SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary;


/*
    �ش� �÷��� null�� ���ԵǾ� �ִ� ���
        ������������ ��ȸ�ϸ� ���� ���߿� �����ϰ� 
        ������������ ��ȸ�ϸ� ���� ���� �����Ѵ�
*/
SELECT * FROM employees ORDER BY commission_pct DESC;
SELECT * FROM employees ORDER BY commission_pct ASC;

-- ���� ���� ���� ������ ������ �� �ִ�
-- (���� ���޼����� �������� ���� ��, ������ ���ٸ� �������� ����)
SELECT * FROM employees ORDER BY job_id ASC, first_name DESC;

/*
    ����1 : ��� ������� �μ���ȣ ���� ������������ ��ȸ�غ�����
    ����2 : ��� ������� �ֱ� �Ի��� ������� ��ȸ�غ�����
    ����3 : �̸��� i�� ���ԵǾ� �ִ� ������� ���� ���� ���� �޴� ������� ��ȸ�غ�����
    ����4 : 80�� �μ��� 50�� �μ��� ������� �μ���ȣ ���� ������������ �����ϰ�
              �μ���ȣ�� ���ٸ� ���� �̸� �������� ���ĺ� ������ ��ȸ���ּ���
*/

SELECT * FROM employees ORDER BY department_id;

SELECT * FROM employees ORDER BY hire_date DESC;

SELECT * FROM employees WHERE first_name LIKE '%i%' ORDER BY salary * (1 + NVL(commission_pct, 0)) DESC;

SELECT * FROM employees WHERE department_id IN (80, 50);
SELECT * FROM employees WHERE department_id = 50 OR department_id = 80 ORDER BY department_id, last_name;