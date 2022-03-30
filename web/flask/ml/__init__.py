# 특정 폴더 밑에 모듈(*.py)이 위치하면 해당 폴더는 패키지가 됨
# 이 파일(__init__.py)은 패키지를 대변하며 생략 가능함
PI = 3.14

# 머신러닝 모듈 로드, 데이터 전처리, 예측, 번역
def load() :
    pass

def preprocessing() :
    pass

def predict() :
    pass

def trans() :
    pass

# 말뭉치를 받고 전처리하고 예측하고 응답
def lang_detect_ml(ori_text) :
    # 1. 말뭉치 획득
    print(ori_text)
    # 2. 전처리 : [[a 빈도, b 빈도, ..., z 빈도]...]
    # 알파벳 소문자만 남기고 제거
    import re
    p = re.compile('[^a-z]*')
    ori_text = p.sub('', ori_text)
    # 미리 알파벳 26개 개수가 들어갈 공간 만들어놓기
    list_count = [0 for i in range(26)]
    # 위의 리스트에 알파벳 위치 인덱싱용
    STD_INDEX = ord('a')
    # for 문으로 알파벳 위치 구해서 그 위치에 넣음
    for ch in ori_text :
        index = ord(ch) - STD_INDEX
        list_count[index] += 1
    print(list_count)
    # 3. 모델 로드
    # 4. 예측 수행, 번역 요청(파파고 api 연동)
    # 5. 결과 리턴

if __name__ == '__main__' :
    lang_detect_ml()