from django.http import HttpResponse
import pandas as pd
# django 가상환경에서 cx_Oracle 설치해야 합니다.
# 설치 : 가상환경 프롬프트 > pip install cx_oracle
import cx_Oracle


# 오라클 연결 및 접속하기
def getConnection() :
    # 오라클 연결하기
    dsn = cx_Oracle.makedsn("localhost", 1521, "orcl")
    
    # 오라클 접속하기
    conn = cx_Oracle.connect("busan_06", "dbdb", dsn)
    return conn

# 커서 받기
def getCursor(conn) :
    cursor = conn.cursor()
    return cursor

# 접속 정보 및 커서 반납하기
def dbClose(cursor, conn) :
    # 커서 반납 먼저
    cursor.close()
    # 마지막에 접속정보 반납
    conn.close()
    
############################

# 주문내역 전체 리스트 조회
def getDBTest():
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ Select * From cart """
    cursor.execute(sql)
    
    row = cursor.fetchall()
    
    # # 컬럼명 조회하기
    # colname = cursor.description
    # col = []
    # for i in colname :
    #     col.append(i[0])

    # # 딕셔너리로 데이터 구성하기..
    # row_list = getDictType_FetchAll(col, row)
    
    dbClose(cursor, conn)
    
    return row


## survey 테이블 생성하기
def createTableSurvey() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """Create Table survey
            (
                rnum number(15) not null,
                gender varchar2(20) not null,
                age number(15) not null,
                co_survey varchar2(50) not null,
                Constraint pk_rnum Primary key (rnum)
            )"""

    cursor.execute(sql)
    dbClose(cursor, conn)
    
    
# 설문 입력하기
def setSurveyInsert(pgender, page, pco_survey) :
    conn = getConnection()
    cursor = getCursor(conn)
    
    # rnum 자동 생성하기...
    sql = """Select nvl(max(rnum)+1, 1) as max_no
                From survey"""
    cursor.execute(sql)
    rs_max_no = cursor.fetchone()
    no = rs_max_no[0]
    
    # 저장하기...
    sql = """Insert Into survey(
                rnum, gender, age, co_survey
            ) values (
                :rnum, :gender, :age, :co_survey
            )"""
    cursor.execute(sql, 
                    rnum = no,
                    gender = pgender,
                    age = page,
                    co_survey = pco_survey)
    conn.commit()
    
    dbClose(cursor, conn)
    return "OK"


def getSurveyList() :
    conn = getConnection()
    cursor = getCursor(conn)
    
    sql = """ Select * From survey """
    cursor.execute(sql)
    
    row = cursor.fetchall()
    
    # 컬럼명 조회하기
    colname = cursor.description
    col = []
    for i in colname :
        col.append(i[0].lower())
    
    dbClose(cursor, conn)
    
    # 데이터 프레임에 조회 결과 넣기
    df = pd.DataFrame(row, columns = col)
    
    return df
    