-- 행 단위로 조회하는 selection
SELECT *FROM emp
 WHERE sal = 5000;
 
SELECT *FROM emp
 WHERE job = 'CLERK';

-- or는 교집합, null 값은 is를 써야 한다 
-- in도 쓰인다
SELECT *FROM emp
 WHERE comm = 0 OR comm IS NULL;
 
SELECT ename, job, sal
 FROM emp
 WHERE sal = 800 OR sal = 1600 OR sal = 5000;
 
SELECT ename, job, sal
 FROM emp
 WHERE sal IN (800, 1600, 5000);

-- and는 합집합, between a and b도 쓸 수 있다
SELECT *FROM emp
 WHERE comm IS NULL AND job = 'ANALYST';
 
SELECT ename, job, sal
 FROM emp
 WHERE sal >= 1600 AND sal <= 2975;
 
SELECT ename, job, sal
 FROM emp
 WHERE sal BETWEEN 1600 AND 2975;
 
-- 프로젝션
SELECT empno,ename,deptno
 FROM emp
 WHERE deptno = 30;
 
-- 두 개 이상의 테이블을 사용하여 조회하기(join)
-- join은 옆으로 붙임
SELECT *FROM emp
 JOIN dept
  ON emp.deptno = dept.deptno;

-- 별칭 ALIAS, 별칭은 컬럼명 뿐만 아니라 테이블명에도 쓸 수 있다, 테이블명에 별칭을 쓸 때는 as는 빼기
-- 별칭은 아직 where절에서는 못 씀(서브쿼리까지 배워야 함)
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp;
 
SELECT *FROM emp e
 JOIN dept d
  ON e.deptno = d.deptno;
 
-- 정렬(order by), ASC: 오름차순 / DESC: 내림차순
SELECT ename, job, sal, sal*12 AS annsal
 FROM emp
 ORDER BY sal DESC;

-- like
-- %: %가 앞에 붙이면 시작하는, 뒤에 붙이면 끝나는, 중간에 넣으면 들어가는 걸 찾음 
-- _(언더바): 정확한 글자 수에 해당 글자를 찾을 때 사용
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
 
-- NULL, 나중에 함수명 NVL()배우면 NULL을 0으로 간주하고 연산해줌
SELECT ename, job, sal, comm
 FROM emp
 WHERE comm IS NOT NULL;

-- 집합(union): 두 개 이상의 테이블을 조회함
-- join과 차이점은 join은 옆에 붙인다 / union은 밑에 붙이고 union은 서로 다른 테이블도 가능
-- union은 위의 컬럼명이 기준이 됨
-- union all: 중복을 허용하는 합집합
-- minus: 차집합
-- intersect: 교집합
SELECT empno, ename,job FROM emp
 WHERE comm IS NOT NULL
UNION
SELECT deptno, dname, loc FROM dept;