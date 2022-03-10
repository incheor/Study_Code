-- Decode : if�� ���� ��
-- Decode�� ��ȣ �ȿ��� ���� ���ʿ� �ִ� ���� �������� �񱳸� �ϴµ� 
-- ���������� 2���� �� ��Ʈ��
-- ���� ���ʿ� �ִ� �Ͱ� ��Ʈ�� ���� �Ŷ� ���ϸ鼭 ������ ��Ʈ�� ������ ���� ��ȯ���ְ�
-- �ƴϸ� ���� ������ 2�� �������� �Ѿ�� �� �ƴϸ� ���� ������ �ִ� ���� ��ȯ
Select Decode(9, 10, 'A', 9, 'B', 8, 'C', 'D')
  From dual;

Select Decode(substr(prod_lgu, 1, 2), 
             'P1', '��ǻ��/���� ��ǰ', 
             'P2', '�Ƿ�', 
             'P3', '��ȭ', '��Ÿ')
  From prod;
  
-- ��ǰ �з� �� ���� �� ���ڰ� 'P1'�̸� �ǸŰ��� 10% �λ��ϰ�
-- 'P2'�̸� �ǸŰ��� 15% �λ��ϰ� �������� ���� �ǸŰ��� ��ȸ
-- �÷��� ��ǰ��, �ǸŰ�, �����ǸŰ�
Select prod_name as ��ǰ��,
       prod_sale as �ǸŰ�,
       Decode(substr(prod_lgu, 1, 2),
             'P1', prod_sale * 1.1, 
             'P2', prod_sale * 1.15, prod_sale * 1.1) as �����ǸŰ�
  From prod;
  
-- Case A When B Then C When D Then E Else F End : Switch�� ���� ��
-- A�� B�� ���ؼ� ������ C�� ����ϰ� �ƴϸ� 
-- D�� ���ؼ� ������ E�� ����ϰ� 
-- �� �ƴϸ� E�� ����ϰ� ����
-- ȸ���������̺��� �ֹι�ȣ ���ڸ����� ������ ��ȸ
-- �÷��� ȸ����, �ֹι�ȣ(13�ڸ�), ����
Select mem_name as ȸ����,
       mem_regno1 || '-' || mem_regno2 as �ֹι�ȣ,
       Case substr(mem_regno2, 1, 1) When '1' Then '��'
                                     When '2' Then '��' End as ����
  From member;