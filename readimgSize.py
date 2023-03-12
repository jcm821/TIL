# 이미지의 크기가 다 다른 이미지를 가져와서 이미지가 640X480보다 크면 사이즈를 줄이고
# 그것보다 작다면 원본 그대로 출력

# 이미지의 크기를 가져오는 방법
# 이미지를 줄이는 방법

import cv2
import numpy as np

# 이미지 불러오기
img1 = cv2.imread('./data/dogLarge.jpg')
# shape정보에서 (세로길이, 가로길이, 색) 순이다
imgSize = img1.shape
# print(imgSize)
# print(type(imgSize))
# 튜플형태의 데이터 인덱스 보기
# print(imgSize[0], imgSize[1])
# if imgSize[0] > 480 or imgSize[1] > 640:
    # 이미지 줄이기(원본 사이즈를 무조건 640,480
img1 = cv2.resize(img1, dsize=(640, 480), interpolation=cv2.INTER_AREA)

cv2.imshow('img', img1)

cv2.waitKey(0)
cv2.destoryAllWindows()