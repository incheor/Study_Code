-- 테이블 생성
Create Table Iprod (
    Iprod_id number(5) Not Null,
    Iprod_gu char(4) Not Null,
    Iprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_Iprod Primary Key (Iprod_gu)
);

-- Select 예시
Select Iprod_id, Iprod_gu, Iprod_nm
From Iprod;

-- Insert
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    1, 'P101', '컴퓨터 제품'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    2, 'P102', '전자 제품'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    3, 'P201', '여성 캐쥬얼'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    4, 'P202', '남성 캐쥬얼'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    5, 'P301', '피혁잡화'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    6, 'P302', '화장품'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    7, 'P401', '음반/CD'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    8, 'P402', '도서'
);
Insert Into Iprod (
    Iprod_id, Iprod_gu, Iprod_nm
) Values (
    9, 'P403', '문구류'
);

-- Select : 상품분류정보에서 상품분류코드의 값이 P201인 데이터를 조회
Select *
From Iprod
-- 조건 추가
Where Iprod_gu = 'P201';

-- Update 예시
-- 상품분류코드가 P102에 대해 상품분류명의 값을 향수로 수정
-- 수정하기 전에 먼저 Where절의 조건으로 조회를 해주기
Select *
From Iprod
Where Iprod_gu = 'P102';

Update Iprod
   Set Iprod_nm = '향수'
 Where Iprod_gu = 'P102';
 
-- Delete 예시
-- 상품분류정보에서 상품분류코드가 P202에 대한 데이터를 삭제
Select *
From Iprod
Where Iprod_gu = 'P202';

Delete From Iprod
Where Iprod_gu = 'P202';

Commit;

-- 거래처 정보 테이블 생성
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

-- 컬럼 추가
Alter Table buyer 
    Add
    (buyer_mail varchar2(60) NOt Null,
    buyer_charger varchar2(20),
    buyer_telext varchar2(2));

-- 컬럼의 사이즈 변경
Alter Table buyer 
    Modify (buyer_name varchar(60));

-- 제약조건 추가
-- buyer 테이블의 buyer_id를 pk로 설정(pk_buyer라는 이름으로 설정)
-- buyer 테이블의 buyer_lgu키를 fk로 설정하고(fr_buyer_Ipord라는 이름으로 설정)
-- 해당 fk는 Iprod 테이블의 pk인 Iprod_gu를 바라본다
Alter Table buyer
    Add
    (Constraint pk_buyer Primary Key(buyer_id),
    Constraint fr_buyer_Ipord Foreign Key(buyer_lgu) 
        References Iprod(Iprod_gu));