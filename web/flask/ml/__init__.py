# 특정 폴더 밑에 모듈(*.py)이 위치하면 해당 폴더는 패키지가 됨
# 이 파일(__init__.py)은 패키지를 대변하며 생략 가능함
PI = 3.14
import re
import joblib

# 말뭉치를 받고 전처리하고 예측하고 응답
def lang_detect_ml(ori_text) :
    # 1. 말뭉치 획득
    print(ori_text)
    
    # 2. 전처리 : [[a 빈도, b 빈도, ..., z 빈도]...]
    # 알파벳 소문자만 남기고 제거
    text = ori_text.lower()
    p = re.compile('[^a-z]*')
    text = p.sub('', text).lower()
    # 알파벳 위치 인덱싱용
    STD_INDEX = ord('a')
    # 미리 알파벳 26개 개수가 들어갈 공간 만들어놓기
    cnts = [0 for i in range(26)]
    # for 문으로 알파벳 위치 구해서 그 위치에 넣음
    for ch in text :
        index = ord(ch) - STD_INDEX
        cnts[index] += 1
    # 정규화
    total_count = sum(cnts)
    cnt_norms = list(map(lambda x : x / total_count, cnts))
    # 3. 모델 로드
    # 사전 학습된 멈신러닝 기반  모델을 서비스에 적용한 위치
    clf = joblib.load('C:/Study_Code/web/flask/model/lang_clf.model')
    
    # 4. 예측 수행, 번역 요청
    y_pred = clf.predict([cnt_norms])
    
    # 5. 정답표 로드
    labels = joblib.load('C:/Study_Code/web/flask/model/lang_label')
    print(y_pred[0], labels[y_pred[0]])
    
    # 6. 결과 리턴
    return y_pred[0], labels[y_pred[0]]

if __name__ == '__main__' :
    lang_detect_ml()