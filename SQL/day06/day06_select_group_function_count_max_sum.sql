-- ��ǰ�������� �ǸŰ����� ��հ��� ��ȸ
-- ��հ��� �Ҽ��� 2��° �ڸ����� ǥ��
Select Round(Avg(prod_sale), 2)
  From prod;
  
-- ��ǰ�������� ��ǰ�з��� �ǸŰ����� ��հ� ��ȸ
-- ��ȸ �÷��� ��ǰ�з��ڵ�, ��ǰ�з��� �ǸŰ��� ���
-- ��հ��� �Ҽ��� 2��°���� ǥ��
Select prod_lgu,
       Round(Avg(prod_sale), 2)
  From prod
 Group By prod_lgu
 Order BY prod_lgu Asc;

-- ȸ�� ��ü�� ���ϸ��� ��պ��� ū ȸ���� ����
-- ���̵�, �̸� ,���ϸ����� ��ȸ
-- ������ ���ϸ����� ���� ������
Select mem_id as ���̵�,
       mem_name as �̸�,
       mem_mileage as ���ϸ���
  From member
 Where mem_mileage > (Select AVG(mem_mileage) From member)
 Order By mem_mileage Desc;

-- Group By
-- Count(column) : ���� ����
-- ���ų��� �������� ȸ�� ���̵𺰷� ���ż��� ��ȸ
-- ȸ�� ���̵� �������� �������� ����
Select cart_member as ȸ��ID,
       Count(cart_qty) as ���ż���
  From cart
 Group By cart_member
 Order By cart_member Desc;
 
-- ȸ�����̺��� ������� ���� Count ����
Select Count(Distinct(mem_like)) as ���������
  From member;
  
-- ȸ�����̺��� ��̺� COunt ����
-- �÷��� ���, �ڷ��
Select mem_like as ���,
       Count(mem_like) as �ڷ��
  From member
 Group By mem_like;
 
-- ȸ�����̺��� �������� ���� Count ����
Select Count(Distinct(mem_job)) as ����������
  From member;

-- ȸ�����̺��� ������ Count ����
Select mem_job,
       Count(mem_job)
  From member
 Group By mem_job;
 
-- Max, Min : �ִ�, �ּ�
-- ������ 2005�� 07�� 11���̶�� ������� ��ٱ������̺� �߻��� �߰��ֹ���ȣ�� �˻�
-- �÷��� �������� ���� ����  ū �ֹ���ȣ, �����ֹ���ȣ
-- ���� �� ���
Select Max(cart_no) as ����ū�ֹ���ȣ,
       '20050711' || To_char((substr(Max(cart_no), 9, 13) + 1), '00000') as �����ֹ���ȣ
  From cart
 Where substr(cart_no, 1, 8) = '20050711';
-- ����
Select Max(cart_no) as ����ū�ֹ���ȣ,
       Max(cart_no) + 1 as �����ֹ���ȣ
  From cart
 Where cart_no like '20050711%';
 
-- ������������ �⵵��, ��ǰ�з��ڵ庰 ��ǰ�� ������ ��ȸ
-- ������ �⵵�� �������� ��������
-- hint : �⵵�� cart_no �� 4�ڸ�, ��ǰ�з��ڵ�� cart_prod �� 4�ڸ�
Select Substr(cart_no, 1, 4) as �⵵, 
       Substr(cart_prod, 1, 4) as ��ǰ�з��ڵ�,
       Count(*) as ��ǰ����
  From cart
 Group By Substr(cart_no, 1, 4), Substr(cart_prod, 1, 4)
 Order By �⵵;
 
-- sum : �հ�
-- ������������ �⵵���� �Ǹŵ� ��ǰ�� ����, ��ձ��ż����� ��ȸ
-- ������ �⵵�� �������� ��������
Select Substr(cart_no, 1, 4) as �Ǹų⵵,
       Sum(cart_qty) as �ǸŰ���,
       Avg(cart_qty) as  ��ձ��ż���
  From cart
 Group By Substr(cart_no, 1, 4)
 Order By �Ǹų⵵ Desc;