-- å ���̺��� å����, ����, ������, �ݾ� ������ ����ϰ� 
-- ������ ��� ������ ������ �Ͻʽÿ�. �÷��̸��� Ȯ���ϼ���!!
SELECT book.names AS å����
     , book.author AS ���ڸ�
     , TO_CHAR(book.releasedate,'yyyy-mm-dd') AS ������
     , book.price AS ����
  FROM bookstbl book
 ORDER BY book.idx ASC;