from flask import Flask, render_template, jsonify, request

# 모듈 가져오는 방법 : from ~ import ~ , import ~
# 경로는 엔트리 포인트(프로그램이 시작하는 코드가 있는 파일) 기준임
from ml import lang_detect_ml

app = Flask(__name__)

@app.route('/')
def home() :
    return render_template('index.html')

# 라우팅 할 때 method를 지정하지 않으면 get 방식으로 라우팅됨
# 요청의 방식을 POST와 GET 둘 다 받을 수 있음
@app.route('/lang_detect', methods = ['POST', 'GET'])
def lang_detect() :
    # 요청의 방식이 POST이면
    if request.method == 'POST' :
        dummy_data = {
            'code' : 'en',
            'kor' : '한국어',
        }
        dummy_data = jsonify(dummy_data)
        return dummy_data
    # 요청의 방식이 GET이면
    else :
        # 1. 클라이언트가 보낸 말뭉치 받기
        ori_text = '''
            The Yankee was one of America's first cultural publications and a precursor to the independent American press that formed decades later. Founded and edited by John Neal (pictured), it was published in Portland, Maine, between 1828 and 1829. The magazine helped establish the American gymnastics movement, covered national politics, and critiqued American literature, art, theater, and social issues. Many new, predominantly female, writers and editors started their careers with publication and coverage in The Yankee, including many who are familiar to modern readers. Essays by Neal on American art and theater anticipated major changes and movements realized in the following decades. His articles on women's rights and early feminist ideas affirmed intellectual equality between men and women and demanded political and economic rights for women, saying "If woman would act with woman, there would be a stop to our tyranny".
        '''
        # 2. 말뭉치를 예측 모델에 사용할 수 있도록 전처리 3. 머신러닝 모델 로드 4. 예측 수행
        lang_detect_ml(ori_text)
        # 5. 응답 데이터 구성
        # 6. 응답
        return ''

if __name__ == '__main__' :
    app.run(debug = True)