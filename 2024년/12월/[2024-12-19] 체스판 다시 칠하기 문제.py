# 체스판 다시 칠하기 문제
n, m = map(int, input().split())

mtr = []
cnt = []
for _ in range(n):
    mtr.append(input())

for a in range(n - 7):
    for b in range(m - 7):
        # 흰색으로 시작
        w_index = 0
        # 검은색으로 시작
        b_index = 0
        # 8x8 영역 확인
        for i in range(a, a + 8):
            for j in range(b, b + 8):
                # 짝수 칸
                if (i + j) % 2 == 0:
                    if mtr[i][j] != 'W':
                        w_index += 1
                    else:
                        b_index += 1
                # 홀수 칸
                else:
                    if mtr[i][j] != 'B':
                        w_index += 1
                    else:
                        b_index += 1

        # W로 시작할 때 경우의 수
        cnt.append(w_index)
        # B로 시작할 때 경우의 수
        cnt.append(b_index)

print(min(cnt))