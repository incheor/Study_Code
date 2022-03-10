-- ��ǰ ���̺� �� �ǸŰ��� 150000��, 170000��, 330000���� ��ǰ ��ȸ
Select prod_id, prod_name, prod_sale
  From prod
 Where prod_sale in (150000, 170000, 330000);
 
-- ��ǰ ���̺� �� �ǸŰ��� 150000��, 170000��, 330000���� �ƴ� ��ǰ ��ȸ
Select prod_id, prod_name, prod_sale
  From prod
 Where prod_sale Not In (150000, 170000, 330000);

-- In �ȿ� Select�� : ���� ������ - ���� �÷��� ���� �� ����
-- ��ǰ�з� ���̺��� ���� ��ǰ ���̺� �����ϴ� �з��� �˻�(�з��ڵ�, �з���)
Select lprod_gu as �з��ڵ�,
       lprod_nm as �з���
  From lprod
 Where lprod_gu In (
            Select prod_lgu 
              From prod);
 
-- ��ǰ�з� ���̺��� ���� ��ǰ ���̺� �������� �ʴ� �з��� �˻�
Select lprod_gu as �з��ڵ�,
       lprod_nm as �з���
  From lprod
 Where lprod_gu Not In (
                Select prod_lgu 
                  From prod);
 
-- �� ���� ������ ���� ���� ȸ�� ���̵�, �̸� ��ȸ
Select mem_id as ���̵�,
       mem_name as �̸�
  From member
 Where mem_id Not In (
              Select cart_member 
                From cart);
                
-- �� ���� �Ǹŵ� ���� ���� ��ǰ�� �̸� ��ȸ
Select prod_name as ��ǰ��
  From prod
 Where prod_id Not In (
               Select cart_prod
                 From cart);
                 
-- ȸ�� �� ������ ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ�� ��ȸ
Select prod_name as ��ǰ��
  From prod
 Where prod_id In (
           Select cart_prod
             From cart
            Where cart_member In (
                          Select mem_id
                            From member
                           Where mem_name = '������'));

-- ��ǰ �� �ǸŰ����� 10���� �̻�, 30���� ���ϴ� ��ǰ ��ȸ
-- ��ȸ�� �÷��� ��ǰ��, �ǸŰ���
-- ������ �ǸŰ����� �������� ��������
Select prod_name as ��ǰ��,
       prod_sale as �ǸŰ�
  From prod
 Where prod_sale >= 100000
   And prod_sale <= 300000
 Order By prod_sale Desc;
 
-- Between A And B : A �̻� B ���Ͽ����� ����(�ʰ�, �̸������� �� ��)
-- ȸ�� �� ������ 1975-01-01���� 1976-12-31 ���̿� �¾ ȸ���� ��ȸ
Select mem_id as ȸ��ID,
       mem_name as ȸ���̸�,
       mem_bir as ȸ������
  From member
 Where mem_bir Between '1975/01/01' And '1976/12/31';
 
-- �ŷ�ó ����� ������ ���� ����ϴ� ��ǰ�� ������ ȸ���� ��ȸ
-- �÷��� ȸ�� ���̵�, ȸ�� �̸�
-- prod ���̺��� buyer ���̺�� �ٷ� �����ϸ� 0�� ����
-- prod ���̺��� lprod ���̺��� ���� buyer ���̺�� �����ϸ� 11�� ����
-- ���� �� DB�� �����Ͱ� ��Ȯ�ϴٸ� ���� ���;� ��, ������ �� DB�� �ٸ��� ���Ա� ������ ��Ȯ���� ����
Select mem_id as ȸ�����̵�,
       mem_name as ȸ���̸�
  From member
 Where mem_id In (
          Select cart_member
            From cart
           Where cart_prod In (
                       Select prod_id
                         From prod
                        Where prod_lgu In (
                                     Select lprod_gu
                                       From lprod
                                      Where lprod_gu In (
                                                 Select buyer_lgu
                                                   From buyer
                                                  Where buyer_charger = '������'))));
                                                  
-- ��ǰ �� ���԰��� 300000 ~ 1500000�̰�
-- �ǸŰ��� 800000 ~ 2000000�� ��ǰ�� ��ȸ
-- �÷��� ��ǰ��, ���԰�, �ǸŰ�
Select prod_name as ��ǰ��,
       prod_cost as ���԰�,
       prod_sale as �ǸŰ�
  From prod
 Where prod_cost Between 300000 And 1500000
   And prod_sale Between 800000 And 2000000;
   
-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� ��ȸ
-- �÷��� ȸ�� ID, ȸ�� �̸�, ����
Select mem_id as ȸ��ID,
       mem_name as ȸ���̸�,
       mem_bir as ����
  From member
 Where mem_bir Not Between '1975/01/01' And '1975/12/31';
 
-- Like ������
-- ȸ�� ���̺��� �达 ���� ȸ���� ��ȸ
-- �÷��� ȸ�� ID, ȸ�� �̸�
Select mem_id as ȸ��ID,
       mem_name as ȸ���̸�
  From member
 Where mem_name Like '��%';
 
-- ȸ�����̺��� �ֹι�ȣ ���ڸ��� �˻���
-- 1975����� ������ ȸ���� ��ȸ
-- �÷��� ȸ��ID, ȸ���̸�, �ֹι�ȣ
Select mem_id as ȸ��ID,
       mem_name as ȸ���̸�,
       mem_regno1 as �ֹι�ȣ
  From member
 Where mem_regno1 Not Like '75%';