-- ����� ���� ����
CREATE USER busan IDENTIFIED BY dbdb;

-- ��й�ȣ ����
ALTER USER busan IDENTIFIED BY dbdb;

-- ���� ����
Drop USER busan;

-- ���� �ο��ϱ�(���� ����, ������ ����)
GRANT CONNECT, RESOURCE, DBA TO busan;

-- ���� ȸ���ϱ�
REVOKE DBA FROM busan;
