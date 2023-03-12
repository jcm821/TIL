# 구구단을 출력 -> 화면X, 문자열로 생성하고, csv로 저장
# 컬럼의 개수는 16개
# 구조 이해를 위한 2단만 출력
# def guguDan(dan):
#     for i in range(1, 10):
#         print('{} X {}'.format(dan, i), dan*i)
# g2 = guguDan(2)
# print(g2)
# 2단만 출력하는 예시
# def multiTables(dan):
#     danStrList = []
#     danResultList = []
#
#     for i in range(1, 10):
#         danStrList.append('{} X {}'.format(dan, i))
#         danResultList.append(dan * i)
#
#
#     return danStrList, danResultList
# # 확인
# strList, resultList = multiTables(2)
# print(strList)
# print(resultList)

def multiTables(dan):
    danStrList = []
    danResultList = []

    for i in range(1, 10):
        danStrList.append('{} X {}'.format(dan, i))
        danResultList.append(dan * i)


    return danStrList, danResultList
# 확인
strList, resultList = multiTables(2)
# print(strList)
# print(resultList)
# 데이터프레임 생성
import pandas as pd
# gugudan_df = pd.DataFrame(data = {'2 Times': pd.Series(strList), '2 Result': pd.Series(resultList)})
# print(gugudan_df)

for dan in range(2, 10):
    strList, resultList = multiTables(dan)
    # 메모리공간이 새롭게 할당되는지 확인
    # print(id(strList))
    # 컬럼명 설정
    colName1 = '{} Times'.format(dan)
    colName2 = '{} Result'.format(dan)
    # 데이터프레임 생성: 2단에서만 한번 생성한다
    if dan == 2:
        gugudan_df = pd.DataFrame(data={colName1 : pd.Series(strList),colName2 :pd.Series(resultList)})

    else:
        # 데이터프레임에 컬럼을 추가할때
        gugudan_df[colName1] = strList
        gugudan_df[colName2] = resultList



print(gugudan_df)

# 데이터프레임 csv파일로 저장
gugudan_df.to_csv('gugudan.csv')