# 구동 함수
def run() :
    year, path = run_start()
    path, source_data_path = kbo_record_web_crawling(year, path)

    preprocessing, total_preprocessing_file_name = kbo_preprocessing(path, source_data_path)
    win_post_web_data(year, preprocessing, total_preprocessing_file_name)

# 시작 함수
def run_start() :    
    import os
    while True :
        try :
            year = int(input(
'''
1. 데이터를 추출할 연도를 숫자로만 입력해주세요. 2001년부터 해당연도까지 데이터를 추출합니다.
   (2001년 이후로 입력해주세요)
'''
            ))
            if year < 2001 :
                print('잘못 입력하셨습니다. 2001년 이후로 입력해주세요.\n')
                continue
            path = input(
'''
2. 추출한 데이터를 다운받을 경로를 입력해주세요.
'''
            )
            # 만약 입력받은 경로가 폴더가 아니라면 다시 입력받음
            if os.path.isdir(path) == False :
                print('잘못 입력하셨습니다. 정확한 폴더 경로를 입력해주세요.\n')
                continue
            print('데이터 추출을 시작합니다. 시간이 조금 소요될 수 있습니다.\n')
            break
        except Exception as e :
            print('잘못 입력하셨습니다. 정확한 연도를 입력해주세요.\n')
            continue
    return year, path

# 포지션별 성적 웹크롤링 함수
def kbo_record_web_crawling(year, path) :
    '''
    years(int) : 데이터를 추출할 기간을 설정하는 연도(2001년부터)
    path(string) : 다운로드받을 경로
    '''
    # 라이브러리
    from selenium import webdriver
    from bs4 import BeautifulSoup as bs
    import pandas as pd
    import time
    from html_table_parser import parser_functions
    import os
    
    # 크롬 드라이버
    driver = webdriver.Chrome('C:/ChromeDriver_exe/chrome_99_driver.exe')

    # 포지션별 url 딕셔너리
    dict_positioin_url = {
        '타자' : ['https://www.koreabaseball.com/Record/Team/Hitter/Basic1.aspx', 'https://www.koreabaseball.com/Record/Team/Hitter/Basic2.aspx'],
        '투수' : ['https://www.koreabaseball.com/Record/Team/Pitcher/Basic1.aspx', 'https://www.koreabaseball.com/Record/Team/Pitcher/Basic2.aspx'],
        '수비' : ['https://www.koreabaseball.com/Record/Team/Defense/Basic.aspx'],
        '주루' : ['https://www.koreabaseball.com/Record/Team/Runner/Basic.aspx']
    }
    
    # 동적 웹 페이지의 페이지를 연도로 갱신해주기 위한 드롭박스 태그의 id
    tag_id = 'cphContents_cphContents_cphContents_ddlSeason_ddlSeason'
    
    # 경로의 끝에 '/' 가 있으면 제거해줌
    if path[-1] == '/' :
                    path = path[:-1]
            
    # 추출한 데이터를 저장할 폴더 경로 설정
    source_data_path = path + '/원본_데이터'
    
    # 폴더 생성
    try :
        os.makedirs(source_data_path)
    except Exception as e :
        print('<<< 에러 >>>')
        print(e)
            
    # 2001년부터 입력받은 연도까지 리스트로 생성
    years = [year for year in range(2001, year + 1)]

    try :
        # for문으로 포지션별 딕셔너리의 포지션명과 url 가져옴
        for position, urls in dict_positioin_url.items() :
            print(f'----- {position} 데이터 추출 시작 -----')

            # 진행률 분자용
            count = 0

            # 진행률 분모용 : 타자 또는 투수면 분모가 2배, 나머지는 그대로
            if position == '타자' or position == '투수' :
                rng = ((year + 1) - 2001) * 2
            else :
                rng = ((year + 1) - 2001)

            # 포지션별 저장 경로 설정
            position_dir_path = source_data_path + f'/{position}'

            # csv 파일을 저장할 포지션 폴더 생성
            os.makedirs(position_dir_path)

            # 포지션별 url 가져옴
            for url in urls :
                # 연도별로 데이터를 추출
                for year in years :
                    # 진행률
                    progress = round((count / rng) * 100, 1)
                    print(f'데이터 추출 진행중... {progress}%')

                    # 크롬 드라이버로 url 넣어줌
                    driver.get(url)
                    time.sleep(1)

                    # find_element_by_id로 드롭박스를 찾고
                    # 그 태그에 연도 값을 넣어서 페이지를 갱신해줌 
                    driver.find_element_by_id(tag_id).send_keys(str(year))
                    time.sleep(1)

                    # 렌더링된 페이지의 요소들을 문자열 형태로 가져오기 
                    html = driver.page_source

                    # 문자열 형태로 가져와서 html 형태로 변환하기
                    soup = bs(html, 'html.parser')

                    # 태그가 테이블이고 클래스가 tData tt인 요소를 찾기
                    data = soup.find('table', {'class' : 'tData tt'})

                    # html의 테이블을 파이썬의 리스트 형태로 변환하기
                    table = parser_functions.make2d(data)

                    # 위에서 변환한 테이블 데이터를 데이터 프레임으로 만들어줌
                    df = pd.DataFrame(data = table)

                    # 전처리
                    df.columns = df.iloc[0]
                    df = df.drop([0]).reset_index(drop = True)

                    # csv 파일 경로 설정
                    file_name = f'/{position}_{year}년_1_원본_데이터.csv'
                    csv_file_path = position_dir_path + file_name
                    
                    # 경로에 같은 이름의 파일이 있으면 이름 변경해줌
                    if file_name[1:] in os.listdir(position_dir_path) :
                        csv_file_path = position_dir_path + f'/{position}_{year}년_2_원본_데이터.csv'
                    if position == '타자' and file_name[1:] in os.listdir(position_dir_path) :
                        df = df.drop(['AVG'], axis = 1).reset_index(drop = True)
                        csv_file_path = position_dir_path + f'/{position}_{year}년_2_원본_데이터.csv'
                    if position == '투수' and file_name[1:] in os.listdir(position_dir_path) :
                        df = df.drop(['ERA'], axis = 1).reset_index(drop = True)
                        csv_file_path = position_dir_path + f'/{position}_{year}년_2_원본_데이터.csv'

                    # csv 파일로 만들어서 포지션 폴더에 저장해주기
                    df.to_csv(csv_file_path)

                    # 진행률 +1 해주기
                    count += 1

            print('데이터 추출 진행중... 100%')
            print(f'      {position} 데이터 추출 완료\n')
        print('데이터 추출을 완료했습니다.\n')
        
        return path, source_data_path
    
    except Exception as e :
        print('<<< 에러 >>>')
        print(e)
        print('프로그램을 종료합니다')

