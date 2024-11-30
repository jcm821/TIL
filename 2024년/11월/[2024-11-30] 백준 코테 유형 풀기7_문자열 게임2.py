# 문자열 게임2 문제
import sys
from collections import defaultdict

t = int(sys.stdin.readline())

# 테스트 케이스 수만큼 반복
for _ in range(t):
    string = sys.stdin.readline().rstrip()
    n = int(sys.stdin.readline())

    # key값이 없으면 빈 리스트라도 넣게함
    dic = defaultdict(list)

    for i in range(len(string)):
        # 개수가 n개 이상인 문자들에 대해서만
        if string.count(string[i]) >= n:
            # 문자별로 좌표 저장(ex [a]:[0, 4, 9])
            dic[string[i]].append(i)

    # n개 이상인 문자 없으면 아예 불가능
    if not dic:
        print(-1)
    else:
        # 최소를 일단 최대값으로 세팅
        small = 10000
        # 최대를 일단 최소값으로 세팅
        big = 1
        
        # dic에 있는 특정 문자 alpha에 대해
        for alpha in dic:
            # 특정문자의 개수 - 필요한 개수 + 1 만큼 가능
            for i in range(len(dic[alpha]) - n + 1):
                # 특정 문자의 좌표들간의 간격 + 1이 문자열의 길이가 됨
                length = dic[alpha][i + n - 1] - dic[alpha][i] + 1

                # 최소, 최대를 계속 최신화
                small = min(small, length)
                big = max(big, length)

        print(small, big)
