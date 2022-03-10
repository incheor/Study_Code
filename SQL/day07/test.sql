-- 5��
/*
����ȣ, ���ο�, �ִ���
[����]
1. 
'����ĳ�־�'�̸鼭 ��ǰ �̸��� '����'�� ���� ��ǰ�̰�, 
���Լ����� 30���̻��̸鼭 6���� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ��ȸ�Ͻÿ�
Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���
*/
SELECT prod_name �̸�,
       prod_sale �ǸŰ���,
       prod_sale + NVL(prod_mileage, 0) "�ǸŰ���+���ϸ���"
  FROM prod
 WHERE prod_lgu IN(
            SELECT lprod_gu
              FROM lprod
             WHERE lprod_nm = '����ĳ�־�')
   AND prod_name like '%����%'
   AND prod_id IN (
           SELECT buy_prod
             FROM buyprod
            WHERE buy_qty >= 30
              AND EXTRACT(month FROM buy_date) = 6);

-- ����
Select P.prod_name as �̸�,
       P.prod_sale as �ǸŰ���,
       prod_sale + NVL(prod_mileage, 0) "�ǸŰ���+���ϸ���"
  From prod P, lprod L, buyprod B
 Where P.prod_lgu = L.lprod_gu
   And P.prod_id = B.buy_prod
   And L.lprod_nm = '����ĳ�־�'
   ANd P.prod_name Like '%����%'
   And B.buy_qty >= 30
   AND EXTRACT(month FROM buy_date) = 6;

/*
2. 
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/
Select mem_name as ȸ���̸�,
       mem_mileage as ���ϸ���,
       case when mem_mileage >= 2500 then '���ȸ��'
                                     else '�Ϲ�ȸ��'
                                     end as ȸ������
  From member
 Where mem_id In (
          Select cart_member
            From cart
           Where cart_prod In(
                     Select prod_id
                       From prod
                      Where prod_buyer In(
                                   Select buyer_id
                                     From buyer
                                    Where buyer_id Like '%P20%')
                       And prod_insdate >= '05/02/01'
                       And prod_cost >= 200000));
  
-- ����
Select Distinct mem_name as ȸ���̸�,
       mem_mileage as ���ϸ���,
       case when mem_mileage >= 2500 then '���ȸ��'
                                     else '�Ϲ�ȸ��'
                                     end as ȸ������
  From member M, cart C, prod P, buyer B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_buyer = B.buyer_id
   And B.buyer_id Like '%P20%'
   And Extract(month from P.prod_insdate) >= 2
   And P.prod_cost >= 200000;

/*
3. 
6���� ����(5���ޱ���)�� �԰�� ��ǰ �߿� 
���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� 
�Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
�达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
Alias �̸�, ���� ���ϸ���, ����
*/
Select mem_name as �̸�,
       mem_mileage as ���ϸ���,
       decode(substr(mem_regno2, 1, 1), 1, '��', '��') as ����
  From member
 Where mem_id In(
          Select cart_member
            From cart
           Where cart_prod In(
                       Select prod_id
                         From prod
                        Where prod_id In(
                                  Select buy_prod
                                    From buyprod
                                   Where Extract(month from buy_date) < 6)
                          And prod_delivery = '��Ź ����'
                          And prod_color is NULL)
             And cart_qty >= (Select Avg(cart_qty) From cart))
   And substr(mem_name, 1, 1) = '��';
   
-- ����
Select Distinct mem_name as �̸�,
       mem_mileage as ���ϸ���,
       decode(substr(mem_regno2, 1, 1), 1, '��', '��') as ����
  From member M, cart C, prod P, buyprod B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_id = B.buy_prod
   And Extract(month from B.buy_date) < 6
   And P.prod_delivery = '��Ź ����'
   And prod_color is NULL
   And cart_qty >= (Select Avg(cart_qty) From cart)
   And substr(mem_name, 1, 1) = '��';

/*
[���� �����]
��޻�ǰ�ڵ尡 'P1'�̰� '��õ'�� ��� ���� ������� ��ǰ�� ������ 
ȸ���� ��ȥ������� 8������ �ƴϸ鼭 
��ո��ϸ���(�Ҽ���°�ڸ�����) �̸��̸鼭 
�����Ͽ� ù��°�� ������ ȸ���� 
ȸ��ID, ȸ���̸�, ȸ�����ϸ����� �˻��Ͻÿ�.  
*/
SELECT mem_id,
       mem_name,
       round(avg(mem_mileage),2) 
FROM member
WHERE mem_id IN(
         SELECT cart_member  
           FROM cart
          WHERE cart_prod IN(
                      SELECT prod_id
                        FROM prod
                       WHERE prod_buyer IN(
                                    SELECT buyer_id
                                      FROM buyer
                                     Where buyer_add1 like '��õ%'
                                       AND buyer_lgu like 'P1%'))
                And substr(cart_no, 9, 13) = '1')
AND mem_memorial = '��ȥ�����'
AND extract(month from mem_memorialday) != 8   
AND mem_mileage < (SELECT avg(mem_mileage) FROM member) 
GROUP BY mem_id, mem_name;

/*
[���� �����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 12���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ���� 
*/
Select mem_id as ���̵�,
       mem_name as �̸�,
       mem_add1,
       mem_memorial,
       mem_memorialday
  From member
 Where mem_id In(
          Select cart_member
            From cart
           Where cart_prod Not In(
                       Select prod_id
                         From prod
                        Where prod_buyer In(
                                     Select buyer_id
                                       From buyer
                                      Where buyer_add1 LIke '%����%')))
   And mem_add1 Like '%����%'
   And substr(mem_regno2, 1, 1) = '2'
   And mem_memorial Like '%��ȥ�����%'
   And Extract(month from mem_memorialday) = 2
 Order By mem_name Asc;