-- 아래와 같이 책의 구분별로 합계와 모든 책의 합계가 같이 나오도록 구현하세요. 
-- 롤...어... (ROLLUP)
SELECT NVL(div.names, '--합계--') 장르
     , SUM(book.price) 장르별합계금액
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 GROUP BY ROLLUP(div.names);