-- Having
-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü��
-- ���, �հ�, �ְ�, ������, �ڷ���� ��ȸ
Select prod_lgu as ��ǰ�з�,
       Round(Avg(prod_sale), 2) as ��հ���,
       Sum(prod_sale) as �հ�,
       Max(prod_sale) as �ְ�,
       Min(prod_sale) as ������,
       Count(prod_sale) as �ڷ��
  From prod
 Group By prod_lgu
 Order By prod_lgu Asc;
  
-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ� ��ü��
-- ���, �հ�, �ְ�, ������, �ڷ���� ��ȸ
-- ���� : �ڷ���� 20�� �̻��� ��
Select prod_lgu as ��ǰ�з�,
       Round(Avg(prod_sale), 2) as ��հ���,
       Sum(prod_sale) as �հ�,
       Max(prod_sale) as �ְ�,
       Min(prod_sale) as ������,
       Count(prod_sale) as �ڷ��
  From prod
 Group By prod_lgu
 Having Count(prod_sale) >= 20
 Order By prod_lgu Asc;
 
-- ȸ�����̺��� ����(�ּ�1�� 2�ڸ�), ������Ϻ�
-- ���ϸ��� ���, �հ�, �ְ�, ����, �ڷ�� ��ȸ
-- �÷��� ����, ��, ���, �հ�, �ְ�, ����, �ڷ��
Select Substr(mem_add1, 1, 2) as ����,
       Substr(mem_bir, 1, 2) as ��,
       Avg(mem_mileage) as ���,
       Sum(mem_mileage) as �հ�,
       Max(mem_mileage) as �ְ�,
       Min(mem_mileage) as ����,
       Count(mem_mileage) as ��
  From member
 Group By Substr(mem_add1, 1, 2), Substr(mem_bir, 1, 2)
 Order By Substr(mem_add1, 1, 2), Substr(mem_bir, 1, 2) Asc;