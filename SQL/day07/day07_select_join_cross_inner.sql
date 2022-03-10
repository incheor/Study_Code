-- ����

-- ��Ǯ��(���� X)
-- ȸ������ �� ���ų����� �ִ� ȸ���� ����
-- ȸ�����̵�, ȸ���̸�, ����(0000-00-00 ����)�� ��ȸ
-- ������ ������ �������� ��������
Select mem_id as ȸ�����̵�,
       mem_name as ȸ���̸�,
       To_char(mem_bir, 'yyyy-mm-dd') as ����
  From member
 Where mem_id In (
          Select cart_member
            From cart
           Where cart_no Is Not NULL)
 Order By mem_bir Asc;
 
-- 1���� ���̺� ��ȸ : In, Exists
-- In
Select prod_id, prod_name, prod_lgu
  From prod
 Where prod_lgu In (
            Select lprod_gu
              From lprod
             Where lprod_nm = '������ȭ');

-- Exists     
Select prod_id, prod_name, prod_lgu
  From prod
 Where Exists (
       Select lprod_gu
         From lprod
        Where lprod_gu = prod.prod_lgu
          And lprod_gu = 'P301');
          
-- ����
-- Cross Join
-- �Ϲ� ���
Select m.mem_id, c.cart_member
  From member m, cart c, prod p;
  
-- ����ǥ�ع��
Select mem_id, cart_member
  From member 
   Cross Join cart 
   Cross Join prod;

-- Inner Join : �Ϲ����� Join
-- �Ϲ� ���
Select prod.prod_id ��ǰ�ڵ�,
       prod.prod_name ��ǰ��,
       lprod.lprod_nm �з���
  From prod, lprod
 Where prod.prod_lgu = lprod.lprod_gu;
 
-- ���� ǥ�� ���
Select prod.prod_id ��ǰ�ڵ�,
       prod.prod_name ��ǰ��,
       lprod.lprod_nm �з���
  From prod Inner Join lprod
    On prod.prod_lgu = lprod.lprod_gu;

-- ���̺� 3�� �̻��� ���
-- �Ϲ� ���
Select P.prod_id,
       P.prod_name,
       L.lprod_nm,
       B.buyer_name
  From prod P, lprod L, buyer B
 Where p.prod_lgu = l.lprod_gu
   And p.prod_buyer = b.buyer_id;

-- ���� ǥ�� ���
Select P.prod_id,
       P.prod_name,
       L.lprod_nm,
       B.buyer_name
  From prod P
 Inner Join lprod L
    On P.prod_lgu = L.lprod_gu
 Inner Join buyer B
    On P.prod_buyer = B.buyer_id;

-- ȸ���� ������ �ŷ�ó ������ ��ȸ
-- �÷��� ȸ�����̵�, ȸ���̸�, ��ǰ�ŷ�ó��, ��ǰ�з���
-- �Ϲ� ���
Select Distinct M.mem_id as ȸ�����̵�,
       M.mem_name as ȸ���̸�,
       B.buyer_name as ��ǰ�ŷ�ó��,
       L.lprod_nm as ��ǰ�з���
  From member M, cart C, prod P, lprod L, buyer B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_lgu = L.lprod_gu
   And L.lprod_gu = B.buyer_lgu
 Order By M.mem_name Asc;
   
-- ���� ǥ�� ���
Select Distinct M.mem_id as ȸ�����̵�,
       M.mem_name as ȸ���̸�,
       B.buyer_name as ��ǰ�ŷ�ó��,
       L.lprod_nm as ��ǰ�з���
  From member M
 Inner Join cart C
    On M.mem_id = C.cart_member
 Inner Join prod P
    On C.cart_prod = P.prod_id
 Inner Join lprod L
    On P.prod_lgu = L.lprod_gu
 Inner Join buyer B
    On L.lprod_gu = B.buyer_lgu
 Order By M.mem_name Asc;

Select Distinct M.mem_id as ȸ�����̵�,
       M.mem_name as ȸ���̸�,
       B.buyer_name as ��ǰ�ŷ�ó��,
       L.lprod_nm as ��ǰ�з���,
       Round(Sum(P.prod_price))
  From member M, cart C, prod P, lprod L, buyer B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_lgu = L.lprod_gu
   And L.lprod_gu = B.buyer_lgu
   And substr(M.mem_name, 1, 1) = '��'
 Group By M.mem_id, M.mem_name, B.buyer_name, L.lprod_nm
Having Sum(P.prod_price) >= 100000
 Order By M.mem_name Asc;
 
-- �ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
-- ��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ
-- �Ϲ� ���
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       B.buyer_name as buyer_name
  From buyer B, prod P
 Where B.buyer_id = P.prod_buyer
   And B.buyer_name = '�Ｚ����';
   
-- ���� ǥ�� ���
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       B.buyer_name as buyer_name
  From buyer B
 Inner Join prod P
    On B.buyer_id = P.prod_buyer
   And B.buyer_name = '�Ｚ����';
 
-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó�ּҸ� ��ȸ
-- �ǸŰ����� 100,000�� �����̰� �ŷ�ó�ּҰ� '�λ�'�� ��츸 ���
-- �Ϲ� ���
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       P.prod_lgu as prod_lgu,
       B.buyer_name as buyer_name,
       B.buyer_add1 as buyer_add1
  From prod P, buyer B
 Where P.prod_buyer = B.buyer_id
   And P.prod_sale <= 100000
   And substr(B.buyer_add1, 1, 2) = '�λ�';
   
-- ���� ǥ�� ���
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       P.prod_lgu as prod_lgu,
       B.buyer_name as buyer_name,
       B.buyer_add1 as buyer_add1
  From prod P
 Inner Join buyer B
    On P.prod_buyer = B.buyer_id
   And P.prod_sale <= 100000
   And substr(B.buyer_add1, 1, 2) = '�λ�';
   
-- ��ǰ�з��ڵ尡 P101�� �Ϳ� ����
-- ��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ����� ��ȸ
-- ������ ��ǰ�з����� �������� ��������, ��ǰ���̵� �������� ��������
-- �Ϲ� ���
Select L.lprod_nm,
       P.prod_id,
       P.prod_sale,
       B.buyer_charger,
       M.mem_id,
       C.cart_qty
  From prod P, buyer B, lprod L, cart C, member M
 Where P.prod_buyer = B.buyer_id
   And P.prod_lgu = L.lprod_gu
   And P.prod_id = C.cart_prod
   And C.cart_member = M.mem_id
   And L.lprod_gu = 'P101'
 Order BY L.lprod_nm Desc, 
       P.prod_id Asc;
       
-- ���� ǥ�� ���
Select L.lprod_nm,
       P.prod_id,
       P.prod_sale,
       B.buyer_charger,
       M.mem_id,
       C.cart_qty
  From prod P
 Inner Join buyer B
    ON P.prod_buyer = B.buyer_id
 Inner Join lprod L
    On P.prod_lgu = L.lprod_gu
 Inner Join cart C 
    On P.prod_id = C.cart_prod
 Inner Join member M
    On C.cart_member = M.mem_id
   And P.prod_lgu = 'P101' 
 Order BY L.lprod_nm Desc, 
       P.prod_id Asc;