-- 서브쿼리(Subquery): SELECT 문에만 사용 가능
SELECT ROWNUM, su.ename, su.job, su.sal, su.comm FROM (
SELECT ename, job, sal, comm FROM emp
 ORDER BY sal DESC
 ) su
 WHERE ROWNUM = 1;