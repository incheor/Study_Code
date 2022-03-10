# obj_vehicle.py
class Car:
    차량번호 = '11가 1111'
    __제조사 = '현대'
    # _ (언더바)가 2개인 것은 private 임
    # 외부의 클래스에서는 값을 바로 지정할 수 없음
    # 외부에서 접근하려면 그 클래스에 속한 멤버함수로 우회적으로 접근해야함
    색상 = '흰색'
    연료 = '핵분열'
    출고년도 = 2023

    def __init__(self, 차량번호, 색상) -> None:
        self.차량번호 = 차량번호
        self.색상 = 색상

    def __str__(self) -> str: # 이 매직메서드는 string을 리턴(출력)하고 사용은 print(mycar)로 하면 됨
        return f'이 차는 {self.출고년도}년도에 만들어진 {self.연료}차량입니다.'

    def 제조사입력(self, 제조사):
        self.__제조사 = 제조사

    def 제조사확인(self):
        print(f'제조사는 {self.__제조사}입니다.')

    def 전진(self):
        print(f'{self.색상}차가 앞으로 달린다.')

    def 후진(self):
        print(f'{self.색상}차가 뒤로 달린다.')

    def 좌회전(self):
        print(f'{self.색상}차가 왼쪽으로 돈다.')

    def 우회전(self):
        print(f'{self.색상}차가 오른쪽으로 돈다.')

    def 정지(self):
        print(f'{self.색상}차가 멈춘다.')