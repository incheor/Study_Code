-- 책 테이블과 구분 테이블을 조인하여 아래와 같은 정보가 나오도록 구현하세요. 
-- 똑같이 나와야 합니다!!
SELECT div.names 장르
     , book.names 책제목
     , book.author 저자
     , TO_CHAR(book.releasedate, 'yyyy-mm-dd') 출판일
     , book.isbn 책코드번호
     , TO_CHAR(book.price, '999,999,999')||'원' 가격
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 ORDER BY book.idx DESC;