-- ����

-- ��Ǯ��(���� X)
-- ��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
-- ��ǰ�з��ڵ尡 'P0101', 'P201', 'P301'
-- ���Լ����� 15�� �̻�
-- '����'�� ����ִ� ȸ�� �� ��������� 1974���� ȸ��
-- ������ ȸ�����̵� �������� ��������, ���Լ����� �������� ��������

-- �Ϲ� ���
Select P.prod_lgu,
       P.prod_name,
       p.prod_color,
       B.buy_qty,
       C.cart_qty,
       Y.buyer_name
  From prod P, buyprod B, cart C, member M, buyer Y
 Where P.prod_id = B.buy_prod
   And P.prod_id = C.cart_prod
   And C.cart_member = M.mem_id
   And P.prod_buyer = Y.buyer_id
   And substr(P.prod_lgu, 1, 4) In ('P101', 'P201', 'P301')
   And B.buy_qty >= 15
   And M.mem_add1 Like '%����%'
   And Extract(year from M.mem_bir) = 1974
 Order By M.mem_id Desc,  B.buy_qty Desc;
 
-- ���� ǥ�� ���
Select P.prod_lgu,
       P.prod_name,
       p.prod_color,
       B.buy_qty,
       C.cart_qty,
       Y.buyer_name
  From prod P
 Inner Join buyprod B
    On P.prod_id = B.buy_prod
 Inner Join cart C
    On P.prod_id = C.cart_prod
 Inner Join member M
    On C.cart_member = M.mem_id
 Inner Join buyer Y
    On P.prod_buyer = Y.buyer_id
 Where substr(P.prod_lgu, 1, 4) In ('P101', 'P201', 'P301')
   And B.buy_qty >= 15
   And M.mem_add1 Like '%����%'
   And Extract(year from M.mem_bir) = 1974
 Order By M.mem_id Desc,  B.buy_qty Desc;

-- 2005�⵵ ���� ���� ��Ȳ�� ��ȸ
-- �÷��� ���Կ�, ���Լ���, ���Աݾ�(���Լ���*��ǰ���̺��� ���԰�)
Select Extract(month from buy_date),
       sum(buy_qty),
       sum(buy_qty * prod_cost)
  From buyprod
  Inner Join prod
    On buy_prod = prod_id
 Group By Extract(month from buy_date)
 Order By Extract(month from buy_date) Asc;
 
-- 2005�⵵ ���� �Ǹ� ��Ȳ ��ȸ
-- �Ǹſ�, �Ǹż���, �Ǹűݾ�
Select substr(cart_no, 5, 2),
       Sum(cart_qty),
       Sum(cart_qty*prod_sale)
  From prod
 Inner Join cart
    On prod_id = cart_prod
 Group By substr(cart_no, 5, 2)
 Order By substr(cart_no, 5, 2) Asc;
 
-- Outer Join
-- Inner Join�� �� �� Join���ǽ��� ������Ű�� ���ϴ� ���� �˻����� ������ �Ǵµ�
-- �̷� �����Ǵ� ����� �˻��ǵ��� �ϴ� Join
-- Join���� ������ Table �ʿ� '+' ������ ��ȣ�� ���(����Ŭ ���)�ϰ�
-- NULL ���� �����Ͽ� ��ȸ�� �� ����
-- ���� �θ� �������� ��ȸ��
-- (�θ����̺��� �÷��� �׷�, �ڽ����̺� �ʿ� '+' ����)
-- �ʹ� ���� ����� ��� ó���ӵ��� ���ϵ�
-- �����ϸ� ���� ǥ�� ���(Left Outer Join ���̺�� On �������ǽ�)���� ����

-- ��ü �з��� ��ǰ�ڷ� ���� ��ȸ
-- 1. ��ü �з��� ��ȸ : 9��
Select * 
  From lprod;

-- 2. Inner Join : 6��
Select lprod_gu,
       lprod_nm,
       Count(prod_lgu)
  From lprod, prod
 Where lprod_gu = prod_lgu
 Group By lprod_gu, lprod_nm;
 
-- 3. ����Ŭ Outer Join : 9��
Select lprod_gu,
       lprod_nm,
       Count(prod_lgu)
  From lprod, prod
 Where lprod_gu = prod_lgu(+)
 Group By lprod_gu, lprod_nm;
 
-- 4. ���� ǥ�� Outer Join : 9��
Select lprod_gu,
       lprod_nm,
       Count(prod_lgu)
  From lprod
  Left Outer Join prod
    On lprod_gu = prod_lgu
 Group By lprod_gu, lprod_nm;
 
-- ��ü ��ǰ�� 2005�� 01�� �԰������ ��ȸ
-- ��ǰ�ڵ�, ��ǰ��, �԰����
Select prod_id,
       prod_name,
       sum(NVL(buy_qty, 0)) as bq
  From prod
  Left Outer join buyprod
    On prod_id = buy_prod
   And  buy_date Between '05/01/01' And '05/01/31'
 Group By prod_id, prod_name
 Order By prod_id;

-- ���������� �ٲ㺸��
Select prod_id,
       prod_name,
       NVL((Select sum(buy_qty)
          From buyprod
         Where buy_prod = prod.prod_id
           And  buy_date Between '05/01/01' And '05/01/31'
         Group By buy_qty), 0) as bq
  From prod
 Group By prod_id, prod_name
 Order By prod_id;

-- ��ü ȸ���� 2005�⵵ 4���� ������Ȳ ��ȸ
-- �÷��� ȸ��ID, ����, ���ż����� ��
Select mem_id,
       mem_name,
       sum(NVL(cart_qty, 0)) as cq
  From member
  Left Outer Join cart
    On mem_id = cart_member
   And substr(cart_no, 1, 6) = '200504'
 Group By mem_id, mem_name
 Order By mem_id Asc;

-- ���������� �ٲ㺸��
Select mem_id,
       mem_name,
       NVL((Select sum(cart_qty)
              From cart
             Where cart_member = member.mem_id
               And substr(cart_no, 1, 6) = '200504'
             Group By cart_member), 0) as cq
  From member
 Group By mem_id, mem_name
 Order By mem_id Asc;

-- Having
-- ��ǰ�з��� ��ǻ����ǰ(P101)�� ��ǰ�� 2005�⵵ ���ں� �Ǹ� ��ȸ
-- �Ǹ���, �Ǹűݾ�(5,000,000�� �ʰ��� ��츸), �Ǹż���
Select substr(cart_no, 1, 8),
       sum(cart_qty*prod_sale),
       sum(cart_qty)
  From prod, cart
 Where prod_id = cart_prod
   And substr(cart_no, 1, 4) = '2005'
   And prod_lgu = 'P101'
 Group By substr(cart_no, 1, 8)
 Having sum(cart_qty*prod_sale) > 5000000
  Order By substr(cart_no, 1, 8);