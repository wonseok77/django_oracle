--1. cmd â ����
--
--2. sqlplus /nolog �Է� ����
--
--SQL>conn /as sysdba
--
--SQL>alter user system identified by ���ο��ȣ;
--SQL>alter user sys identified by ���ο��ȣ;
--
--SQL>conn system/���ο��ȣ
--
---- ����Ȯ��
--SQL>show user

-- ����Ŭ 12���� �̻���ʹ� �Ʒ��� �����ؾ�
-- �Ϲ����� ���� �ۼ��� ������
Alter session set "_ORACLE_SCRIPT"=true;

-- ���� ������ ���� �� �� ����
-- ���� ���� ���ϸ� �Ʒ�ó�� ������ �ۼ��ؾ���
Create User c##busan_06 Identified by dbdb;

-- 1. ����� �����ϱ�
Create User busan_06 
    Identified By dbdb;

-- �н����� �����ϱ�
Alter User busan_06
    IDENTIFIED BY �����н�����;
    
-- ����� �����ϱ�
Drop User busan_06;
    
-- 2. ���Ѻο��ϱ�
Grant Connect, Resource, DBA To busan_06;

-- 3. ����ȸ���ϱ�
Revoke DBA From busan_06;
