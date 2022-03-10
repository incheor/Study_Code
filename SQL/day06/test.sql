-- ���� ������ �����ϰ� ������ 2���̰� �������ڰ� 4�� ~ 6�� ������ ȸ�� �� 
-- ���ż����� ��üȸ���� ��� ���ż������� ���� ȸ���� ��ȸ�ϰ�
-- "(mem_name) ȸ������ (Extract(month form mem_bir)) �� ������ �������� �����մϴ�. 
-- 2��Ʈ (mem_add �� 2����) ���� �̿��� �ּż� �����մϴ�.
-- �̹� 2�� ���ȿ��� VVIPȸ������ ���ϸ����� 3��� ����Ͻ� �� �ֽ��ϴ�.
-- �����ε� ���� �̿� �ٶ��ϴ�." ���
-- �÷��� ȸ����, ����, �ּ�, �̸��� �ּ�, ���� ���� ����
Select mem_name as �̸�,
       Decode(substr(mem_regno2, 1, 1), '1', '��', '��') as ����,
       mem_mail as �̸���,
       mem_name || ' ȸ������ ' || Extract(month from mem_bir) || '�� ������ �������� �����մϴ�. ' ||
       '2��Ʈ ' || substr(mem_add1, 1, 2) || '���� �̿��� �ּż� �����մϴ�.' ||
       '�̹� 2�� ���ȿ��� VIPȸ������ ���ϸ����� 2��� ����Ͻ� �� �ֽ��ϴ�.' as �������ϸ�Ʈ
  From member
 Where substr(mem_add1, 1, 2) Like '����%'
   And Extract(month from mem_bir) = 2
   And mem_id In(
          Select cart_member
            From cart
           Where cart_qty >= (Select Avg(cart_qty) From cart)
             And to_number(substr(cart_no, 5, 2)) Between 4 And 6);
-- 2���� ȸ���� ���� ������ �ƹ��͵� ��µ��� ����
              
-- [����]
-- �ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
-- �� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
-- 02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
-- (�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�. (��ȭǥ�� �� õ��������))
-- (alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)
Select prod_name,
       prod_lgu,
       TO_CHAR(prod_sale,'L9,999,999'),
       DECODE(SUBSTR(prod_id,9,10),
       '01', prod_sale - (prod_sale * 10/100),
       '02', prod_sale + (prod_sale * 5/100)) as "�����ǸŰ�"                       
  From prod
 Where prod_id IN(
           SELECT cart_prod 
             From cart
            WHERE cart_member IN(
                          SELECT mem_id
                            FROM member    
                           Where EXTRACT(MONTH From mem_bir) = '1' ))                                                          
   And prod_sale Between 500000 AND 1000000;


/* [����]
�ſ�ȯ���� 2005�� ������ �Ǹŵ� �� ��ǰ ����,
����Ǹż����� ��ȸ
2005�� ���� ū ������ �������� ����
�� ��ü �Ⱓ ��� �Ǹ� ���� ���� �̸��� ���� ��ȸ
Alias �Ǹ�����, ���� ���� �հ� , ���� �հ� 
*/

SELECT 
          SUBSTR(cart_no, 1, 6) AS YYYYMM,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  WHERE cart_member = (SELECT mem_id
                                   FROM member
                                    WHERE mem_name = '�ſ�ȯ')
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < (SELECT AVG(cart_qty) 
                                        FROM cart)
ORDER BY YYYYMM DESC;