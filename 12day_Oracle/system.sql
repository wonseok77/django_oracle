--1. cmd 창 열기
--
--2. sqlplus /nolog 입력 엔터
--
--SQL>conn /as sysdba
--
--SQL>alter user system identified by 새로운암호;
--SQL>alter user sys identified by 새로운암호;
--
--SQL>conn system/새로운암호
--
---- 접속확인
--SQL>show user

-- 오라클 12버전 이상부터는 아래를 실행해야
-- 일반적인 구분 작성이 가능함
Alter session set "_ORACLE_SCRIPT"=true;

-- 위에 실행은 최초 한 번 실행
-- 위에 실행 안하면 아래처럼 구문을 작성해야함
Create User c##busan_06 Identified by dbdb;

-- 1. 사용자 생성하기
Create User busan_06 
    Identified By dbdb;

-- 패스워드 수정하기
Alter User busan_06
    IDENTIFIED BY 수정패스워드;
    
-- 사용자 삭제하기
Drop User busan_06;
    
-- 2. 권한부여하기
Grant Connect, Resource, DBA To busan_06;

-- 3. 권한회수하기
Revoke DBA From busan_06;
