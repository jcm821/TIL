import sys

N, L = map(int, sys.stdin.readline().split())

board = [list(map(int, sys.stdin.readline().split())) for _ in range(N)]

def check(line, L):
    # 경사로 생기는 곳 체크
    visited = [False for _ in range(N)]
    # 자리 차례로 탐색
    for i in range(0, N-1):
        # 바로 다음 위치의 높이가 같으면 continue
        if line[i] == line[i+1]:
            continue
        # 다음 위치의 높이 차이가 1 넘게 나면 False
        elif abs(line[i]-line[i+1]) > 1:
            return False
        # 현재 높이가 다음 높이 보다 높으면 오른쪽 높이가 같은지 체크
        elif line[i] > line[i+1]:
            temp = line[i+1] # 다음 높이
            for j in range(i+1, i+L+1):
                # 경사 길이가 범위 안이면
                if 0 <= j < N:
                    # 경사 놓을 위치의 높이가 하나라도 다르면
                    if temp != line[j]:
                        return False
                    # 높이는 다 같은데 이미 경사가 놓여진 곳이면
                    elif visited[j]:
                        return False
                    # 경사 놓기
                    visited[j] = True
                # 경사 길이가 범위 벗어나면
                else:
                    return False
        # 다음 높이가 현재 높이 보다 높으면 왼쪽 높이가 같은지 체크
        else:
            temp = line[i]
            for j in range(i, i-L, -1):
                # 경사 길이가 범위 안이면
                if 0 <= j < N:
                    # 경사 놓을 위치의 높이가 하나라도 다르면
                    if temp != line[j]:
                        return False
                    # 높이는 다 같은데 이미 경사가 놓여진 곳이면
                    elif visited[j]:
                        return False
                    # 경사 놓기
                    visited[j] = True
                # 경사 길이가 범위 벗어나면
                else:
                    return False
    return True

answer = 0
# 가로 길 체크
for i in board:
    if check(i, L):
        answer += 1

# 세로 길을 체크하기 위해 변환해서 넣어줌
for i in range(N):
    temp = []
    for j in range(N):
        temp.append(board[j][i])
    if check(temp, L):
        answer += 1

print(answer)