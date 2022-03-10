-- ���̺� ����
Create Table Iprod (
    Iprod_id number(5) Not Null,
    Iprod_gu char(4) Not Null,
    Iprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_Iprod Primary Key (Iprod_gu)
);

-- Select ����
Select Iprod_id, Iprod_gu, Iprod_nm
From Iprod;

-- Insert
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    1, 'P101', '��ǻ�� ��ǰ'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    2, 'P102', '���� ��ǰ'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    3, 'P201', '���� ĳ���'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    4, 'P202', '���� ĳ���'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    5, 'P301', '������ȭ'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    6, 'P302', 'ȭ��ǰ'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    7, 'P401', '����/CD'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    8, 'P402', '����'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    9, 'P403', '������'
);

-- Select : ��ǰ�з��������� ��ǰ�з��ڵ��� ���� P201�� �����͸� ��ȸ
Select *
From Iprod
-- ���� �߰�
Where Iprod_gu = 'P201';

-- Update ����
-- ��ǰ�з��ڵ尡 P102�� ���� ��ǰ�з����� ���� ����� ����
-- �����ϱ� ���� ���� Where���� �������� ��ȸ�� ���ֱ�
Select *
From Iprod
Where Iprod_gu = 'P102';

Update Iprod
   Set Iprod_nm = '���'
 Where Iprod_gu = 'P102';
 
-- Delete ����
-- ��ǰ�з��������� ��ǰ�з��ڵ尡 P202�� ���� �����͸� ����
Select *
From Iprod
Where Iprod_gu = 'P202';

Delete From Iprod
Where Iprod_gu = 'P202';

Commit;

-- �ŷ�ó ���� ���̺� ����
Create Table buyer
(buyer_id char(6) Not Null,
buyer_name varchar2(40) Not Null,
buyer_lgu char(4) Not Null,
buyer_bank varchar2(60),
buyer_bankno varchar2(60),
buyer_bankname varchar2(15),
buyer_zip char(7),
buyer_add1 varchar2(100),
buyer_add2 varchar(70),
buyer_comtel varchar2(14) Not Null,
buyer_fax varchar2(20) Not Null);

-- �÷� �߰�
Alter Table buyer 
    Add
    (buyer_mail varchar2(60) NOt Null,
    buyer_charger varchar2(20),
    buyer_telext varchar2(2));

-- �÷��� ������ ����
Alter Table buyer 
    Modify (buyer_name varchar(60));

-- �������� �߰�
-- buyer ���̺��� buyer_id�� pk�� ����(pk_buyer��� �̸����� ����)
-- buyer ���̺��� buyer_lguŰ�� fk�� �����ϰ�(fr_buyer_Ipord��� �̸����� ����)
-- �ش� fk�� Iprod ���̺��� pk�� Iprod_gu�� �ٶ󺻴�
Alter Table buyer
    Add
    (Constraint pk_buyer Primary Key(buyer_id),
    Constraint fr_buyer_Ipord Foreign Key(buyer_lgu) 
        References Iprod(Iprod_gu));