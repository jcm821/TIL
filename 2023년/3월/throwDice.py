import cv2
import numpy as np
import random
# 이미지 불러오기
img1 = cv2.imread('./data/dice1.jpg')
img2 = cv2.imread('./data/dice2.jpg')
img3 = cv2.imread('./data/dice3.jpg')
img4 = cv2.imread('./data/dice4.jpg')
img5 = cv2.imread('./data/dice5.jpg')
img6 = cv2.imread('./data/dice6.jpg')

imgList = [img1, img2, img3, img4, img5, img6]
# for img in imgList:
# 무한으로 실행하고자 하면 while문 사용
while True:
    diceNum = random.randrange(1, 7)
    print(diceNum)
    # 이미지 화면에 출력
    # imshow('창 이름', '출력할 배열')
    # imgList의 인덱스는 0부터이므로 -1을 해주어야 한다
    cv2.imshow('img', imgList[diceNum - 1])
    
    # 원래 waitKey함수는 일정시간 키입력을 기다리는 함수인데
    # 입력값이 0이면 키 입력이 들어올때 까지 대기한다
    key = cv2.waitKey(0)
    # 입력된 키값을 ASCII값으로 반환해준다
    # print(key)
    # 문자열 키값을 유니코드형태로 반환해준다
    if key == ord('x'):
        break
# 모든 창 닫기
cv2.destroyAllWindows()
