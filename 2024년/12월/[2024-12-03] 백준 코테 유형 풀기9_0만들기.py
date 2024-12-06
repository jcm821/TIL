# 0만들기
import sys
input = sys.stdin.readline

def dfs(n, idx, rst):
    if idx == N:
        # eval 함수를 활용하여 문자열 상태에서 연산이 가능하도록함
        ans = eval(rst.replace(' ', ''))
        # 연산 결과가 0이면 정답 리스트에 추가
        if ans == 0:
            ans_sik.append(rst)
        return

    else:
        n_idx = idx + 1
        # 공백인 경우 숫자를 이어붙이기
        dfs(n, n_idx, rst + ' ' + str(n_idx))
        # +인 경우 더하기
        dfs(n, n_idx, rst + '+' + str(n_idx))
        # -인 경우 빼기
        dfs(n, n_idx, rst + '-' + str(n_idx))

T = int(input())
for _ in range(T):
    N = int(input())
    ans_sik = []
    dfs(N, 1, '1')
    for a in ans_sik:
        print(a)

    print()