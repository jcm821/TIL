# 게리맨더스2 문제

def boundary(x, y, d1, d2, tempGraph):
    for i in range(d1):
        tempGraph[x + i][y - i] = 5
    for i in range(1, d2+1):
        tempGraph[x + i][y + i] = 5
    for i in range(d2+1):
        tempGraph[x + d1 + i][y - d1 + i] = 5
    for i in range(1, d1+1):
        tempGraph[x + d2 + i][y + d2 - i] = 5
    return tempGraph

N = int(input())
total1to4 = 0
graph = [[0 for _ in range(N+1)]]
for i in range(1, N+1):
    data = [0] + (list(map(int, input().split())))
    total1to4 += sum(data)
    graph.append(data)
ans = int(10e9)
temp = []
for x in range(1, N):
    for y in range(1, N):
        for d1 in range(1, N+1):
            for d2 in range(1, N+1):
                tempGraph = [[0]*(N+1) for i in range(N+1)]
                result = [0,0,0,0,0]
                if x < x+d1+d2 <= N and 1 <= y-d1 < y < y+d2 <= N:
                    tempGraph = boundary(x, y, d1, d2, tempGraph)
                    # 1번 선거구
                    for i in range(1, x+d1):
                        for j in range(1, y+1):
                            if tempGraph[i][j] == 5:
                                break
                            result[0] += graph[i][j]
                            tempGraph[i][j] = 1
                    # 2번 선거구
                    for i in range(1, x+d2+1):
                        #for j in range(y+1, N+1):
                        for j in range(N, y, -1):
                            if tempGraph[i][j] == 5:
                                break
                            result[1] += graph[i][j]
                            tempGraph[i][j] = 2
                    # 3번 선거구
                    for i in range(x + d1, N+1):
                        for j in range(1, y-d1+d2):
                            if tempGraph[i][j] == 5:
                                break
                            result[2] += graph[i][j]
                            tempGraph[i][j] = 3
                    # 4번 선거구
                    for i in range(x+d2+1, N+1):
                        #for j in range(N, y + d2 - d1 -1, -1):
                        for j in range(N, y-d1+d2-1, -1):
                            if tempGraph[i][j] == 5:
                                break
                            result[3] += graph[i][j]
                            tempGraph[i][j] = 4
                    #5번 선거구 세기
                    result[4] = total1to4 - sum(result)
                    ans = min(ans, (max(result) - min(result)))
                    temp.append(ans)

print(ans)