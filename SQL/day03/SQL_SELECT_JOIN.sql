-- �Ϲ����� ����(INNER JOIN == JOIN)
-- JOIN���� ���ļ� ������ �θ����̺��, ON���� �ڽ����̺��� �÷���(Ű) = �θ����̺��� �÷���(Ű)
-- �Ʒ��� ANSI INNER JOIN(ǥ��)
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

-- �Ʒ��� PL/SQL INNER JOIN(����Ŭ��)
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
 
-- OUTER JOIN(�ܺ�����): ���� ������ NULL���� ������ش�
-- LEFT OUTER JOIN: ���� ���̺��� �������� ��ȸ
-- ���� ���ÿ����� ON�� ������ emp���̺��� deptno�� �������� dept���̺��� deptno�� ��ȸ�ϰ� 13���� ��µ�
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
    
-- RIGHT OUTER JOIN: ������ ���̺��� �������� ��ȸ
-- ���� ���ÿ����� ON�� ������ dept���̺��� deptno�� �������� emp���̺��� deptno�� ��ȸ�ϰ� 14���� ��µ�
-- dept���̺��� 40�� ������ emp���̺��� 40�� ���� ������ NULL�� ��µ�
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
    
-- PL/SQL ������ ����Ǵ� OUTER JOIN
-- PL/SQL ������ ����Ǵ� LEFT OUTER JOIN
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e, dept d
 WHERE e.deptno = d.deptno(+);

-- PL/SQL ������ ����Ǵ� RIGHT OUTER JOIN 
SELECT e.empno
     , e.ename
     , e.job
     , TO_CHAR(e.hiredate,'yyyy-mm-dd') AS hiredate
     , e.deptno
     , d.dname
     , d.loc
  FROM emp e, dept d
 WHERE e.deptno(+) = d.deptno;
   
-- 3���� ���̺� ����
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