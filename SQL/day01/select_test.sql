-- �̰� �ּ�, �Ʒ��� select ������ ����, *�� ALL(����)��� �ǹ�
SELECT *FROM emp;

-- �÷��� �����ؼ� select
SELECT ename, job, hiredate
 FROM emp;
 
-- �μ��� ���, �ߺ����� ����(DISTINCT), �� Į���� ��� ���ƾ� ���ŵȴ�
SELECT DISTINCT deptno 
 FROM emp;

-- DISTINCT�� �÷��� 2�� �̻��� ���: �ϳ��� ���ڵ�� �ν��ؼ� �ߺ����� �����Ѵ�
SELECT DISTINCT empno, deptno
 FROM emp; -- �� ���� empno + deptno�� �ν�: �ߺ� ���Ű� �� ��

SELECT DISTINCT job, deptno
 FROM emp; -- �� ���� job + deptno�� �ν�: �ߺ� ���� ��
 
-- ������(WHERE)
SELECT *FROM emp
 WHERE empno = 7499;

-- ���� �˻��ÿ��� ����ǥ �ֱ�
SELECT *FROM emp
 WHERE ename = 'ȫ�浿';
 
SELECT *FROM emp
 WHERE job = 'CLERK';
 
-- �޿��� 1500 �ʰ��� ���
SELECT *FROM emp
 WHERE sal > 1500;