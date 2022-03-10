-- 1번
SELECT LOWER(mem.email)
     , mem.mobile
     , mem.names
     , mem.addr
     , mem.levels 
  FROM membertbl mem
 ORDER BY mem.names DESC;
 
 
-- 2번
SELECT book.names AS 책제목
     , book.author AS 저자명
     , TO_CHAR(book.releasedate,'yyyy-mm-dd') AS 출판일
     , book.price AS 가격
  FROM bookstbl book
 ORDER BY book.idx ASC;
  

-- 3번
SELECT div.names 장르
     , book.names 책제목
     , book.author 저자
     , TO_CHAR(book.releasedate, 'yyyy-mm-dd') 출판일
     , book.isbn 책코드번호
     , TO_CHAR(book.price, '999,999,999')||'원' 가격
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 ORDER BY book.idx DESC;
 

-- 4번
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
     , '홍길동'
     , 'A'
     , '부산시 동구 초량동'
     , '010-7989-0909'
     , 'HGD09@NAVER.COM'
     , 'HGD7989'
     , '12345'
     , NULL
     , NULL
     );
     
     
-- 5번
SELECT NVL(div.names, '--합계--') 장르
     , SUM(book.price) 장르별합계금액
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 GROUP BY ROLLUP(div.names);