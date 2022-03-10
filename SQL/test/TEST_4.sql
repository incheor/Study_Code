-- 회원 테이블에 마지막 홍길동 회원을 입력하는 쿼리를 작성하세요
-- 시퀀스를 만들어서 사용해야 합니다
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
     , '홍길동'
     , 'A'
     , '부산시 동구 초량동'
     , '010-7989-0909'
     , 'HGD09@NAVER.COM'
     , 'HGD7989'
     , '12345'
     , NULL
     , NULL
     );
     
SELECT *FROM membertbl;