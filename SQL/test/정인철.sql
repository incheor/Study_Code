-- 1��
SELECT LOWER(mem.email)
     , mem.mobile
     , mem.names
     , mem.addr
     , mem.levels 
  FROM membertbl mem
 ORDER BY mem.names DESC;
 
 
-- 2��
SELECT book.names AS å����
     , book.author AS ���ڸ�
     , TO_CHAR(book.releasedate,'yyyy-mm-dd') AS ������
     , book.price AS ����
  FROM bookstbl book
 ORDER BY book.idx ASC;
  

-- 3��
SELECT div.names �帣
     , book.names å����
     , book.author ����
     , TO_CHAR(book.releasedate, 'yyyy-mm-dd') ������
     , book.isbn å�ڵ��ȣ
     , TO_CHAR(book.price, '999,999,999')||'��' ����
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 ORDER BY book.idx DESC;
 

-- 4��
INSERT INTO membertbl( 
            idx, 
            names
            , levels
            , addr
            , mobile
            , email
            , userid
            , password
            , LASTLOGINDT
            , LOGINIPADDR
            )
VALUES (
       member_index.NEXTVAL
     , 'ȫ�浿'
     , 'A'
     , '�λ�� ���� �ʷ���'
     , '010-7989-0909'
     , 'HGD09@NAVER.COM'
     , 'HGD7989'
     , '12345'
     , NULL
     , NULL
     );
     
     
-- 5��
SELECT NVL(div.names, '--�հ�--') �帣
     , SUM(book.price) �帣���հ�ݾ�
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 GROUP BY ROLLUP(div.names);