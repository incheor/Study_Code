-- ��������(Subquery): SELECT ������ ��� ����
SELECT ROWNUM, su.ename, su.job, su.sal, su.comm FROM (
SELECT ename, job, sal, comm FROM emp
 ORDER BY sal DESC
 ) su
 WHERE ROWNUM = 1;