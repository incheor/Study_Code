-- �빮�ڷ�(UPPER)
SELECT *FROM emp
 WHERE job = UPPER('analyst');
 
SELECT UPPER('analyst') FROM dual; -- dual�� ���� ���̺��� ���� ������ �� ����ϸ� ���ϴ�

-- �ҹ��ڷ�(LOWER)
SELECT LOWER(ename) AS ename,
        LOWER(job) AS job 
  FROM emp
 WHERE comm IS NOT NULL;
 
-- ù���ڸ� �빮�ڷ�(INITCAP)
SELECT INITCAP(ename) AS ename,
        INITCAP(job) AS job 
  FROM emp
 WHERE comm IS NOT NULL;
 
-- ���ڿ��� ���̰� �˰� ���� ��(LENGTH), ���ڿ��� ũ�Ⱑ �˰� ���� ��(LENGTHB)
SELECT ename,
        LENGTH(ename) AS ���ڿ�����,
        LENGTHB(ename) AS ���ڿ�����Ʈ
 FROM emp;

-- ���ڿ� �Ϻ� ����(SUBSTR)
SELECT '�ȳ��ϼ���, ������ ���θ� �����߽��ϴ�.' AS string,
    SUBSTR('�ȳ��ϼ���, ������ ���θ� �����߽��ϴ�.',12, 3) AS substr FROM dual;

-- ���ڿ� ��ü(REPLACE)
SELECT '�ȳ��ϼ���, ������ ���θ� �����߽��ϴ�.' AS string,
    REPLACE('�ȳ��ϼ���, ������ ���θ� �����߽��ϴ�.','�ȳ��ϼ���', '����������') AS substr FROM dual;

-- ���ڿ� ��ġ��(||, CONCAT)
SELECT 'A' || 'B' FROM dual;
SELECT  CONCAT('A', 'B') FROM dual;

-- ���� �����(TRIM,RTRIM, LTRIM)
SELECT '     �ȳ��ϼ���.     ' FROM dual;
SELECT TRIM('     �ȳ��ϼ���.     ') FROM dual;
SELECT TRIM('     �� �� �� �� ��.     ') FROM dual; -- ���� ���̿� �ִ� �� �������� ����

-- �ݿø�(ROUND), ����(TRUNC)
SELECT ROUND(11.1) FROM dual;

-- ��¥�� �ð�(SYSDATE)
SELECT SYSDATE FROM dual;

-- �ڷ��� ��ȯ
-- TO_CHAR: ���ڷ�
SELECT  ename, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$'
 FROM emp;

-- TO_NUMBER: ���ڷ�
SELECT  TO_NUMBER('2022')+ 100 FROM dual;
SELECT  TO_NUMBER('��õ�̽���')+ 100 FROM dual; -- �̰� �� �ȴ�, ���ڸ� ����

-- TO_DATE: ��¥��
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

-- NULL ó�� �Լ�(NVL)
SELECT ename, job, sal, NVL(comm, 0), sal*12 + NVL(comm, 0) AS annsal
 FROM emp
 ORDER BY sal DESC;
 
-- �����Լ� SUM, COUNT, MIN, MAX, AVG
SELECT  sal, NVL(comm, 0) FROM emp;
SELECT SUM(sal) tatalsal FROM emp;
SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal)) FROM emp;

-- ��� ���� ���ϴ� ���� ��� ����ϱ�(GROUP BY) �׷����� �� �־�� �Ѵ�
-- SELECT���� MAX, MIN ���� �Լ� ������ �÷��� ������ ���������
SELECT MAX(sal) AS �޿��ִ�, SUM(sal) AS ��������޿��հ�, job
  FROM emp
 GROUP BY job; -- �̰� ���� �̻����� ��
 
SELECT MAX(sal) AS �޿��ִ�, SUM(sal) AS ��������޿��հ�, job, deptno
  FROM emp
 GROUP BY job, deptno; -- SELECT���� GROUP BY���� �ϳ��� �߰��ߴµ� ���� ����� �ٸ���
 
-- GROUP BY���� ���� �߰��ϱ�(HAVING), �� �� ������ MAX���� �׷��Լ��� ��� �Ѵ�
-- WHERE�� SELECT, FROM�� ������ �ɸ� �׷��Լ��� �� ����
SELECT MAX(sal) AS �޿��ִ�, SUM(sal) AS ��������޿��հ�, job
  FROM emp
 WHERE sal > 1000
 GROUP BY job
  HAVING MAX(sal) >= 2000;
 
SELECT deptno, job, AVG(sal), MAX(sal), MIN(sal), SUM(sal), COUNT(*)
  FROM emp
 GROUP BY deptno, job
  HAVING AVG(sal) >= 1000
 ORDER BY deptno, job;
 
-- GROUP BY���� ROLLUP �Լ� �߰�: SELECT���� �ִ� �÷������� ��� ���ش�, ������ �Ǵ� �÷��� �׷��Լ��� ������ �÷�
SELECT deptno,
        NVL(job, '�հ�') AS job, 
        ROUND(AVG(sal), 1) AS �޿����, 
        MAX(sal) AS �޿��ִ�, 
        SUM(sal) AS �޿��հ�, 
        COUNT(*) AS ������
  FROM emp
 GROUP BY ROLLUP(deptno, job);