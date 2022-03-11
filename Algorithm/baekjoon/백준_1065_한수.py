# 어떤 양의 정수 X의 각 자리가 등차수열을 이룬다면, 그 수를 한수라고 함
# 등차수열은 연속된 두 개의 수의 차이가 일정한 수열을 말한다. N이 주어졌을 때, 
# 1보다 크거나 같고, N보다 작거나 같은 한수의 개수를 출력하는 프로그램을 작성
def han(n) :
    list_hansu = list() # 한수를 저장할 리스트
    
    # for 문으로 0부터 n까지 반복
    for i in range(1, n + 1) :
        temp = i # 원래 값을 저장해놓는 임시 변수
        list_temp = list() # 각 자리수를 추출해 저장할 임시 리스트

        # 1 ~ 99까지는 list_hansu에 추가하기
        if i < 100 :
            list_hansu.append(i)
            continue
        
        # 각 자리수 추출해서 임시 리스트에 넣기
        while True :
            if i == 0 : # 추가할 수가 없으면 종료
                break
            list_temp.append(i % 10)
            i = i // 10
        
        # 인덱스용 변수
        index = 0
        # list_temp의 값이 등차수열인지 확인
        while True :
            # 인덱스용 변수가 list_temp의 길이를 넘으면  비교를 못하니까 종료
            if len(list_temp) - 1 < index + 2:
                list_hansu.append(temp)
                break
            
            # list_temp의 값들을 비교해서 같으면 등차수열이라서 list_hansu에 넣기
            if list_temp[index] - list_temp[index + 1] == list_temp[index + 1] - list_temp[index + 2] :
                index = index + 1
            
            # 일치하지 않으면 종료        
            elif list_temp[index] - list_temp[index + 1] != list_temp[index + 1] - list_temp[index + 2] :
                break
            
    # 리스트 반환           
    return list_hansu

n = int(input())
list_temp = han(n)
print(len(list_temp))