# obj_mycar.py
from obj_vehicle import Car # obj_vehicle 패키지의 Car 클래스만 쓰겠다

if __name__ == '__main__':
    mycar = Car('12하 1234', '주황색')
    mycar.__제조사 = '미래'
    mycar.연료 = '핵융합'
    mycar.출고년도 = 2024

    print(mycar.__제조사) # 이렇게 하면 위에서 초기화한 값이 나옴
    mycar.제조사입력('Future') # 이렇게 obj_vehicle.py 파일의 Car 클래스에서 정의한 멤버함수를 활용해야 멤버변수를 접근할 수 있음
    mycar.제조사확인()
    mycar.전진()
    print(mycar)