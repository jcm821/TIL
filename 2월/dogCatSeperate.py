# 1. 이미지가 저장된 폴더 문자열 변수 생성
srcPath = 'C:/Users/chunc/PycharmProjects/pythonEx1/train/train/'
# src_path = 'C:\\Users\\chunc\\PycharmProjects\\pythonEx1\\train\\train'

import os, shutil
# srcPath의 파일목록을 읽어온다.
filenames = os.listdir(srcPath)
print(filenames)

# 폴더의 파일 개수 확인
print(len(filenames))

# dog 폴더와 cat폴더를 생성
dirname1 = srcPath+'dog'
os.makedirs(dirname1, exist_ok = True)

dirname2 = srcPath+'cat'
os.makedirs(dirname2, exist_ok = True)

# glob모듈을 사용하여 jpg파일만 골라낼 수 있음(찾고자하는 확장자의 파일만 필터링 할 수 있음)
import glob

jpgFile = glob.glob(srcPath+"*.jpg")
print(jpgFile)
# print(len(jpgFile))
for src in jpgFile:
    # basename이라는 메서드로  파일전체 경로를 삭제하고
    # 파일명(cat.0.jpg)만 남겨주는 함수이다
    # cat.0.jpg의 파일명을 baseFileName이라는 변수에 저장
    baseFileName = os.path.basename(src)
    # 파일명에서 'cat', 'dog'만 추출한다
    # cat, dog은 category로, '0'은 첫번째 _에, jpg는 두번째 _에 할당된다
    category,_,_ = baseFileName.split('.')

    # srcPath - 'C:/Users/chunc/PycharmProjects/pythonEx1/train/train/'
    # category - cat
    # baseFileName - cat.0.jpg
    # 다 합쳐서 'C:/Users/chunc/PycharmProjects/pythonEx1/train/train/cat/cat.0.jpg'를 dst변수에 저장
    dst = srcPath + category+'/' + baseFileName
    # 파일을 이동한다.
    # src = 'C:/Users/chunc/PycharmProjects/pythonEx1/train/train/cat.0.jpg'에서
    # dst = 'C:/Users/chunc/PycharmProjects/pythonEx1/train/train/cat/cat.0.jpg'으로 이동한다
    shutil.move(src, dst)

    # 숙달을 위한 코드실햏 시에는 shutil.copy함수를 사용하는 것이 용이하다