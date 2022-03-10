-- �׷� �Լ� : Group By �ʼ�, Avg, Conut, Sum, Max
-- �Ϲ� �÷��� �׷� �Լ��� ���� ����� ��쿡��
-- �� Group By���� �־���� �ϸ�
-- Group By���� ��� �Ϲ� �÷��� �־���� ��
-- �ٷ� �Ʒ��� ���ÿ��� �Ϲ� �÷��� prod_lgu�̰�
-- �׷� �Լ��� Avg(prod_cost)��

-- Avg(coloumn) : ����� ����
-- ��ǰ ���̺��� ��ǰ�з��� ���԰��� ��հ�
Select prod_lgu as ��ǰ�з�,
       Round(Avg(prod_cost), 2) as ��ո��԰�
  From prod
 Group By prod_lgu;
 
-- Group By���� �ʿ���� ���
-- ��ǰ ���̺��� �ǸŰ��� ��� ���� ��ȸ
-- �÷��� ��ǰ�ǸŰ������
Select Round(Avg(prod_sale), 2) as ��ǰ�ǸŰ������
  From prod;

-- Group By���� �ʿ��� ���
-- ��ǰ ���̺��� ��ǰ�з��� �ǸŰ��� ��� ��ȸ
Select prod_lgu as ��ǰ�з�,
       Round(Avg(prod_sale), 2) as �ǸŰ������
  From prod
 Group By prod_lgu;
 
-- Count(column) : ���� ����
-- ��ٱ��� ���̺��� ȸ���� Count ����
Select cart_member as ȸ��ID,
 Count(cart_prod) as �ڷ��
  From cart
 Group By cart_member;
 
-- ���ż����� ��ü��� �̻��� ������ ȸ������
-- ���̵�� �̸��� ��ȸ
Select mem_id,
       mem_name
  From member
  Where mem_id In (
           Select cart_member
             From cart
            Where cart_qty >= (
            Select Avg(cart_qty)
              From cart))
 Order By mem_regno1 Asc;