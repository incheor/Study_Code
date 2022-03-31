# flask 기반 웹 서비스 엔트리 포인트 파일
# 모든 경로법은 엔트리 포인트를 기준으로 계산
## 대표적으로는 모듈의 경로

# TODO 모듈 가져오기
# render_template : html을 읽어서 사용자가 넣은 데이터와 함께
# 원하는 화면을 동적으로 만들어주는 함수임(SSR : Server Side Rendering)
from flask import Flask, render_template, jsonify, request

# 모듈 가져오는 방법 : from ~ import ~ , import ~
# 경로는 엔트리 포인트(프로그램이 시작하는 코드가 있는 파일) 기준임
# PI 가져오기 : ml 폴더 -> __init__.py(이건 생략 가능함)
# from ml import PI
# PI2 가져오기 : ml 폴더 -> a.py 파일
# from ml.a import PI2
# PI3 가져오기 : ml 폴더 -> c 폴더 -> d.py 파일
# from ml.c.d import PI3
# PI4 가져오기 : ml 폴더 -> c 폴더 -> __init__.py(이건 생략 가능함)
# from ml.c import PI4
# ml 파일의 lang_detect_ml 함수 imoprt
from ml import lang_detect_ml

# TODO flask 객체 생성
app = Flask(__name__)

# TODO 라우팅 : 서버로 특정 url로 요청이 들어오면
#               어떤 함수가 처리할 지 연결해주는 역할
# @ : 데코레이터
@app.route('/')
# 함수 설정
def home() :
    name = '안녕하세요!'
    # render_template는 template 폴더의 하위 파일을 찾아서 리턴함
    return render_template('index.html', key = name)

# 라우팅 할 때 method를 지정하지 않으면 get 방식으로 라우팅됨
# 요청의 방식을 POST와 GET 둘 다 받을 수 있음
@app.route('/lang_detect', methods = ['POST', 'GET'])
def lang_detect() :
    # 요청의 방식이 POST이면
    if request.method == 'POST' :
        # 1. 사용자가 보낸 말뭉치 획득
        # request(요청)이 post일 경우 아래처럼 데이터 추출함
        ori_src = request.form.get('ori_src')
        
        # 2. 머신러닝 모델이 말뭉치의 언어를 감지
        lang_detect_ml(ori_src)
        
        # 일단 더미 데이터 넣어놓기
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

# TODO 서버 가동 : run.py를 직접 구동시킬 때 만 가동되게 해야 함
#                  직접구동될 떄 __name__ 은 '__main__'이 됨
#                  만약 다른 모듈이 run.py를 가져와서 사용한다면
#                  __name__은 파일이름(여기서는 'run')으로 세팅됨
# 직접 구종했다면
if __name__ == '__main__' :
    # 서버 가동(디버깅 모드임)
    app.run(debug = True)