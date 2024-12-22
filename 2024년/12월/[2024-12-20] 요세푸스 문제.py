# 요세푸스 문제
# sol1 - deque 사용
import sys
from collections import deque

# 입력 받기
n, k = map(int, input().split())

# 양방향 연결 리스트(deque) 생성
dq = deque([i for i in range(1, n + 1)])

# 요세푸스 순열 생성
lst = []
while len(dq) != 0:
    for _ in range(k - 1):
        # k-1번째 노드까지 dq맨 뒤로 이동
        dq.append(dq.popleft())
    # k번째 노드 삭제 후 결과 배열에 추가
    lst.append(str(dq.popleft()))


# 결과 출력
print('<'+', '.join(lst)+'>')

# sol2
import sys

# 입력 받기
n, k = map(int, sys.stdin.readline().split())

# 요세푸스 순열 생성
idx = 0
queue = [i for i in range(1, n + 1)]
lst = []
while queue:
    # k-1번째 인덱스까지 건너뛰기
    idx += k - 1
    # 인덱스가 범위를 넘어갈 경우
    if idx >= len(queue):
        # 나머지 연산을 통해 인덱스 계산
        idx %= len(queue)
    # k번째 수 제거 후 결과 배열에 추가
    lst.append(str(queue.pop(idx)))

# 결과 출력
print('<'+', '.join(lst)+'>')