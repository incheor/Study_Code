-- �Ʒ��� ���� å�� ���к��� �հ�� ��� å�� �հ谡 ���� �������� �����ϼ���. 
-- ��...��... (ROLLUP)
SELECT NVL(div.names, '--�հ�--') �帣
     , SUM(book.price) �帣���հ�ݾ�
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 GROUP BY ROLLUP(div.names);