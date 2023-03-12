for dan in range(2,10):
    strList, resultList = multiTables(dan)

    colName1 = "{} Times".format(dan)
    colName2 = "{} Result".format(dan)
    # 데이터프레임 생성 : 2단에서만 한번 생성
    if dan==2:
        gugudan_df = pd.DataFrame(data={colName1 : pd.Series(strList),colName2 :pd.Series(resultList)})
    else:
        # 데이터프레임에 컬럼을 추가
        gugudan_df[colName1] = strList
        gugudan_df[colName2] = resultList

#print(gugudan_df)
gugudan_df.to_csv("gugudan.csv")