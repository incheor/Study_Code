# 오라클 DB 연동
# cx_Oracle 라이브러리 설치 : pip install cx_oracle
from multiprocessing import connection
import cx_Oracle as ora # 매번 cx_Oracle하면 길어서 ora로 정함

# 오라클 주소 가져오기
# makedsn('데이터베이스의 호스트명 또는 IP주소', 포트번호, service_name='서비스 이름')
dsn = ora.makedsn('localhost', 1521, service_name='orcl')

# 오라클에 접속
# connect(user='유저명', password='패스워드', dsn=dsn, encoding='utf-8')
conn = ora.connect(user='scott', password='tiger', dsn=dsn, encoding='utf-8')

# 커서 생성
# 커넥트.corsor()
cur = conn.cursor()

# 이제 출력해보기
# 커서.execute('PL/SQL문')
# for문이 실행되면 인덱스가 변경되면서 커서가 가리키는 row도 변경된다
# 출력은 튜플로 나온다
try: 
    # for row in cur.execute('SELECT * FROM emp'): # emp 최상단에 커서가 위치하면서
    #     print(row) # 한 줄 씩 출력
    cur.execute('SELECT COUNT(*) FROM emp')
    result = cur.fetchone() # fetchone() : 한 줄 읽는다는 뜻 # fetchmany(읽을 레코드 수) : 입력한 수 만큼 읽음
    print(result)
except ora.DatabaseError as e:
    print(f'오라클 쿼리문이 잘못되었습니다. 확인해주세요. 에러명: {e}')

# close() 해주는데 순서도 중요하다
finally:
    cur.close() # 커서 닫고
    conn.close() # 접속 닫기