# 포지션별 성적 통합 함수
def kbo_preprocessing(path, source_data_path) :
    '''
    path : kbo_record_web_crawling 함수에서 반환된 첫번째 경로값
    source_data_path : kbo_record_web_crawling 함수에서 반환된 두번째 경로값
    '''
    # 라이브러리
    import pandas as pd
    import os
    
    # 통합해서 저장할 폴더의 경로 설정
    preprocessing = path + '/통합_데이터'
    
    # 통합해서 저장할 폴더 생성
    try :
        os.makedirs(preprocessing)
    except Exception as e :
        print(f'에러 : {e}')
        
    # 진행률 분자용
    count = 0
    
    # 진행률 분모용
    rng = 4
    for i in range(len(os.listdir(source_data_path))) :
        rng = rng + len(os.listdir(source_data_path + '/' + os.listdir(source_data_path)[i]))

    print('데이터 통합을 시작합니다. 잠시만 기다려 주세요.')
    # 1. 연도별로 나눠져있는 포지션 데이터를 합치기
    # 원본 데이터가 있는 경로
    source_data_file_path = os.listdir(source_data_path)
    for source_data in source_data_file_path :
        position_source_data_path = source_data_path + f'/{source_data}'
        
        # 파일명 끝이 'csv' 인 파일만 리스트에 담음
        list_csv_file = [file for file in os.listdir(position_source_data_path) if file.endswith('.csv')]
        
        # 임시 통합용 데이터 프레임 생성
        tmp_df = pd.DataFrame()
        
        # csv 파일 열고 연도를 통합한 포지션별 데이터 생성
        for csv_file in list_csv_file :
            progress = round((count / rng) * 100, 1)
            print(f'데이터 통합 진행중... {progress}%')
            csv_file_path = position_source_data_path + '/' + csv_file
            
            # 원본 데이터를 읽기
            df = pd.read_csv(csv_file_path, index_col = 0)
            
            # 팀명이 합계인 컬럼은 필터링
            df = df[(df['팀명'] != '합계')]
            
            # 팀명으로 정렬
            df = df.sort_values(by = ['팀명'])
            
            # 연도 컬럼 추가
            df['연도'] = csv_file[3 : 7]
            
            # 임시 통합용 데이터 프레임에 연도 컬럼 추가, df 와 합치기
            tmp_df = pd.concat([tmp_df, df], ignore_index = True)
            
            count += 1
            
        # 연도, 순위, 팀명별로 sum
        tmp_df = tmp_df.groupby(['연도', '순위', '팀명']).sum()
        
        # 파일 이름 설정
        preprocessing_file_name = preprocessing + f'/{source_data}_통합_데이터.csv'
        
        # 저장하기
        tmp_df.to_csv(preprocessing_file_name)
        
    # 2. 포지션별로 나눠져있는 통합 데이터 통합, 팀별로 옆으로 이어붙이기
    # 통합 데이터 파일 리스트
    list_preprocessing_file = os.listdir(preprocessing)
    
    # 통합용 임시 데이터 프레임
    tmp_df = pd.DataFrame()
    
    # 통합용 임시 데이터 프레임에 연도와 팀명 데이터 넣어놓기
    tmp_df = pd.read_csv(preprocessing + '/' + list_preprocessing_file[0])
    tmp_df = tmp_df.sort_values(by = ['연도', '팀명'])[['연도', '팀명']].reset_index(drop = True)
    
    # 통합할 데이터를 불러오기
    for preprocessing_file in list_preprocessing_file :
        progress = round((count / rng) * 100, 1)
        print(f'데이터 통합 진행중... {progress}%')
        # 통합 데이터의 경로 설정
        preprocessing_file_path = preprocessing + '/' + preprocessing_file
        
        # 통합할 데이터 불러오기
        df= pd.read_csv(preprocessing_file_path)
        
        # 연도, 팀명, 순위 컬럼은 제거
        df = df.drop(['연도', '팀명', '순위'], axis = 1)
        
        # 통합용 임시 데이터 프레임과 합치기, 옆으로 함치기
        tmp_df = pd.concat([tmp_df, df], axis = 1)
        
        count += 1
    
    # 저장할 파일 이름 설정
    total_preprocessing_file_name = preprocessing + '/kbo_포지션_통합_데이터.csv'
    
    # 저장하기
    tmp_df.to_csv(total_preprocessing_file_name)
    
    print('데이터 통합 진행중... 100%')
    print('데이터 통합을 완료했습니다.\n')
    
    return preprocessing, total_preprocessing_file_name

