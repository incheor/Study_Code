-- ȸ�� ���̺� ������ ȫ�浿 ȸ���� �Է��ϴ� ������ �ۼ��ϼ���
-- �������� ���� ����ؾ� �մϴ�
INSERT INTO membertbl( 
            idx, 
            names
            , levels
            , addr
            , mobile
            , email
            , userid
            , password
            , LASTLOGINDT
            , LOGINIPADDR
            )
VALUES (
       member_index.NEXTVAL
     , 'ȫ�浿'
     , 'A'
     , '�λ�� ���� �ʷ���'
     , '010-7989-0909'
     , 'HGD09@NAVER.COM'
     , 'HGD7989'
     , '12345'
     , NULL
     , NULL
     );
     
SELECT *FROM membertbl;