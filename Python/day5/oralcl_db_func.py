# 커서에 접근하는 코드를 함수로 작성해보기
import cx_Oracle as ora

# 함수를 만들 때는 main함수 위에 만드는 게 좋음
# 커서 객체에 접근하는 함수
def myconn():
    dsn = ora.makedsn('localhost', 1521, service_name='orcl') # 오라클 주소 가져오기
    conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8') # 오라클에 접속준비

    return conn

# emp 테이블의 모든 레코드 출력하기
def getAllData(conn): # conn 객체를 매개변수로 받아서 쿼리를 수행할 함수
    cur = conn.cursor() # 커서를 생성
    query = 'SELECT * FROM emp' # emp 테이블에서 데이터 모두 가져와라
    for row in cur.execute(query):
        print(row)

# emp 테이블의 ename, job 컬럼의 데이터 출력하기
def getNameAndJobData(conn):
    cur = conn.cursor()
    query = 'SELECT ename, job FROM emp' # emp 테이블의 ename, job 정보 가져와라
    cur.execute(query) # while문일 때는 execute() 먼저 해야함
    while True: # 이번에는 while문 써보기
        row = cur.fetchone() # 한 row(레코드)를 읽어옴
        if row is None:
            break
        print(row)

# # dept 테이블의 deptno 를 입력받아서 부서명을 출력하기
# def getDeptName(conn, no): # 보고 싶은 테이블의 인덱스
#     cur = conn.cursor()
#     query = f'SELECT * FROM dept WHERE deptno = {no}'
#     cur.execute(query)
#     row = cur.fetchone()
#     print(row)

# # dept 테이블의 deptno와 location을 입력받아서 부서명을 출력하기
# def getDeptName(conn, no, loc): # 보고 싶은 테이블의 인덱스
#     cur = conn.cursor()
#     query = f'SELECT * FROM dept WHERE deptno = {no} AND loc = \'{loc}\''
#     # 오라클 db에서 loc의 자료형은 varchar2이기 때문에 ' (홑따옴표) 필요함
#     cur.execute(query)
#     row = cur.fetchone()
#     print(row)

# # 튜플을 활용해서 dept 테이블의 deptno와 location을 입력받아서 부서명을 출력하기
# def getDeptName(conn, tup): # 매개변수를 튜플로 변경
#     cur = conn.cursor()
#     query = f'SELECT * FROM dept WHERE deptno = {tup[0]} AND loc = \'{tup[1]}\''
#     cur.execute(query)
#     row = cur.fetchone()
#     print(row)

# 더 응용해보기
def getDeptName(conn, tup): # 매개변수를 튜플로 변경
    cur = conn.cursor()
    query = 'SELECT * FROM dept WHERE deptno = :1 AND loc = :2'
    # 현업에서는 해킹 위험 때문에 f + {0} 대신에 :(콜론)1 쓴다, 매개변수 tup 로 값이 바뀜
    # 1부터 시작하는 이유는 오라클DB의 인덱스는 1부터 시작하기 때문임
    cur.execute(query, tup) # tup 로 받은걸 :1, :2 등으로 전달해줌
    row = cur.fetchone()
    print(row)

if __name__ == '__main__': # 다른 언어의 int main(){} 같은거
    print('----프로그램 시작----')
    print('')
    scott_conn = myconn() # DB접속 함수 호출 : dsn, connect 후 접속객체 conn 리턴

    print('--emp 테이블 전체 조회--')
    getAllData(scott_conn)
    print('')

    print('--emp 테이블의 ename, job 컬럼 조회--')
    getNameAndJobData(scott_conn)
    print('')

    print('--dept 테이블의 부서 조회--')
    no = input('1. 검색할 부서번호 입력하세요: ')
    loc = input('2. 검색할 부서의 지역을 입력하세요: ').upper()
    tup = (no, loc)
    print(f'부서번호가 {no}이고 지역은 {loc}인 부서를 검색합니다.')
    getDeptName(scott_conn, tup)
    print('')

    print('----프로그램 종료----')
    scott_conn.close()