def win_post_web_data(year, preprocessing, total_preprocessing_file_name) :
    '''
    years(int) : 데이터를 추출할 기간을 설정하는 연도(2001년부터)
    preprocessing(string) : 다운로드 받을 경로
    total_preprocessing_file_name(string) : 통합, 전처리할 데이터 경로
    '''
    # 라이브러리
    from selenium import webdriver
    from bs4 import BeautifulSoup as bs
    import pandas as pd
    import time
    from html_table_parser import parser_functions
    import os
    import math

    # 크롬 드라이버
    driver = webdriver.Chrome('C:/ChromeDriver_exe/chrome_99_driver.exe')
    
    # 웹크롤링 url 포맷팅용 year_list 생성
    tmp = year % 10
    tmp_year = year - tmp
    year_list = [tmp_year for tmp_year in range(2000, year, 10)]
    
    # 연도별 우승팀, 포스트 시즌 진출팀 저장할 딕셔너리
    df_dict = dict()
    
    print('전처리 진행중...')
    
    # 반복문 돌면서 연도별로 웹크롤링하기
    for tmp_year in year_list : 
        # 웹크롤링할 url
        basic_url = f'https://www.koreabaseball.com/Record/History/Team/Record.aspx?startYear={tmp_year}&halfSc=T'

        # 크롬 드라이버로 url 넣어줌
        driver.get(basic_url)

        # 렌더링된 페이지의 요소들을 문자열 형태로 가져오기 
        html = driver.page_source

        # 문자열 형태로 가져와서 html 형태로 변환하기
        soup = bs(html, 'html.parser')

        # 태그가 테이블이고 클래스가 tData tt인 요소를 찾기
        data = soup.select('div.sub-content > table.tData')
        
        # 웹페이지 내의 여러 테이블을 읽어서 하나씩 데이터 프레임으로 변환하기
        for i in range(len(data)) :
            # 연도만 추출
            table_year = int(data[i].select('thead > tr > th')[0].text)
            
            # 2000년은 제외
            if table_year == 2000 :
                continue
            
            # 연도를 넘으면 자동 종료
            if table_year == year + 1 :
                break
                
            # html의 테이블을 파이썬의 리스트 형태로 변환하기
            table = parser_functions.make2d(data[i])
            
            # 위에서 변환한 테이블 데이터를 데이터 프레임으로 만들어줌
            df = pd.DataFrame(data = table)
            
            # 필요없는 행, 컬럼 제거
            df = df.drop([i for i in range(1, 8)], axis = 1)
            df = df[(df[0] != '합계')]
            
            # 컬럼 변경
            df.columns = df.iloc[0]
            df = df.drop([0]).reset_index(drop = True)
            
            # 연도를 key로, 데이터 프레임을 value로 저장
            df_dict[table_year] = df
            
    # 최종 데이터 프레임
    final_df = pd.DataFrame()

    # 통합, 전처리할 데이터 프레임 불러오기
    df = pd.read_csv(total_preprocessing_file_name).drop(['Unnamed: 0'], axis = 1)
    
    for y, d in df_dict.items() :
        # 4위까지만 포스트 시즌 진출
        for i in range(len(d)) :
            # 같은 연도만 필터링
            tmp_df = df[df['연도'] == y]
        
            # 연도별 팀명 추출
            rank_team = d[f'{y}'][i].split()[0]
            
            # 임시 데이터 프레임
            tmp_df2 = pd.DataFrame()
            
            # 0등은 우승 및 포스트 시즌 진출(Y, Y)
            if i == 0 :
                tmp_df = tmp_df[(tmp_df['팀명'] == rank_team)]
                tmp_df['우승'] = 'Y'
                tmp_df['포스트시즌'] = 'Y'
                tmp_df2 = tmp_df[['우승', '포스트시즌']]
                tmp_df = tmp_df.drop(['우승', '포스트시즌'], axis = 1)
                tmp_df2 = pd.concat([tmp_df2, tmp_df], axis = 1)
            # 1 ~ 3등은 포스트시즌 진출(N, Y)
            elif i == 1 or i == 2 or i == 3 :
                tmp_df = tmp_df[(tmp_df['팀명'] == rank_team)]
                tmp_df['우승'] = 'N'
                tmp_df['포스트시즌'] = 'Y'
                tmp_df2 = tmp_df[['우승', '포스트시즌']]
                tmp_df = tmp_df.drop(['우승', '포스트시즌'], axis = 1)
                tmp_df2 = pd.concat([tmp_df2, tmp_df], axis = 1)
            # 남은 팀은 진출 실패(N, N)
            else :
                tmp_df = tmp_df[(tmp_df['팀명'] == rank_team)]
                tmp_df['우승'] = 'N'
                tmp_df['포스트시즌'] = 'N'
                tmp_df2 = tmp_df[['우승', '포스트시즌']]
                tmp_df = tmp_df.drop(['우승', '포스트시즌'], axis = 1)
                tmp_df2 = pd.concat([tmp_df2, tmp_df], axis = 1)

            # 밑으로 이어붙임
            final_df = pd.concat([final_df, tmp_df2])
    
    # 정렬하기
    final_df = final_df.sort_values(['연도', '팀명']).reset_index(drop = True)

    # 경로 설정
    final_path = preprocessing + '/kbo_통합_및_전처리_데이터.csv'
    
    # 저장하기
    final_df.to_csv(final_path)
    
    print('전처리를 완료했습니다.')