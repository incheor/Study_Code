-- 이건 주석, 아래의 select 구문을 실행, *은 ALL(전부)라는 의미
SELECT *FROM emp;

-- 컬럼을 구분해서 select
SELECT ename, job, hiredate
 FROM emp;
 
-- 부서명만 출력, 중복값은 제거(DISTINCT), 두 칼럼이 모두 같아야 제거된다
SELECT DISTINCT deptno 
 FROM emp;

-- DISTINCT에 컬럼이 2개 이상인 경우: 하나의 레코드로 인식해서 중복값을 제거한다
SELECT DISTINCT empno, deptno
 FROM emp; -- 이 경우는 empno + deptno로 인식: 중복 제거가 안 됨

SELECT DISTINCT job, deptno
 FROM emp; -- 이 경우는 job + deptno로 인식: 중복 제거 됨
 
-- 조건절(WHERE)
SELECT *FROM emp
 WHERE empno = 7499;

-- 문자 검색시에는 따옴표 넣기
SELECT *FROM emp
 WHERE ename = '홍길동';
 
SELECT *FROM emp
 WHERE job = 'CLERK';
 
-- 급여가 1500 초과인 사람
SELECT *FROM emp
 WHERE sal > 1500;