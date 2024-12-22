# 좌표 정렬하기
import sys
n = int(input())
lst = []
for i in range(n):
    a, b = map(int, sys.stdin.readline().split())
    lst.append([a, b])
lst.sort()
for i in lst:
    print(i[0], i[1])