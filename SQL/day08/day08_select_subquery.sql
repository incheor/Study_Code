-- ��������
-- SQL ���� �ȿ� �� �ٸ� Select ������ �ִ� ���� �ǹ���
-- subquery�� ��ȣ�� ����
-- �����ڿ� ����� ��� �����ʿ� ��ġ
-- From���� ����� ��� viewó�� ������ ���̺�ó�� Ȱ��� inline view��� �θ�
-- main query�� sub query�� ������ ���ο� ���� ���� �Ǵ� �񿬰� subquery�� ������
-- ��ȯ�ϴ� ���� ��, �÷��� ���� ���� ������/������, �����÷�/�����÷����� ������
-- �Ʒ��� �� ���� ����� ����
-- ����
Select prod_id, prod_name, lprod_nm
  From prod
 Inner Join lprod 
    On prod_lgu = lprod_gu;
-- ��������
Select prod_id, prod_name,(Select lprod_nm From lprod Where prod_lgu = lprod_gu)
  From prod;

-- ����Ŭ���� �ִ� �������� �񱳿����� Any, All
-- ���� ��� + �񱳿����� + Any/And + ��������
-- Any : Or�� ���� / All : And�� ����
Select mem_name, mem_job, mem_mileage
  From member
 Where mem_job <> '������'
   And mem_mileage > 
   All (Select mem_mileage
          From member
         Where mem_job = '������');