# 프로그램의 입력과 출력
import sys

args = sys.argv[1:]
# args = sys.argv
print(args)
# for i in args:
#     print(i)

result = int(args[0]) + int(args[1])
print(result)

# 나중에 django 서버 포트번호를 바꾸거나 외부 접속 허용할 때 유용하게 사용