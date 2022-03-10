-- 책 테이블에서 책제목, 저자, 출판일, 금액 순으로 출력하고 
-- 가격이 비싼 순으로 나오게 하십시오. 컬럼이름도 확인하세요!!
SELECT book.names AS 책제목
     , book.author AS 저자명
     , TO_CHAR(book.releasedate,'yyyy-mm-dd') AS 출판일
     , book.price AS 가격
  FROM bookstbl book
 ORDER BY book.idx ASC;