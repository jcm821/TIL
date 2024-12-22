# 큐 문제
# sol1 - stack 이용
import sys

n = int(sys.stdin.readline().strip())

stack = []
for i in range(n):
    cmd = sys.stdin.readline().strip().split()
    if cmd[0] == 'push':
        stack.append(cmd[1])
    elif cmd[0] == 'pop':
        if len(stack) != 0:
            print(stack.pop(0))
        else:
            print(-1)
    elif cmd[0] == 'size':
        print(len(stack))
    elif cmd[0] == 'empty':
        if len(stack) == 0:
            print(1)
        else:
            print(0)
    elif cmd[0] == 'front':
        if len(stack) != 0:
            print(stack[0])
        else:
            print(-1)
    elif cmd[0] == 'back':
        if len(stack) != 0:
            print(stack[-1])
        else:
            print(-1)


# sol2 - queue 이용
from collections import deque
import sys

N = int(sys.stdin.readline().strip())

dq = deque()

for i in range(N):
    cmd = sys.stdin.readline().strip().split()
    if cmd[0] == 'push':
        dq.append(cmd[1])
    elif cmd[0] == 'pop':
        if len(dq) != 0:
            print(dq.popleft())
        else:
            print(-1)
    elif cmd[0] == 'size':
        print(len(dq))
    elif cmd[0] == 'empty':
        if len(dq) == 0:
            print(1)
        else:
            print(0)
    elif cmd[0] == 'front':
        if len(dq) != 0:
            print(dq[0])
        else:
            print(-1)
    elif cmd[0] == 'back':
        if len(dq) != 0:
            print(dq[-1])
        else:
            print(-1)