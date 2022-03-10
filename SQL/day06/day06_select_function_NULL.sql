-- NULL �� �� ������ �ٲٱ�
-- commit�� ���� ������!
-- �ŷ�ó ����� ���� '��'�̸� NULL�� ����
Update buyer Set buyer_charger = NULL
 Where buyer_charger Like '��%';
 

-- �ŷ�ó ����� ���� '��'�̸� White Space�� ����
Update buyer Set buyer_charger = ''
 Where buyer_charger Like '��%';

-- NULL ���� �Լ�
-- is NULL : NULL������ ��(True, False)
-- NVL(c, r) : c�� NULL�� �ƴϸ� c�� �״��, NULL�̸� r��ȯ
-- NVL2(c, r1, r2) :  c�� NULL�� �ƴϸ� r1, NULL�̸� r��ȯ
Select buyer_name as �ŷ�ó,
       NVL(buyer_charger, '����') as �����
  From buyer;
  
-- ȸ�� ���ϸ����� 100�� ���� ��ġ�� ��ȸ
-- �÷��� ����, ���ϸ���, ���渶�ϸ���
Select mem_name as ����,
       mem_mileage as ���ϸ���,
       NVL(mem_mileage, 0) + 100 as ���渶�ϸ���
  From member;
  
-- ȸ�� ���ϸ����� ������ '����ȸ��', NULL�̸� '������ȸ��'���� ��ȸ
-- �÷��� ����, ���ϸ���, ȸ������
Select mem_name as ����,
       mem_mileage as ���ϸ���,
       NVL2(mem_mileage, '����ȸ��', '������ȸ��') as ȸ������
  From member;