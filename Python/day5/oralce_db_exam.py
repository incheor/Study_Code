# book_rental
# divtbl, membertbl
import cx_Oracle as ora

def myconn():
    dsn = ora.makedsn('localhost', 1521, service_name='orcl')
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')
    return conn

# 1. divtbl에서 데이터 조회 : SELECT
def getAllDataFromDivtbl(conn):
    cur = conn.cursor()
    query = 'SELECT * FROM divtbl'
    for row in cur.execute(query):
        print(row)

# 2. divtbl에 새로운 데이터 입력 : INSERT
def setDataIntoDivtbl(conn, tup):
    cur = conn.cursor()
    query = '''INSERT INTO divtbl (division, names) 
                VALUES (:1, :2) '''
    cur.execute(query, tup)
    cur.close()
    conn.commit() # DB 커밋해주기 COMMIT; 이거 안 해주면 데이터 저장 안 됨

# 3. membertbl에서 데이터 조회 : SELECT
def getSomeDataFromMembertbl(conn):
    cur = conn.cursor()
    query = '''SELECT names, levels, addr, mobile, email 
                 FROM membertbl
                WHERE addr LIKE '서울%'
                  AND UPPER(email) LIKE '%@NAVER.COM'
                ORDER BY idx DESC'''
    for row in cur.execute(query):
        print(row)
    cur.close()

# 4. membertbl에 새 데이터 입력 : INSERT
def setNewMemberIntoMembertbl(conn, tup):
    cur = conn.cursor()
    query = '''SELECT ROWNUM, idx
                FROM (
                    SELECT idx FROM membertbl
                    ORDER BY idx DESC  
                        ) 
                WHERE ROWNUM = 1'''
    cur.execute(query)
    idx = cur.fetchone() # 해당 테이블에 데이터가 하나도 없을 경우에는 예외가 발생할 수도 있다
    if idx is None: # 데이터가 없을 경우 (None)
        idx = 0 # idx에 0 넣어주기
    else: # None이 아니라면
        idx = idx[1] # 두번째 idx에 두번째 값인 인덱스 값을 넣어주기 

    intup = (idx + 1, tup[0], tup[1], tup[2], tup[3])

    query = '''INSERT INTO membertbl 
                        (idx, names, levels, userid, password)
                VALUES (:1, :2, :3, :4, :5)'''
    cur.execute(query, intup)
    cur.close()
    conn.commit()

# 5. membertbl 데이터를 수정 : UPDATE
def setChangeMemberFromMembertbl(conn, tup):
    cur = conn.cursor()
    query = '''UPDATE membertbl
                SET addr = :1
                , mobile = :2
                , email = :3
                WHERE idx = :4'''
    cur.execute(query, tup)
    conn.commit()

# 6. divtbl에 임의 데이터 삭제 : DELETE
def deleteDivision(conn, division):
    cur = conn.cursor()
    query = 'DELETE FROM divtbl WHERE division = :1'
    cur.execute(query, (division,))
    conn.commit()

if __name__ == '__main__':
    print('----책대여점 프로그램 시작----')
    scott_conn = myconn() # DB에 접속

    # 1. divtbl에서 데이터 조회 : SELECT
    print('')
    print('--책 장르 정보 조회--')
    getAllDataFromDivtbl(scott_conn)

    # 2. divtbl에 새로운 데이터 입력 : INSERT
    print('')
    print('--책 장르 정보 추가--')
    division = input('구분 코드를 입력하세요: ')
    names = input('장르명 입력하세요: ')
    tup = (division, names)
    setDataIntoDivtbl(scott_conn, tup)
    print('--정보를 입력했습니다--')

    # 3. membertbl에서 데이터 조회 : SELECT
    print('')
    print('--회원의 정보를 조회--')
    getSomeDataFromMembertbl(scott_conn)

    # 4. membertbl에 새 데이터 입력 : INSERT
    print('')
    print('--신규 회원 입력--')
    names = input('이름을 입력하세요: ')
    levels = input('레밸을 입력하세요(A ~ D): ')
    userid = input('아이디를 입력하세요(최대 20자): ')
    password = input('비밀번호를 입력하세요(최대 20자): ')
    tup = (names, levels, userid, password)
    setNewMemberIntoMembertbl(scott_conn, tup)
    print('--신규 회원 저장 성공--')

    # 5. membertbl 데이터를 수정 : UPDATE
    print('')
    print('--회원 정보 수정--')
    idx = input('변경할 회원의 번호를 입력하세요: ')
    addr = input('주소를 입력하세요: ')
    mobile = input('휴대전화 번호를 입력하세요(-를 포함해주세요): ')
    email = input('이메일 주소를 입력해주세요: ')
    tup = (addr, mobile, email, idx) # idx가 마지막인 이유는 마지막에 쓰는 WHERE절에 가장 처음 입력한 idx가 들어가기 때문임
    setChangeMemberFromMembertbl(scott_conn, tup)
    print('--기존회원 정보 수정 완료--')

    # 6. divtbl에 임의 데이터 삭제 : DELETE
    print('')
    print('--책 장르 정보 삭제--')
    division = input('삭제할 책 장르코드 입력: ')
    deleteDivision(scott_conn, division)
    print('--삭제 성공--')