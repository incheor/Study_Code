-- ȸ�� ���̺��� �̸���, �����, �̸�, �ּ�, ���� ���� ������ ����ϰ�, 
-- �̸��� ������������, �̸����� �ҹ��ڷ� ����ϼ���.
SELECT LOWER(mem.email)
     , mem.mobile
     , mem.names
     , mem.addr
     , mem.levels 
  FROM membertbl mem
 ORDER BY mem.names DESC;
