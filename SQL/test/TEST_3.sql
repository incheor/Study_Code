-- å ���̺�� ���� ���̺��� �����Ͽ� �Ʒ��� ���� ������ �������� �����ϼ���. 
-- �Ȱ��� ���;� �մϴ�!!
SELECT div.names �帣
     , book.names å����
     , book.author ����
     , TO_CHAR(book.releasedate, 'yyyy-mm-dd') ������
     , book.isbn å�ڵ��ȣ
     , TO_CHAR(book.price, '999,999,999')||'��' ����
  FROM bookstbl book, divtbl div
 WHERE book.division = div.division
 ORDER BY book.idx DESC;