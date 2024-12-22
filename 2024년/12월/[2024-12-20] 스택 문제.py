# 스택 문제
import sys
input = sys.stdin.readline

# 명령어의 개수 입력
n = int(input())

# 명령어 입력
lst = [input() for _ in range(n)]

# 스택 초기화
stack = []

# 각 명령어 수행
for l in lst:
    if 'push' in l.split()[0]:
        stack.append(int(l.split()[1]))
    elif 'top' in l:
        # 스택이 비어있지 않으면 스택의 가장 위의 값을 출력
        # 스택이 비어있으면 -1 출력
        print(stack[-1]) if stack else print(-1)
    elif 'size' in l:
        print(len(stack))
    elif 'empty' in l:
        print(0) if stack else print(1)
    elif 'pop' in l:
        # 스택이 비어있지 않으면 가장 위의 값을 스택에서 빼내어 출력
        # 스택이 비어있으면 -1 출력
        print(stack.pop()) if stack else print(-1)