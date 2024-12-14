import sys
from collections import deque


def roll_dice(dice, direction):
    n_dice = [0] * 6
    # 동, 남, 서, 북 순으로 굴림
    if direction == 0:
        n_dice[0] = dice[3]
        n_dice[1] = dice[1]
        n_dice[2] = dice[0]
        n_dice[3] = dice[5]
        n_dice[4] = dice[4]
        n_dice[5] = dice[2]
    elif direction == 1:
        n_dice[0] = dice[1]
        n_dice[1] = dice[5]
        n_dice[2] = dice[2]
        n_dice[3] = dice[3]
        n_dice[4] = dice[0]
        n_dice[5] = dice[4]
    elif direction == 2:
        n_dice[0] = dice[2]
        n_dice[1] = dice[1]
        n_dice[2] = dice[5]
        n_dice[3] = dice[0]
        n_dice[4] = dice[4]
        n_dice[5] = dice[3]
    elif direction == 3:
        n_dice[0] = dice[4]
        n_dice[1] = dice[0]
        n_dice[2] = dice[2]
        n_dice[3] = dice[3]
        n_dice[4] = dice[5]
        n_dice[5] = dice[1]
    return n_dice


#  동, 남, 서, 북
dx = [0, 1, 0, -1]
dy = [1, 0, -1, 0]

N, M, K = map(int, sys.stdin.readline().rstrip().split())

board = [list(map(int, sys.stdin.readline().rstrip().split())) for _ in range(N)]
answer = 0

now_dice = [1, 2, 3, 4, 5, 6]
now_dice_x = 0
now_dice_y = 0
now_dir = 0

turn = 0
while turn < K:
    # 주사위 굴러감
    new_dice_x = now_dice_x + dx[now_dir]
    new_dice_y = now_dice_y + dy[now_dir]

    if new_dice_x < 0 or new_dice_y < 0 or new_dice_x >= N or new_dice_y >= M:
        now_dir = (now_dir + 2) % 4
        continue

    turn += 1

    new_dice = roll_dice(now_dice, now_dir)
    # 굴러간 자리 기준으로 동서남북 탐색해서 해당 위치에서의 점수 구함
    que = deque()
    is_visited = [[False for _ in range(M)] for _ in range(N)]

    que.append([new_dice_x, new_dice_y])
    is_visited[new_dice_x][new_dice_y] = True
    cnt = 1
    while que:
        now_x, now_y = que.popleft()

        for t in range(4):
            n_x = now_x + dx[t]
            n_y = now_y + dy[t]

            if n_x < 0 or n_y < 0 or n_x >= N or n_y >= M:
                continue
            if is_visited[n_x][n_y] or board[n_x][n_y] != board[new_dice_x][new_dice_y]:
                continue
            que.append([n_x, n_y])
            is_visited[n_x][n_y] = True
            cnt += 1
	# 점수를 구하고 더함
    answer += cnt * board[new_dice_x][new_dice_y]
    # 방향 다시 맞춤
    if board[new_dice_x][new_dice_y] < new_dice[5]:
        now_dir = (now_dir + 1) % 4
    elif board[new_dice_x][new_dice_y] > new_dice[5]:
        now_dir = now_dir - 1
        if now_dir < 0:
            now_dir = 3
	
    # 다음 반복문에 사용하기 위해 변수 갱신
    now_dice_x = new_dice_x
    now_dice_y = new_dice_y
    now_dice = new_dice
    # 반복

print(answer)