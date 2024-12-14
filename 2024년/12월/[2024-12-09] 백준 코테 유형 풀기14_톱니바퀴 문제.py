# 톱니바퀴 문제
import sys
from collections import deque
import copy
gears = []
for _ in range(4):
    gears_str = str(sys.stdin.readline().rstrip())
    gears.append(deque([int(i) for i in gears_str]))

K = int(sys.stdin.readline())
do = []
for i in range(K):
    do.append(list(map(int, sys.stdin.readline().split())))

# i = 2가 오른쪽, i = 6이 왼쪽

# 왼쪽 톱니바퀴가 돌아가는지 확인
def turn_left(num, l):
    if num < 0:
        return False
    if gears[num][2] != l:
        return True
    return False

def turn_right(num, r):
    if num > 3:
        return False
    if r != gears[num][6]:
        return True
    return False

def direction_turn(num, direction):
    if num > 3 or num < 0:
        return

    r, l = gears[num][2], gears[num][6]
    turn(num, direction)
    visited[num] = True
    if turn_right(num + 1, r) and visited[num + 1] == False:
        direction_turn(num + 1, -direction)
    if turn_left(num - 1, l) and visited[num - 1] == False:
        direction_turn(num - 1, -direction)
    return

# number는 회전시킬 톱니바퀴
def turn(num, direction):
    # 시계방향 오른쪽으로 한 칸
    if direction == 1:
        gears[num].rotate(1)
    # 반시계방향 왼쪽으로 한 칸
    else:
        gears[num].rotate(-1)

for num, direction in do:
    visited = [False for _ in range(4)]
    direction_turn(num - 1, direction)
answer = 0

if gears[0][0] == 1:
    answer += 1
if gears[1][0] == 1:
    answer += 2
if gears[2][0] == 1:
    answer += 4
if gears[3][0] == 1:
    answer += 8
print(answer)