import cv2
import numpy as np
import random
# 주사위를 던지는 것을 별도의 리스트에 저장
# 출력결과를 3개씩 나오게 하기
# 이미지 불러오기
img1 = cv2.imread('./data/dice1.jpg')
img2 = cv2.imread('./data/dice2.jpg')
img3 = cv2.imread('./data/dice3.jpg')
img4 = cv2.imread('./data/dice4.jpg')
img5 = cv2.imread('./data/dice5.jpg')
img6 = cv2.imread('./data/dice6.jpg')

imgList = [img1, img2, img3, img4, img5, img6]
winName = ['1st', '2nd', '3rd']
while True:
    diceNum = []
    for i in range(3):
        diceNum.append(random.randrange(1, 7))
    # print(diceNum)
    for i, name in enumerate(winName):
        cv2.imshow(name, imgList[diceNum[i] -1])
        # 윈도우 창 위치 조절
        cv2.moveWindow(name, 100+(i*170), 100)
    key = cv2.waitKey(0)
    if key == ord('x'):
       break
# 모든 창 닫기
cv2.destroyAllWindows()
