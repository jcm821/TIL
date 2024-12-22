# 이항계수1 문제
import sys
# sol1
# 팩토리얼 반복문 활용
input = sys.stdin.readline
n, k = map(int, input().split())

result = 1
for i in range(k):
    result *= n
    n -= 1

div = 1
for i in range(2, k + 1):
    div *= i

print(result // div)

# sol2
# 팩토리얼 재귀함수 사용
input = sys.stdin.readline
n, k = map(int, input().split())

def factorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return n * factorial(n - 1)

# 조합 공식 nCk = n!/(n-k)!k!
print(factorial(n) // (factorial(n-k) * factorial(k)))