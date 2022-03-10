-- 3��
/*
1. ��ö�� �� ���� �� TV �� ���峪�� ��ȯ�������� �Ѵ�
��ȯ�������� �ŷ�ó ��ȭ��ȣ�� �̿��ؾ� �Ѵ�.
����ó�� ��ȭ��ȣ�� ��ȸ�Ͻÿ�.
*/
Select buyer_name,
       buyer_comtel
  From buyer
 Where buyer_id In (
            Select prod_buyer
              From prod
             Where prod_name Like '%TV%'
               And prod_id In (
                       Select cart_prod
                         From cart
                        Where cart_member In (
                                      Select mem_id
                                        From member
                                       Where mem_name = '��ö��')));

/*
2. ������ ��� 73�����Ŀ� �¾ �ֺε��� 2005��4���� ������ ��ǰ�� ��ȸ�ϰ�, 
�׻�ǰ�� �ŷ��ϴ� ���ŷ�ó�� ���� ������ ���¹�ȣ�� �����ÿ�.
(��, �����-���¹�ȣ).*/
Select buyer_bank || ' -- ' || buyer_bankno as "�����-���¹�ȣ"
  From buyer
 Where buyer_id In (
            Select prod_buyer
              From prod
             Where prod_id In (
                       Select cart_prod
                         From cart
                        Where cart_member In (
                                      Select mem_id
                                        From member
                                       Where mem_add1 Like '%����%'
                                         And Extract(year From mem_bir) >= 73
                                         And mem_job = '�ֺ�')));

/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ����Ƚ���� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
*/           
Select mem_id,
       mem_hp,
       NVL((Select sum(cart_qty)
              From cart
             Where cart_member = member.mem_id
             Group By cart_member), 0) as ����Ƚ��,
       case when NVL((Select sum(cart_qty)
                        From cart
                       Where cart_member = member.mem_id
                    Group By cart_member), 0) >= 5
       then '��� ȸ��'
       else '�Ϲ� ȸ��' end as ȸ������
  From member
 Order By ����Ƚ�� Asc;

-- Left Outer Join
Select mem_id,
       mem_hp,
       NVL(sum(cart_qty), 0) as ����Ƚ��,
       case when NVL(sum(cart_qty), 0) >= 5
       then '��� ȸ��' 
       else '�Ϲ� ȸ��' end as ȸ������
  From member
  Left Outer Join cart
    On mem_id = cart_member
 Group By mem_id, mem_hp
 Order By ����Ƚ��;
  
-- 4��
/*
<�¿�>
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
*/
Select buyer_comtel
  From buyer
 Where buyer_id In (
        Select prod_buyer
        From prod
        Where prod_id In (
                Select cart_prod
                From cart
                Where cart_member In (
                        Select mem_id
                        From member
                        Where mem_name = '�輺��')));

/*
<�°�>
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ�������� '��' �� ġȯ�ؼ� ����ض� 
*/
Select mem_name,
       mem_bir,
       replace(substr(mem_name, 1, 1), '��', '��') || substr(mem_name, 2, 2)
  From member
 Where mem_id In(
          Select cart_member
            From cart
           Where cart_prod In(
                       Select prod_id
                         From prod
                        Where prod_buyer In(
                                     Select buyer_id
                                       From buyer
                                      Where buyer_add1 Not Like '%����%'
                                        And buyer_bank = '��ȯ����')));

/*
<����>
¦�� �޿� ���ŵ� ��ǰ�� �� ��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ���� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, ���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)
*/
Select prod_id,
       prod_name,
       prod_price - prod_cost,
       case prod_price - prod_cost
       when (Select max(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%��Ź ����%'
                And prod_id In(
             Select cart_prod
               From cart
              Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 0.9
       when (Select min(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%��Ź ����%'
                And prod_id In(
             Select cart_prod
               From cart
              Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 1.1
       else prod_price - prod_cost end as ����
  From prod
 Where prod_delivery not like '%��Ź ����%'
   And prod_id In(
           Select cart_prod
             From cart
            Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12))
 Group By prod_id, prod_name, prod_price - prod_cost;