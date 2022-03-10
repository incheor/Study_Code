-- �Լ� : ���ڿ�
-- concat : �� ���ڿ��� ��ħ (|| �̰͵� ��)
Select concat('My Name is ', mem_name) 
  From member;
  
-- chr, ascii : ascii ���� ���ڷ�, ���ڸ� ascii ������ ��ȯ
Select Chr(65) "CHR", Ascii('A')
  From dual;

-- ȸ�� ���̺��� ȸ��ID �÷��� ascii ���� ��ȸ
Select Ascii(mem_id) as ȸ��Ascii,
       Chr(Ascii(mem_id)) as ȸ��Chr
  From member;
  
-- Lower : �ҹ��ڷ� ��ȯ
-- Upper : �빮�ڷ� ��ȯ
-- Initcap : ù���ڸ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȯ
-- ȸ�� ���̺��� ȸ�� ID�� �빮�ڷ� ��ȯ�� ��ȸ
Select Upper(mem_id) as ȸ��ID
  From member;

-- Ltrim, Rtrim, trim : ���� ���ڸ� ����
-- ���ڿ� �߰��� ������ �� ����

-- Substr(c, m, i) : ���ڿ��� �Ϻθ� �ڸ���
-- c���ڿ��� m���ں��� i��° ���ڱ��� �߶� ��ȯ

-- Replace(c1, c2, c3) : ���ڳ� ���ڿ� ġȯ
-- C1�� ���Ե� c2 ���ڸ� c3������ ġȯ
-- c3�� ���� ��� ã�� c2 ���ڴ� ������
Select Replace('SQL Project', 'SQL', 'SSQQLL') as ����ġȯ1,
       Replace('Java Flex Via', 'a') ����ġȯ2
  From dual;

-- ȸ�� ���̺��� ȸ�� �̸� �� �̾� ���� ���� ġȯ�ϰ�
-- �ڿ� �̸��� ���� �� ��ȸ
-- �÷��� ȸ���̸�, ȸ����ġȯ
Select mem_name as ȸ���̸�,
       Concat(
       Replace(Substr(mem_name, 1, 1), '��', '��'), 
       Substr(mem_name, 2, 2)) as ȸ����ġȯ
  From member
 Where Substr(mem_name, 1, 1) = '��';


-- �Լ� : ����
-- Greatest, Least : ���ŵ� �׸� �� ���� ū, ���� ��

-- Round(n, 1) : ������ �ڸ������� �ݿø�
-- Trunc(n, 1) : ������ �ڸ������� ����

-- Mod(c, n) : c�� n���� �����⸦ �� ���� ��������


-- �Լ� : ��¥
-- Sysdate : �ý��ۿ��� �����ϴ� ���� ��¥, �ð�
Select Sysdate
  From dual;
  
-- Add_months(date, n) : date�� n���� ���� ��¥

-- Next_day(date, n) : date���� ���� ����� ��¥
-- �Ͽ���(1) ~ �����(7)
Select Next_day(Sysdate, 7)
  From dual;

-- Last_day(date) : �ش� ���� ���� ������ ��
Select Last_day(Sysdate)
  From dual;

-- �̹����� ��ĥ�� ���Ҵ��� ��ȸ
Select Last_day(Sysdate) - Sysdate
  From dual;
  
-- Extract : ��¥���� �ʿ��� �κи� ����
-- Extract(Year From date) : ������ ����
-- Extract(Month From date) : ���� ����
-- Extract(Day From date) : �ϸ� ����
-- ȸ�� �� ������ 3���� ����� ��ȸ
Select mem_name,
       mem_bir
  From member
 Where Extract(month From mem_bir) = 3;
 
-- ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
-- ��ȸ�� �÷��� ��ǰ���̸� ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ
-- ��ȸ������� �ߺ��� ����
Select Distinct prod_name as ��ǰ��
  From prod
 Where prod_name Like '%�Ｚ%'
   And prod_id In (
           Select cart_prod
             From cart
            Where cart_member In (
                          Select mem_id
                            From member
                           Where Extract(Year From mem_bir) =  1973));