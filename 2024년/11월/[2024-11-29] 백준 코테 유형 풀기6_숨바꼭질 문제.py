# 숨바꼭질 문제
import sys
from collections import deque
input = sys.stdin.readline()

n, k = map(int, input.split())
MAX = 100000
dist = [0] * (MAX + 1)
def bfs():
    q = deque()
    q.append(n)
    while q:
        x = q.popleft()
        if x == k:
            print(dist[x])
            break

        for i in (x - 1, x + 1, x * 2):
            if 0 <= i <= MAX and not dist[i]:
                dist[i] = dist[x] + 1
                q.append(i)

bfs()