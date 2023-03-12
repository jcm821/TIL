# 주사위의 눈금의 합이 10일때만 화면에 출력
# 주사위를 2개만 돌렸을경우
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
winList = ['1st', '2nd', '3rd']

while True:
    diceNum = []
    for i in range(3):
        diceNum.append(random.randrange(1, 7))

    if sum(diceNum) == 10:
        for i, name in enumerate(winList):
            cv2.imshow(name, imgList[diceNum[i] - 1])
            cv2.moveWindow(name, 100+(i*170), 100)

        key = cv2.waitKey(0)
        if key == ord('x'):
            break
cv2.destroyAllWindows()