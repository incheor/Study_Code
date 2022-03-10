# R - Oracle 연동
# 하지만 보통 R에서는 하지 않고 파이썬에서 연동해서 사용함

# ojdbc.jar를 이용해서 데이터 접속을 위한 라이브러리
## 사전에 jdk 설치 밒 환경변수 등록하기
install.packages('RJDBC')
library(RJDBC)

# 오라클 드라이버 연결 경로 설정
# 대소문자 구분 주의
# classPath는 ojdbc8.jar 파일이 있는 경로
# 이걸 하면 이제 오라클에 접근할 수 있는 통로가 만들어진 거
driver <- JDBC("oracle.jdbc.OracleDriver",
               classPath = "C:/DEV/Server/Oracle/product/12.2.0/dbhome_1/jdbc/lib/ojdbc8.jar")
driver

# 오라클 접속하기
conn <- dbConnect(driver,
                  "jdbc:oracle:thin:@//localhost:1521/orcl", # 이건 집주소 같은거 : 호스트 이름 : 포트/서비스 이름
                  "busan", "dbdb") # 이건 집 비밀번호 같은거 : 사용자 정보의 사용자 이름과 비밀번호
conn


# 데이터 [입력/삭제] 하기
# dbSendQuery()함수는 동일하게 사용
# 한 번에 하나만 하자
sql_in <- paste("Insert Into test",
                "(AA, BB, CC)",
                "values('a1', 'b1', 'c1')")

sql_in

in_stat = dbSendQuery(conn,sql_in)
in_stat

# 작업이 끝났으면 dbClearResult()해주기
# TURE 가 떠야 종료 성공한 거 
dbClearResult(in_stat)

# 조회하기
sql_sel <- "Select * From test Where AA = 'a1'"
sql_sel

getData <- dbGetQuery(conn, sql_sel)
getData
getData$AA

### 중요 ###
############ 오라클 접속 해제해주기
dbDisconnect(conn)
