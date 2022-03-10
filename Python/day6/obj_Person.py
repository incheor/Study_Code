# Person.py
# Person class
class Person:
    name = '무명이' # 아직 이름이 없다
    age = 0
    height = 0
    gender = ''
    feetsize = 0
    bloodtype = ''

    # 생성자 : 객체 생성시 자동으로 호출되는 함수이기 때문에 적어주지 않아도 되지만
    # 초기화를 위해 직접 구현할 수도 있다
    def __init__(self, name, age) -> None: # __init__ : 초기화 해줌
        self.name = name # 매개변수로 받은 것을 멤버변수에 넣어줌
        self.age = age
        print('Person이 생성되었습니다.')
    
    def introduce(self):
        greeting = f'안녕하세요. 저는 {self.name}이고 나이는 {self.age}살입니다.'
        print(greeting)
    def eat(self, food):
        print(f'{self.name}이(가) {food}을(를) 먹는다.')

    def work(self, drink):
        print(f'{self.name}이(가) {drink}을(를) 마시면서 일한다.')

if __name__ == '__main__':
    # p = Person() # p라는 이름의 Person 객체 생성
    # print(type(p)) # p의 자료형
    # print(id(p)) # p의 id값

    # jic = Person()
    # Person() == __init__(self, name, age)
    jic = Person('정인철', 26)
    # jic.name = '정인철'
    # jic.age = 26
    jic.height = 169
    jic.gender = 'male'
    jic.feetsize = 265
    jic.bloodtype = 'RH+ A'

    jic.introduce()
    jic.eat('본죽')
    jic.work('핫식스')