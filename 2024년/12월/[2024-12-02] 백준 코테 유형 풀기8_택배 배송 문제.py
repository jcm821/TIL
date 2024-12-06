# 택배 배송 문제
import sys
from heapq import heappush, heappop
input = sys.stdin.readline

inf = 1e9
n, m = map(int, input().split())
dist = [inf] * (n + 1)
dist[1] = 0
graph = [[] for _ in range(n + 1)]

for _ in range(m):
    a, b, c = map(int, input().split())
    graph[a].append((b, c))
    graph[b].append((a, c))

hq = []
heappush(hq, (0, 1))
while hq:
    vd, v = heappop(hq)
    if vd < dist[v]:
        continue

    for (t, d) in graph[v]:
        if vd + d < dist[t]:
            dist[t] = vd + d
            heappush(hq, (vd + d, t))
print(dist[-1])