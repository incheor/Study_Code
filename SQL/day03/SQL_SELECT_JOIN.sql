-- 일반적인 조인(INNER JOIN == JOIN)
-- JOIN에는 합쳐서 보려는 부모테이블명, ON에는 자식테이블의 컬럼명(키) = 부모테이블의 컬럼명(키)
-- 아래는 ANSI INNER JOIN(표준)
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e
 INNER JOIN dept d
    ON e.deptno = d.deptno
 WHERE e.job = 'SALESMAN';

-- 아래는 PL/SQL INNER JOIN(오라클용)
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e, dept d
 WHERE 1=1 -- TIP
   AND e.deptno = d.deptno
   AND e.job = 'SALESMAN';
 
-- OUTER JOIN(외부조인): 조인 조건의 NULL값도 출력해준다
-- LEFT OUTER JOIN: 왼쪽 테이블을 기준으로 조회
-- 밑의 예시에서는 ON의 조건인 emp테이블의 deptno를 기준으로 dept테이블의 deptno를 조회하고 13줄이 출력됨
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e
  LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno;
    
-- RIGHT OUTER JOIN: 오른쪽 테이블을 기준으로 조회
-- 밑의 예시에서는 ON의 조건인 dept테이블의 deptno를 기준으로 emp테이블의 deptno를 조회하고 14줄이 출력됨
-- dept테이블에는 40이 있지만 emp테이블에는 40이 없기 때문에 NULL도 출력됨
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e
  RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno;
    
-- PL/SQL 에서만 적용되는 OUTER JOIN
-- PL/SQL 에서만 적용되는 LEFT OUTER JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e, dept d
 WHERE e.deptno = d.deptno(+);

-- PL/SQL 에서만 적용되는 RIGHT OUTER JOIN 
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e, dept d
 WHERE e.deptno(+) = d.deptno;
   
-- 3개의 테이블 조인
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
     , NVL(b.comm, 0)
  FROM emp e, dept d, bonus b
 WHERE e.deptno(+) = d.deptno
   AND e.ename = b.ename(+);