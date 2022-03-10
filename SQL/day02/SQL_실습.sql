-- �� ������ ��ȸ�ϴ� selection
SELECT *FROM emp
 WHERE sal = 5000;
 
SELECT *FROM emp
 WHERE job = 'CLERK';

-- or�� ������, null ���� is�� ��� �Ѵ� 
-- in�� ���δ�
SELECT *FROM emp
 WHERE comm = 0 OR comm IS NULL;
 
SELECT ename, job, sal
 FROM emp
 WHERE sal = 800 OR sal = 1600 OR sal = 5000;
 
SELECT ename, job, sal
 FROM emp
 WHERE sal IN (800, 1600, 5000);

-- and�� ������, between a and b�� �� �� �ִ�
SELECT *FROM emp
 WHERE comm IS NULL AND job = 'ANALYST';
 
SELECT ename, job, sal
 FROM emp
 WHERE sal >= 1600 AND sal <= 2975;
 
SELECT ename, job, sal
 FROM emp
 WHERE sal BETWEEN 1600 AND 2975;
 
-- ��������
SELECT empno,ename,deptno
 FROM emp
 WHERE deptno = 30;
 
-- �� �� �̻��� ���̺��� ����Ͽ� ��ȸ�ϱ�(join)
-- join�� ������ ����
SELECT *FROM emp
 JOIN dept
  ON emp.deptno = dept.deptno;

-- ��Ī ALIAS, ��Ī�� �÷��� �Ӹ� �ƴ϶� ���̺���� �� �� �ִ�, ���̺�� ��Ī�� �� ���� as�� ����
-- ��Ī�� ���� where�������� �� ��(������������ ����� ��)
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp;
 
SELECT *FROM emp e
 JOIN dept d
  ON e.deptno = d.deptno;
 
-- ����(order by), ASC: �������� / DESC: ��������
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 ORDER BY sal DESC;

-- like
-- %: %�� �տ� ���̸� �����ϴ�, �ڿ� ���̸� ������, �߰��� ������ ���� �� ã�� 
-- _(�����): ��Ȯ�� ���� ���� �ش� ���ڸ� ã�� �� ���
SELECT ename, job, sal
 FROM emp
 WHERE ename LIKE 'J%';
 
SELECT ename, job, sal
 FROM emp
 WHERE ename LIKE '%R';
 
SELECT ename, job, sal
 FROM emp
 WHERE ename LIKE '%E%';
 
SELECT ename, job, sal
 FROM emp
 WHERE ename LIKE '__RD';
 
-- NULL, ���߿� �Լ��� NVL()���� NULL�� 0���� �����ϰ� ��������
SELECT ename, job, sal, comm
 FROM emp
 WHERE comm IS NOT NULL;

-- ����(union): �� �� �̻��� ���̺��� ��ȸ��
-- join�� �������� join�� ���� ���δ� / union�� �ؿ� ���̰� union�� ���� �ٸ� ���̺� ����
-- union�� ���� �÷����� ������ ��
-- union all: �ߺ��� ����ϴ� ������
-- minus: ������
-- intersect: ������
SELECT empno, ename,job FROM emp
 WHERE comm IS NOT NULL
UNION
SELECT deptno, dname, loc FROM dept;