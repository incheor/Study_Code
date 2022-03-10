/*
���̺� ����
lprod : ��ǰ�з� ����
prod : ��ǰ����
buyer : �ŷ�ó ����
member : ȸ�� ����
cart : ����(��ٱ���) ����
buyprod : �԰� ��ǰ ����
remain : ��� ���� ����
*/
 
/*
���̺� ���� ����
remain : member, prod
prod : lprod, buyer
buyprod : prod
*/

-- Ư�� �÷� ��ȸ
-- 1. �ʿ��� ���̺� ã��
-- 2. �ʿ��� ���� ã��
-- 3. �ʿ��� �÷� ã��
-- ȸ�� ���̺��� ȸ�� ID�� ���� �˻�
Select mem_id, mem_name
  From member;

-- ��ǰ ���̺��� ��ǰ �ڵ�� ��ǰ�� �˻�
Select prod_id, prod_name
  From prod;
  
-- ��� ����ĵ� ����
-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
Select mem_mileage,
       mem_mileage / 12 as mem_12
  From member;
  
-- ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻�
-- �Ǹűݾ��� �ǸŴܰ� * 55�� ���
Select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       prod_sale * 55 as �Ǹűݾ�
  From prod;
  
-- �ߺ��� ������(��, row) ���� : distinct
-- ��ǰ ���̺��� �ŷ�ó �ڵ带 �ߺ����� �ʰ� �˻�
Select Distinct prod_buyer as �ŷ�ó
  From prod;
  
-- ���� : Order By : �������� ������ ���� Desc
-- �÷��� ��� Alias, �Ǵ� Select �� �÷����� �����ε� ����
-- Order By �� �������� �� ��� ù��° �������� ���� ����, ���� �������� ����
-- ȸ�� ���̺��� ȸ�� ID, ȸ����, ����, ���ϸ��� �˻�
Select mem_id as ȸ��_ID,
       mem_name as ȸ����,
       mem_bir as ����,
       mem_mileage as ���ϸ���
  From member
 Order by mem_id, ȸ����, 3 Asc;
 
-- Where : ����
-- �� ������
-- ��ǰ ���̺��� �ǸŰ��� 170000���� ��ǰ ��ȸ
Select prod_name as ��ǰ,
       prod_sale as �ǸŰ�
  From prod
 Where prod_sale = 170000;

-- ��ǰ ���̺��� �ǸŰ��� 170000���� �ƴ� ��ǰ ��ȸ
Select prod_name as ��ǰ,
       prod_sale as �ǸŰ�
  From prod
 Where prod_sale != 170000;

-- ��ǰ ���̺��� �ǸŰ��� 170000���� �ʰ��ϴ� ��ǰ ��ȸ
Select prod_name as ��ǰ,
       prod_sale as �ǸŰ�
  From prod
 Where prod_sale > 170000;

-- ��ǰ ���̺��� ���� ������ 200000�� ������ ��ǰ �˻�
-- ��ȸ �÷��� ��ǰ�ڵ�, ���԰���, ��ǰ��
-- ��ǰ�ڵ带 �������� ��������
Select prod_id as ��ǰ�ڵ�,
       prod_cost as ���԰���,
       prod_name as ��ǰ��
  From prod
 Where prod_cost <= 200000
 Order by prod_id Desc;
 
-- ȸ�� ���̺��� 76�⵵ 1�� 1�� ���Ŀ� �¾
-- ȸ�� ���̵�, ȸ�� �̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
-- ȸ�� ���̵� �������� ��������
Select mem_id as ȸ�����̵�,
       mem_name as ȸ���̸�,
       mem_regno1 as �ֹε�Ϲ�ȣ
  From member
 Where mem_regno1 >= 760101
 Order By mem_id;
 
-- �� ������
-- ��ǰ ���̺��� ��ǰ�з��� P201(���� ĳ���)�̰� �ǸŰ��� 170000���� ��ǰ ��ȸ
Select prod_name as ��ǰ��,
       prod_lgu as ��ǰ�з�,
       prod_sale as �ǸŰ�
  From prod
 Where prod_lgu = 'P201'
   And prod_sale = 170000;
   
-- ��ǰ ���̺��� ��ǰ�з��� P201(���� ĳ���)�� �ƴϰ� �ǸŰ��� 170000���� �ƴ� ��ǰ ��ȸ
Select prod_name as ��ǰ��,
       prod_lgu as ��ǰ�з�,
       prod_sale as �ǸŰ�
  From prod
 Where Not(prod_lgu = 'P201'
   And prod_sale = 170000);
   
-- ��ǰ ���̺��� �ǸŰ��� 300000�� �̻�, 500000�� �̻��� ��ǰ �˻�
Select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       prod_sale as �ǸŰ�
  From prod
 Where prod_sale >= 300000
   And prod_sale <= 500000;
   
-- ��ǰ ���̺��� �ǸŰ��� 15����, 17����, 33������ ��ǰ ��ȸ
-- �÷��� ��ǰ�ڵ�, ��ǰ��, �ǸŰ���
-- ������ ��ǰ���� �������� ��������
Select prod_id as ��ǰ�ڵ�,
       prod_name as ��ǰ��,
       prod_sale as �ǸŰ���
  From prod
 Where prod_sale = 150000
    Or prod_sale = 170000
    Or prod_sale = 330000;
    
-- ȸ�� ���̺��� ���̵� c001, f001, w001�� ȸ�� ��ȸ
-- �÷��� ȸ�� ���̵�, ȸ�� �̸�
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������
Select mem_id as ȸ�����̵�,
       mem_name as ȸ���̸�
  From member
 Where mem_id = 'c001'
    Or mem_id = 'f001'
    Or mem_id = 'w001'
 Order By mem_regno1 Desc;