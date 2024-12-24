# 구간 합 구하기4 문제
import sys
input = sys.stdin.readline
n, m = map(int, input().split())
arr = list(map(int, input().split()))

sum_list = [0]
total = 0
for i in range(len(arr)):
    total += arr[i]
    sum_list.append(total)

for _ in range(m):
    i, j = map(int, input().split())
    print(sum_list[j] - sum_list[i - 1])