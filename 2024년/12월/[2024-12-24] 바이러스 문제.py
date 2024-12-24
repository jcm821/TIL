# 바이러스 문제
import sys
from collections import deque
n = int(sys.stdin.readline())
m = int(sys.stdin.readline())
net = [[] for _ in range(n + 1)]
for _ in range(m):
    a, b = map(int, sys.stdin.readline().split())
    net[a].append(b)
    net[b].append(a)

def bfs():
    q = deque()
    # 감염된 컴퓨터 수
    count = 0
    # 1번 컴퓨터로부터 시작
    q.append(1)
    # 1번 컴퓨터 감염완료
    visited[1] = True
    while q:
        cur = q.popleft()
        # 감염된 컴퓨터로부터 연결된 컴퓨터들에서
        for i, val in enumerate(net[cur]):
            # 감염되지 않았다면
            if visited[val] == False:
                # 감염리스트 추가
                q.append(val)
                # 감염완료
                visited[val] = True
                # 감염된 컴퓨터 수 1 증가
                count += 1
    print(count)

visited = [False for _ in range(n + 1)]
bfs()