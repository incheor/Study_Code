-- INSERT, UPDATE, DELETE�� �ؿ� �� ����� �Է�, ����, ������ �ȴ�
COMMIT; -- ���� ����
ROLLBACK; -- ���

-- ������ �ֱ�: INSERT INTO + VALUES
-- INSERT INTO�� VALUES�� �÷��� �÷� ������ ���ƾ� ��
-- �� ���̺� �ȿ��� PK�� �ߺ��� �ż��� �� �ȴ�
INSERT INTO test
     ( idx, title, descs)
VALUES
     ( 1, '��������', NULL);
    
INSERT INTO test
     ( idx, title, descs)
VALUES
     ( 1, '��������2', NULL); -- �̰� �� ��, ���� ���ÿ��� PK�� idx�� 1�� �� �ֱ� ����
     
INSERT INTO test
     ( idx, title, descs)
VALUES
     ( 2, '��������2', '���볻�볻��');
     
-- TEST ���̺� ������ Ŭ��, ���� Ŭ��, �÷� �߰�(REGDATE)
-- �� �÷��� NOT NULL�̶� �ݵ�� ���� �־���� INSERT ����
INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( 3, '��������3', '���볻�볻��', SYSDATE); -- ���� ��¥ ���� ���� SYSDATE�� �� ���� ����
     
INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( 4, '��������4', '���볻�볻��', TO_DATE('2021-01-13','yyyy-mm-dd'));
     
-- ������ ����� ����(���� ����� ���ƾ� ��), ��ũ�� ������
SELECT SEQ_TEST.CURRVAL FROM dual; -- ���� ���� �����ش�
SELECT SEQ_TEST.NEXTVAL FROM dual; -- �������� ������� �ش�(���⼭�� ���� ������ 1����)

--������ �����غ���
INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( SEQ_TEST.NEXTVAL, '��������5', '���볻�볻��', SYSDATE);

INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( SEQ_STR.NEXTVAL, '���������', '���볻�볻��', SYSDATE);
     
-- ������ ����: UPDATE + SET
-- �Ϻκи� �����ϱ�: UPDATE + SET + WHERE(WHERE ���� ������ ���� ������, ū�ϳ���)
-- PK ���� �����ϸ� �������� ����
UPDATE test
   SET title = '���� ����?'
     , descs = '������ ����˴ϴ�.'
 WHERE idx = 100;
 
-- ������ ����: DELETE
DELETE FROM test
 WHERE idx = 200;
