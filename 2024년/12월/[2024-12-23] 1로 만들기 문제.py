# 1로 만들기 문제
# sol1 - BFS
import sys
from collections import deque

n = int(sys.stdin.readline())
visited = [0 for i in range(n + 1)]

def bfs():
    q = deque()
    q.append(n)
    while q:
        cur = q.popleft()
        if cur == 1:
            break
        if cur%3 == 0 and visited[cur // 3] == 0:
            visited[cur // 3] = visited[cur] + 1
            q.append(cur // 3)
        if cur%3 == 0 and visited[cur // 2] == 0:
            visited[cur // 2] = visited[cur] + 1
            q.append(cur // 2)
        if visited[cur - 1] == 0:
            visited[cur - 1] = visited[cur] + 1
            q.append(cur - 1)

bfs()
print(visited[1])


# sol2 - DP
import sys
n = int(sys.stdin.readline())
d = [0] * (n + 1)

for i in range(2, n + 1):
    d[i] = d[i - 1] + 1

    if i % 2 == 0:
        d[i] = min(d[i], d[i // 2] + 1)
    if i % 3 == 0:
        d[i] = min(d[i], d[i // 3] + 1)

print(d[n])