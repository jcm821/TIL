# 컨베이어 벨트 위의 로봇 문제
from sys import stdin
from collections import deque

def solution(N, K, A):
    answer = 0
    belt = deque([False] * N)

    while True:
        answer += 1

        # 1. 벨트가 각 칸 위에 있는 로봇과 함께 한 칸 회전
        A.rotate(1)
        belt.rotate(1)

        # 로봇이 내리는 위치에 도달하면 그 즉시 내린다.
        belt[N - 1] = False

        # 2. 가장 먼저 벨트에 올라간 로봇부터, 벨트가 회전하는 방향으로 한 칸 이동할 수 있다면 이동
        for i in range(N - 2, -1, -1):
            # 2-1. 로봇이 이동하기 위해서는 이동하려는 칸에 로봇이 없으며, 그 칸의 내구도가 1이상 남아야함
            if belt[i] and not belt[i + 1] and A[i + 1] > 0:
                belt[i], belt[i + 1] = False, True
                A[i + 1] -= 1

        # 로봇이 내리는 위치에 도달하면 그 즉시 내린다.
        belt[N - 1] = False
        
        # 3. 올리는 위치에 있는 칸의 내구도가 0이 아니면 올리는 위치에 로봇을 올린다.
        if A[0] > 0:
            belt[i] = True
            A[0] -= 1

        # 4. 내구도가 0인 칸의 개수가 k개 이상이라면 과정 종료
        if A.count(0) >= K:
            break

    return answer

# input
N, K = map(int, stdin.readline().split())
A = deque(list(map(int, stdin.readline().split())))

# response
response = solution(N, K, A)
print(response)