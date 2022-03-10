-- 대문자로(UPPER)
SELECT *FROM emp
 WHERE job = UPPER('analyst');
 
SELECT UPPER('analyst') FROM dual; -- dual은 가상 테이블을 만들어서 보여줄 때 사용하면 편하다

-- 소문자로(LOWER)
SELECT LOWER(ename) AS ename,
        LOWER(job) AS job 
  FROM emp
 WHERE comm IS NOT NULL;
 
-- 첫글자만 대문자로(INITCAP)
SELECT INITCAP(ename) AS ename,
        INITCAP(job) AS job 
  FROM emp
 WHERE comm IS NOT NULL;
 
-- 문자열의 길이가 알고 싶을 때(LENGTH), 문자열의 크기가 알고 싶을 때(LENGTHB)
SELECT ename,
        LENGTH(ename) AS 문자열길이,
        LENGTHB(ename) AS 문자열바이트
 FROM emp;

-- 문자열 일부 추출(SUBSTR)
SELECT '안녕하세요, 개발자 공부를 시작했습니다.' AS string,
    SUBSTR('안녕하세요, 개발자 공부를 시작했습니다.',12, 3) AS substr FROM dual;

-- 문자열 대체(REPLACE)
SELECT '안녕하세요, 개발자 공부를 시작했습니다.' AS string,
    REPLACE('안녕하세요, 개발자 공부를 시작했습니다.','안녕하세요', '저리가세요') AS substr FROM dual;

-- 문자열 합치기(||, CONCAT)
SELECT 'A' || 'B' FROM dual;
SELECT  CONCAT('A', 'B') FROM dual;

-- 공백 지우기(TRIM,RTRIM, LTRIM)
SELECT '     안녕하세요.     ' FROM dual;
SELECT TRIM('     안녕하세요.     ') FROM dual;
SELECT TRIM('     안 녕 하 세 요.     ') FROM dual; -- 글자 사이에 있는 건 없어지지 않음

-- 반올림(ROUND), 내림(TRUNC)
SELECT ROUND(11.1) FROM dual;

-- 날짜와 시간(SYSDATE)
SELECT SYSDATE FROM dual;

-- 자료형 변환
-- TO_CHAR: 문자로
SELECT  ename, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$'
 FROM emp;

-- TO_NUMBER: 숫자로
SELECT  TO_NUMBER('2022')+ 100 FROM dual;
SELECT  TO_NUMBER('이천이십이')+ 100 FROM dual; -- 이건 안 된다, 숫자만 가능

-- TO_DATE: 날짜로
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

-- NULL 처리 함수(NVL)
SELECT ename, job, sal, NVL(comm, 0), sal*12 + NVL(comm, 0) AS annsal
 FROM emp
 ORDER BY sal DESC;
 
-- 집계함수 SUM, COUNT, MIN, MAX, AVG
SELECT  sal, NVL(comm, 0) FROM emp;
SELECT SUM(sal) tatalsal FROM emp;
SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal)) FROM emp;

-- 결과 값을 원하는 열로 묶어서 출력하기(GROUP BY) 그룹핑할 수 있어야 한다
-- SELECT절의 MAX, MIN 같은 함수 제외한 컬럼은 무조건 적어줘야함
SELECT MAX(sal) AS 급여최대, SUM(sal) AS 직업군당급여합계, job
  FROM emp
 GROUP BY job; -- 이게 가장 이상적인 거
 
SELECT MAX(sal) AS 급여최대, SUM(sal) AS 직업군당급여합계, job, deptno
  FROM emp
 GROUP BY job, deptno; -- SELECT절과 GROUP BY절에 하나만 추가했는데 위랑 결과가 다르다
 
-- GROUP BY절에 조건 추가하기(HAVING), 이 때 조건은 MAX같은 그룹함수를 써야 한다
-- WHERE는 SELECT, FROM에 조건을 걸며 그룹함수는 못 쓴다
SELECT MAX(sal) AS 급여최대, SUM(sal) AS 직업군당급여합계, job
  FROM emp
 WHERE sal > 1000
 GROUP BY job
  HAVING MAX(sal) >= 2000;
 
SELECT deptno, job, AVG(sal), MAX(sal), MIN(sal), SUM(sal), COUNT(*)
  FROM emp
 GROUP BY deptno, job
  HAVING AVG(sal) >= 1000
 ORDER BY deptno, job;
 
-- GROUP BY절에 ROLLUP 함수 추가: SELECT절에 있는 컬럼마다의 결과 내준다, 기준이 되는 컬럼은 그룹함수를 제외한 컬럼
SELECT deptno,
        NVL(job, '합계') AS job, 
        ROUND(AVG(sal), 1) AS 급여평균, 
        MAX(sal) AS 급여최대, 
        SUM(sal) AS 급여합계, 
        COUNT(*) AS 직원수
  FROM emp
 GROUP BY ROLLUP(deptno, job);