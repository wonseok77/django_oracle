CREATE TABLE Iprod
(
    Iprod_id number(5) NOT NULL, -- ��ǰ�з��ڵ�
    Iprod_gu char(4) NOT NULL,   -- ��ǰ�з�
    Iprod_nm varchar2(40) NOT NULL, -- ��ǰ�з���
    Constraint pk_Iprod Primary Key (Iprod_gu)
    );

Select * 
From Iprod;


INSERT INTO Iprod (Iprod_id, Iprod_gu, Iprod_nm) 
VALUES (1, 'P101', '��ǻ����ǰ');
INSERT INTO Iprod (Iprod_id, Iprod_gu, Iprod_nm) 
VALUES (1, 'P102', '��ǻ����ǰ');

    
select Iprod_gu, Iprod_nm
from Iprod;

--�ֹ��������� ���̺�
Select *
From cart;


-- �ŷ�ó���� ���̺�
Select *
From buyer;


--ȸ�� ���̺��� ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�..
Select MEM_ID, MEM_NAME FROM MEMBER;

-- ��ǰ�ڵ�� ��ǰ�� �Ǹűݾ� ��ȸ�ϱ�..
-- ��, �Ǹűݾ� = �ǸŰ� * 55�� ����ؼ� ��ȸ�մϴ�
-- �Ǹűݾ��� 4�鸸 �̻��� �����͸� ��ȸ�ϱ�
-- ������ �Ǹűݾ��� �������� ��������
Select PROD_ID, PROD_NAME,(PROD_SALE*55) as sale
FROM PROD
WHERE (PROD_SALE * 55) >= 4000000
ORDER BY sale DESC;

-- ��ǰ�������� �ŷ�ó�ڵ带 ��ȸ�� �ּ���...
-- ��, �ߺ��� �����ϰ� ��ȸ���ּ���
Select Distinct prod_buyer 
FROM prod;


-- ��ǰ�߿� �ǸŰ����� 17������ ��ǰ ��ȸ�ϱ�...
select prod_id,prod_price
from prod
WHERE prod_price = 170000;

-- ��ǰ�߿� �ǸŰ����� 17������ �ƴ� ��ǰ ��ȸ�ϱ� ..
select prod_id,prod_sale
from prod
WHERE prod_sale != 170000;


-- ��ǰ�߿� �ǸŰ����� 17���� �̻��̰� 20���� ������ ��ǰ ��ȸ�ϱ�..
select prod_id,prod_sale
from prod
WHERE prod_sale >= 170000 
  AND prod_sale <= 200000 ;
  
-- ��ǰ�߿� �ǸŰ����� 17���� �̻� �Ǵ� 20���� ������ ��ǰ ��ȸ�ϱ�..
select prod_id,prod_sale
from prod
WHERE prod_sale >= 170000 
  OR prod_sale <= 200000 ;

-- ��ǰ �ǸŰ����� 10���� �̻��̰�,,,
-- ��ǰ �ŷ�ó(���޾�ü) �ڵ尡 P30203 �Ǵ� P10201 ��
-- ��ǰ�ڵ�, �ǸŰ���, ���޾�ü �ڵ� ��ȸ�ϱ�...
select prod_id, prod_sale,prod_buyer
from prod
where prod_sale>= 100000
and (prod_buyer = 'P30203' or prod_buyer='P10201');

select prod_id, prod_sale,prod_buyer
from prod
where prod_sale>= 100000
and prod_buyer in ('P30203','P10201');


select *
from buyer
where buyer_id in ( select Distinct prod_buyer from prod);


select *
from buyer
where buyer_id Not in (select distinct prod_buyer from prod);


-- �ѹ��� �ֹ��� ���� ���� ȸ�� ���̵�, �̸��� ��ȸ�� �ּ���...
select mem_id , mem_name
from member
where mem_id not in (select distinct cart_member  from cart);


-- ��ǰ�з� �߿� ��ǰ������ ���� �з��ڵ常 ��ȸ�� �ּ���...
select lprod_gu
from lprod
where  lprod_gu not in (select distinct prod_lgu from prod);



-- ȸ���� ���� �߿�  75����� �ƴ� ȸ�����̵�, ���� ��ȸ�ϱ�,
-- ������ ���� ���� ��������
SELECT MEM_ID, MEM_BIR
  FROM MEMBER
 WHERE MEM_BIR NOT BETWEEN '1975-01-01' AND '1975-12-31';


-- ȸ�� ���̵� a001�� ȸ���� �ֹ��� ��ǰ�ڵ带 ��ȸ�� �ּ���...
-- ��ȸ�÷��� ȸ�����̵�, ��ǰ�ڵ�
Select cart_member, cart_prod
From cart
Where cart_member = 'a001';


-- ������ ȸ���̸� ���� ��������
Select mem_id, mem_name, mem_like, mem_mileage
From member
Where mem_like = '����'
 And mem_mileage >= 1000
Order By  mem_name Asc;

-- ������ ȸ���� ������ ��̸� ������
-- ȸ�� ���̵�, ȸ���̸�, ȸ����� ��ȸ�ϱ�
Select mem_like
From member
Where mem_name = '������';


Select mem_id, mem_name, mem_like
From member
Where mem_like = (Select mem_like
                    From member
                    Where mem_name='������');


-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ�����, ��ǰ�� ��ȸ�ϱ�
-- ��Į�� ��������
Select cart_member, cart_no, cart_qty,
      (Select mem_name From member where mem_id = cart_member ) as name,
      (Select prod_name From prod where prod_id=cart_prod) as ��ǰ��
From cart;

-- a001 ȸ���� �ֹ��� ��ǰ�� ����
-- ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ�ϱ�
Select lprod_gu, lprod_nm 
From lprod
where lprod_gu in (Select prod_lgu
                    From prod
                    Where prod_id in (Select CART_PROD
                                        from cart
                                        Where cart_member = 'a001'));


-- �̻��� ��� ȸ���� �ֹ��� ��ǰ �߿�
-- ��ǰ�з��ڵ尡 P201�̰�,
-- �ŷ�ó�ڵ尡 P20101��
-- ��ǰ�ڵ�, ��ǰ���� ��ȸ�� �ּ���..
Select prod_id, prod_name
From prod
Where (prod_lgu = 'P201')
And (prod_buyer = 'P20101')
And prod_id in (
                Select cart_prod
                From cart
                where cart_member
                in (select mem_id
                    from member
                    where mem_name = '�̻���'));

Select prod_id, prod_name
From prod
Where prod_id in (Select cart_prod
                from cart
                where cart_member
                 in (Select mem_id
                        from member
                        Where mem_name = '�̻���'));



-- ��������(SubQuery) ����
-- (���1) Select ��ȸ Į�� ��ſ� ����ϴ� ���
--  : �����÷��� �����ุ ��ȸ

-- (���2) Where ���� ����ϴ� ���
-- In () : �����÷��� ������ �Ǵ� ������ ��ȸ ����
-- =     : �����÷��� �����ุ ��ȸ ����
-- 


SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
from prod
Where prod_name Like '��%';

SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
FROM prod
WHERE prod_name LIKE '_��%';

SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
FROM prod
WHERE prod_name like '%ġ';


SELECT mem_id, SUBSTR(mem_name,1,1) ����
FROM dual;

-- ��ǰ���̺��� ��ǰ���� ��° �ڸ����� �α��ڰ� 'Į��'�� ��ǰ��
-- ��ǰ�ڵ�, ��ǰ���� �˻��Ͻÿ�
Select Substr(prod_name, 4, 2) as subNm
From prod
Where Substr(prod_name, 4, 2) = 'Į��';

SELECT buyer_name, REPLACE(buyer_name, '��','��') "��>��"
FROM buyer;


SELECT Substr(REPLACE(mem_name,'��','��'),1,1) || Substr(mem_name, 2,3)
FROM member;

-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�.
-- ��,��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ�� ...
--      �׸���, ȸ���� ��̰� ������ ȸ�� ...
SELECT mem_id, mem_name
from member
where mem_id in (select cart_member 
                    from cart
                    where cart_prod in (select prod_id 
                                        from prod
                                        where prod_name like '%�Ｚ����%'
                                        and prod_lgu in(
                                            select lprod_gu
                                            from lprod
                                            where lprod_nm like '%����%')))
AND mem_like = '����';



SELECT mem_mileage,
    ROUND(mem_mileage/12,2),
    TRUNC(mem_mileage/12,2)
FROM member;

-- ȸ����ȸ, ����=1, ����=1 ���� ��ȸ
select mem_name, mod(substr(mem_regno2,1,1),2)
from member;



SELECT sysdate ,
        sysdate - 1 , sysdate + 1 
FROM dual;


select mem_bir, mem_bir + 12000
from member;


select add_months(sysdate,5) from dual;

select next_day(sysdate,'������'),
        last_day(sysdate)
From dual;

select last_day(sysdate)-sysdate
from dual;

select round(sysdate,'YYYY'),
       round(sysdate,'q')
from dual;

-- ��¥���� �ʿ��� �κи� ����

select extract(year from sysdate)"�⵵",
        extract(month from sysdate)"��",
     extract(day from sysdate)"��"
from dual;

-- ������ 3���� ȸ���� �˻��ϼ���
select mem_name
from member
where extract(month from mem_bir) = 3;


-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000.00-00-00 00/00/00,
select cast('1997/12/25' as date) from dual;

select '[' || CAST('Hello' as CHAR(30)) || ']' "����ȯ"
from dual;

select to_char(cast('2008-12-25' as date), 'YYYY.MM.DD HH24:MI')
from dual;


select to_char(cast(prod_insdate as date), 'YYYY_MM_DD') as �԰���
from prod;



select  mem_name || '���� ' ||  to_char(mem_bir,'yyyy') || '�� '
        || to_char(mem_bir,'mm') || '�� ����̰� �¾ ������ '
        || to_char(mem_bir, 'day')
from member;


select to_char(1234.6,'99,999.00'),
       to_char(1234.6,'9999.99'),
        to_char(1234.6,'999999.99')
from dual;

select to_char(-1234.6,'L9999.00PR'),
       to_char(-1234.6,'L9999.99PR')
from dual;

-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�
select prod_id, prod_name
from prod
where prod_id in (select cart_prod
                  from cart
                  where cart_member in (select mem_id
                                        from member
                                        where mod(substr(mem_regno2,1,1),2)=0))
                                        
and prod_lgu in (select lprod_gu 
                 from lprod 
                 where lprod_nm like '%����%')
                 
and prod_buyer in (select buyer_id
                    from buyer 
                    where substr(buyer_add1,1,2) ='����');
                    
-- 1. ���̺� ã��
--  - ���õ� Į������ �Ҽ� ã��
-- 2. ���̺� ���� ���� ã��
--  - ERD���� ����� ������� PK�� FK�÷� �Ǵ� ,
--  - ������ ���� ������ ������ �� �ִ� �÷� ã��
-- 3. �ۼ� ���� ���ϱ�
--  - ��ȸ�ϴ� �÷��� ���� ���̺��� ���� ��.. 1����..
-- - 1���� ���̺���� ERD ������� �ۼ�
-- - ������ : �ش� �÷��� ���� ���̺��� ���� ó��..



-- 3day
-- [��ȸ ��� ����]
-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��...
--      �׸���, ȸ���� ��̰� ������ ȸ��..

select mem_id, mem_name
from member
where mem_like = '����'
and mem_id in (select cart_member 
                 from cart
                 where cart_prod in (select prod_id
                                     from prod
                                     where prod_lgu in (select lprod_gu
                                                        from lprod
                                                        where lprod_nm like '%����%')
                                    and prod_name like '%�Ｚ����%'));


-- [����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�
-- �ŷ�ó�ڵ�, �ŷ�ó��, ���� (���� or ��õ ...), �ŷ�ó ��ȭ��ȣ ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ��� ...

select buyer_id, substr(buyer_add1,1,2) as add1 ,buyer_comtel
from buyer
where buyer_id in (select prod_buyer
                   from prod
                   where prod_id in (select cart_prod
                                     from cart
                                     where cart_member in (select mem_id
                                                            from member
                                                            where mem_name = '������')
                    and prod_lgu in (select lprod_gu
                                     from lprod
                                     where lprod_nm like '%ĳ�־�%')));


-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�..

select prod_id, prod_name
from prod
where prod_lgu in (select lprod_gu
                   from lprod
                   where lprod_nm like '%����%')
and prod_buyer in (select buyer_id
                     from buyer
                     where substr(buyer_add1,1,2) = '����')
and prod_id in (select cart_prod
                  from cart
                  where cart_member in (select mem_id
                                        from member
                                        where mod(substr(mem_regno2,1,1),2)=0));
                                        

-- ��ǰ ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����
select cart_prod as ��ǰ�ڵ�,
        max(cart_qty) as �ִ밪,
        min(cart_qty) as �ּҰ�,
        round(avg(cart_qty),2) as ��հ�,
        sum(cart_qty) as �հ�,
        count(cart_qty) as ����
from cart
group by cart_prod;


select *
from cart;

-- ������ 2005�⵵ 7�� 11�� �̶� �����ϰ� ��ٱ������̺� �߻���
-- �߰��ֹ���ȣ�� �˻��Ͻÿ�
-- ��ȸ Į�� : ���� ������ �ֹ���ȣ, �߰��ֹ���ȣ
select max(cart_no) as mno, Max(cart_no) +1 as npno 
from cart
where cart_no like '%20050711%';

-- ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�,
-- �ְ� ���ϸ���, �ּ� ���ϸ���, �ο����� �˻��Ͻÿ� 
select round(avg(mem_mileage),2) as ���ϸ������,
       sum(mem_mileage) as ���ϸ����հ�,
       max(mem_mileage) as �ְ��ϸ���,
       min(mem_mileage) as �ּҸ��ϸ���,
       count(mem_mileage) as �ο���
from member;


-- (����)
-- ��ǰ���̺��� �ŷ�ó��, ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ�� �ּ���..
-- ������ �ڷ���� �������� ��������
-- �߰���, �ŷ�ó��, ��ǰ�з��� ��ȸ ...
-- ��, �հ谡 100 �̻��� ��

select prod_buyer as �ŷ�ó,
       prod_lgu as ��ǰ�ڵ�,
       max(prod_sale) as �ְ�,
       count(prod_id) as �ڷ��,
       round(avg(prod_sale),2) as ���,
       sum(prod_sale) as �հ�,
       (select buyer_name from buyer where buyer_id = prod_buyer) as �ŷ�ó��,
       (select lprod_nm from lprod where lprod_gu = prod_lgu) as ��ǰ�з���
from prod, buyer
group by prod_buyer, prod_lgu
having sum(prod_sale) >= 100
order by �ڷ�� desc;


update buyer set buyer_charger = NULL
WHERE buyer_charger LIKE '��%';

update buyer set buyer_charger = ''
where buyer_charger like '��%';

select buyer_charger
from buyer
where buyer_charger is NOT Null;

SELECT buyer_name,
       NVL(buyer_charger, '����') as charger
FROM buyer;


select prod_lgu,
    DECODE( SUBSTR(prod_lgu,1,2),
            'P1', '��ǻ��/���� ��ǰ',
            'P2', '�Ƿ�',
            'P3', '��ȭ',
            '��Ÿ') as lgu_nm
from prod;


select prod_id, prod_name, prod_lgu
from prod
where EXISTS(
    select lprod_gu
    from lprod
    where lprod_gu = prod_lgu);
    
    
    
select * from lprod,prod;
select * from lprod cross join prod;


-- Inner join ����
-- PK�� FK�� �־�� �մϴ�.
-- �������� ���� : PK = FK
-- ���������� ���� : From���� ���õ� (���̺��� ���� - 1 ��)
select prod.prod_id
      ,prod.prod_name
      ,lprod.lprod_nm
From prod, lprod
where prod.prod_lgu = lprod.lprod_gu;



select prod.prod_id
      ,prod.prod_name
      ,lprod.lprod_nm
      ,buyer_name
      ,cart_qty
      ,mem_name
From prod, lprod, buyer, cart, member
where prod.prod_lgu = lprod.lprod_gu
and buyer_id = prod_buyer
and prod_id = cart_prod
and mem_id = cart_member
and mem_id = 'a001';


select prod_id, prod_name, lprod_nm, buyer_name, cart_qty, mem_name
from lprod inner join prod
           on (lprod_gu = prod_lgu)
           inner join buyer
           on (buyer_id = prod_buyer)
           inner join cart
           on (prod_id = cart_prod)
           inner join member
           on (mem_id = cart_member
            and mem_id = 'a001');


-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��,
-- �ŷ�ó�ּҸ� ��ȸ
-- 1) �ǸŰ����� 11���� ���� �̰�
-- 2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
-- �Ϲ�����, ǥ�ع��... ��� �غ���..

-- 1. ���̺� ã�� 
-- 2. �������ǽ� ã��
-- 3. ���� ���ϱ� ...
select prod_id, prod_name, lprod_nm, buyer_name
from prod, lprod, buyer
where prod_lgu = lprod_gu
and prod_buyer = buyer_id
and substr(buyer_add1,1,2) = '�λ�'
and prod_sale <= 110000;



select prod_id, prod_name, lprod_nm, buyer_name
from prod inner join lprod
           on (prod_lgu = lprod_gu
           and  prod_sale <= 110000)
           inner join buyer
           on (prod_buyer = buyer_id
           and substr(buyer_add1,1,2) = '�λ�');


-- (����)
-- ��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
-- ��, ��ǰ�з� �ڵ尡 P101, P201, P301 �� ��
--      ���Լ����� 15�� �̻��� ��
--      ���￡ ��� �ִ� ȸ�� �߿� ������ 1974����� ȸ��
-- ������ ȸ�����̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲݹ��, ǥ�ع��..

select lprod_nm, prod_name, buy_qty, cart_qty, buyer_name
from prod, lprod, buyer, cart, buyprod, member
where prod_lgu = lprod_gu
and prod_buyer = buyer_id
and prod_id = cart_prod
and prod_id = buy_prod
and mem_id = cart_member
and lprod_gu in ('P101','P201','P301')
and buy_qty >= 15
and substr(mem_bir,1,2) = 74
and substr(mem_add1,1,2)='����'
order by mem_id desc ,buy_qty asc;


select lprod_nm, prod_name, buy_qty, cart_qty, buyer_name
from prod inner join lprod
          on (prod_lgu = lprod_gu
          and lprod_gu in ('P101','P201','P301'))
          inner join buyer
          on (prod_buyer = buyer_id)
          inner join cart
          on (prod_id = cart_prod)
          inner join buyprod
          on (prod_id = buy_prod
          and buy_qty >= 15)
          inner join member
          on (mem_id = cart_member
          and mem_bir between '74/01/01' and '74/12/31'
          and mem_add1 like '����%')
order by mem_id desc ,buy_qty asc;




-- ��ǰ�̸��� ������ �������� �����ϴ� ��ǰ�� ������ �Ҹ��� ���ð� ����� �����ϼ���
-- �Ҹ������ð��� �ֹ��� - ������
-- �Ҹ��� ���ð��� 0 ������ ������ ����
-- ���ð� ����� �Ҽ��� ��°�ڸ������� ��Ÿ�����ּ���
-- alias���� ������ǰ, �Ҹ������ð����� ��Ÿ�����ּ���

select substr(prod_name,1,2) as ������ǰ,
       round(avg(to_date(cast(substr(cart_no,1,8) as date), 'YYYY.MM.DD') - to_date(cast(buy_date as date), 'YYYY.MM.DD')),2) as �Ҹ������ð�
       
from cart, buyprod, (select prod_name,prod_id 
                     from prod
                     where prod_name like '����%' 
                     or prod_name like '����%')
where  
    to_date(cast(substr(cart_no,1,8) as date), 'YYYY.MM.DD') - to_date(cast(buy_date as date), 'YYYY.MM.DD') > 0 
    and cart_prod = prod_id
    and prod_id = buy_prod
    
group by substr(prod_name,1,2);
                                
                                
-- 4day
-- [����]
-- ��ǰ���̺�� ��ǰ�з����̺��� ��ǰ�з��ڵ尡 'P101'�� �Ϳ� ����
-- ��ǰ�з��ڵ�(��ǰ���̺� �ִ� �÷�), ��ǰ��, ��ǰ�з����� ��ȸ�� �ּ���
-- ������ ��ǰ���̵�� ��������...

select prod_lgu, prod_name, lprod_nm
from prod inner join lprod
          on (prod_lgu = lprod_gu
          and prod_lgu = 'P101')
order by prod_id desc;


-- [����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó�ڵ�, �ŷ�ó��, ȸ����������(���� or ��õ...) ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���...

select buyer_id, buyer_name, substr(mem_add1,1,2)
from  buyer, prod, lprod , cart, member
where mem_name = '������'
and lprod_nm like '%ĳ�־�%'
and mem_id = cart_member
and cart_prod = prod_id
and prod_buyer = buyer_id
and prod_lgu = lprod_gu;



select buyer_id, buyer_name, substr(mem_add1,1,2)
from member inner join cart
            on (mem_id = cart_member)
            inner join prod
            on (cart_prod = prod_id)
            inner join buyer
            on (prod_buyer = buyer_id)
            inner join lprod
            on (prod_lgu = lprod_gu
            and lprod_nm like '%ĳ�־�%')
where mem_name = '������';



-- [����]
-- ��ǰ�з��� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ����...
-- ȸ���� ��̰� ������ ȸ��

select mem_id, mem_name, lprod_nm 
from  member, cart , prod, lprod
where lprod_nm like '%����%'
and prod_name like '%�Ｚ����%'
and mem_like = '����'
and mem_id = cart_member
and cart_prod = prod_id
and prod_lgu = lprod_gu;


-- [����]
-- ��ǰ�з����̺�� ��ǰ���̺�� �ŷ�ó���̺�� ��ٱ��� ���̺� ���...
-- ��ǰ�з��ڵ尡 'P101'�� ���� ��ȸ...
-- �׸���, ������ ��ǰ�з����� �������� ��������,
--              ��ǰ���̵� �������� �������� �ϼ���..
-- ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�
-- �ֹ������� ��ȸ...

select lprod_nm, prod_id, prod_sale, buyer_charger, mem_id, cart_qty  
from lprod, prod, buyer, cart, member
where lprod_gu = 'P101'
and lprod_gu = prod_lgu
and prod_buyer = buyer_id
and prod_id = cart_prod
and cart_member = mem_id
order by lprod_nm desc, prod_id asc;



-- [����]
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ������ ȸ���� ���ؼ���
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

select prod_id as ��ǰ�ڵ�
              , max(cart_qty) as �ִ밪
              , min(cart_qty) as �ּҰ�
              , round(avg(cart_qty),2) as ��հ�
              , sum(cart_qty) as �հ�
              , count(cart_qty) as ����
from prod, cart
where prod_id = cart_prod
and prod_name like '%�Ｚ%'
group by prod_id;



-- [����]
-- �ŷ�ó�ڵ� �� ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ�� �ּ���
-- ��ȸ�÷�, �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�, ��ǰ�з���,
--              �ǸŰ��� ���� �ְ�,�ּ�, �ڷ��, ���, �հ�
-- ������ ����� �������� ��������
-- ��, �ǸŰ��� ����� 100 �̻��� ��


select buyer_id as �ŷ�ó�ڵ�,
       buyer_name as �ŷ�ó��,
       lprod_gu as ��ǰ�з��ڵ�,
       lprod_nm as ��ǰ�з���,
       max(prod_sale) as �ְ�,
       min(prod_sale) as �ּ�,
       count(prod_sale) as ����,
       round(avg(prod_sale),2) as ���,
       sum(prod_sale) as �հ�
from buyer inner join prod
            on(buyer_id = prod_buyer)
            inner join lprod
            on(prod_lgu = lprod_gu)
group by buyer_id, lprod_gu, buyer_name, lprod_nm
having round(avg(prod_sale),2)>=100
order by ��� desc;


-- [����]

-- �ŷ�ó���� group ��� ���Աݾ������� �˻��ϰ��� �մϴ�...
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����)�ΰ͵�...
-- ���Աݾ� = ���Լ��� * ���Աݾ� ...
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ�����
-- (���Աݾ������� null�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������

select buyer_id, buyer_name, sum(nvl(buy_qty * buy_cost ,0))
from buyer inner join prod
           on (buyer_id = prod_buyer)
           inner join buyprod
           on (prod_id = buy_prod)
where buy_date between '05/01/01' and '05/01/31'
group by buyer_id, buyer_name
order by buyer_id desc, buyer_name desc;


-- [����]

-- �ŷ�ó���� group ��� ���Աݾ��� ���� ����Ͽ�
-- ���Աݾ������� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ���� �˻��ϰ��� �մϴ�....
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����)�ΰ͵�...
-- ���Աݾ� = ���Լ��� * ���Աݾ�..
-- (���Աݾ��� ���� null�� ��� 0���� ��ȸ)
-- ��ȸ�÷� : ��ǰ�ڵ�, ��ǰ��
-- ������ ��ǰ���� �������� ��������
select prod_id, prod_name
from prod, buyprod, buyer
where prod_id = buy_prod
and prod_buyer = buyer_id
and buy_date between '05/01/01' and '05/01/31'
group by buyer_id
having sum(nvl(buy_qty * buy_cost ,0)) >= 10000000
order by prod_name asc;



-- �ŷ�ó���� group ��� ���Աݾ������� �˻��ϰ��� �մϴ�...
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����)�ΰ͵�...
-- ���Աݾ� = ���Լ��� * ���Աݾ�...
-- ��ȸĮ�� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ�����
-- (���Աݾ������� null�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������

-- ���� ����� �̿��Ͽ� ..
-- ���Աݾ������� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ���� �˻�

select prod_id, prod_name
from (select buyer_id, buyer_name,
       sum(NVL(buy_qty * buy_cost, 0)) as sumcost
       from buyer, prod, buyprod
       where buyer_id = prod_buyer
        and prod_id = buy_prod
        and buy_date between '05/01/01' and '05/01/31'
       group by buyer_id, buyer_name
       order by buyer_id desc, buyer_name desc) A, prod P
where prod_buyer = A.buyer_id
and A.sumcost >= 10000000
order by prod_name asc;

     
                  
-- OUTERJOIN
-- ��ü�з��� ��ǰ�ڷ� ���� �˻� ��ȸ
select lprod_gu �з��ڵ�, lprod_nm �з���,
       count(prod_lgu) ��ǰ�ڷ��
from lprod, prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu;

select lprod_gu �з��ڵ�, lprod_nm �з���,
       count(prod_lgu) ��ǰ�ڷ��
from lprod, prod
where lprod_gu = prod_lgu
group by lprod_gu, lprod_nm
order by lprod_gu;


-- outer join�� ������ ANSI ǥ������
select lprod_gu �з��ڵ�, lprod_nm �з���,
       count(prod_lgu) ��ǰ�ڷ��
from lprod
    left outer join prod on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu;



select prod_id ��ǰ�ڵ�,
      prod_name ��ǰ��,
      sum(buy_qty) �԰����
from prod, buyprod
where prod_id = buy_prod
and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name;

select prod_id ��ǰ�ڵ�,
      prod_name ��ǰ��,
      sum(buy_qty) �԰����
from prod, buyprod
where prod_id = buy_prod(+)
and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

select prod_id ��ǰ�ڵ�,
      prod_name ��ǰ��,
      sum(buy_qty) �԰����
from prod left outer join buyprod
on( prod_id = buy_prod)
and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

-- self join�� ������ A�� �ϴ�
-- ��ȸ�� B�� �ϴ� �ϴ� ����� �ִ�
select B.buyer_id �ŷ�ó�ڵ�,
      B.buyer_name �ŷ�ó��,
      B.buyer_add1 ||''|| B.buyer_add2 �ּ�
From buyer A, buyer B
where A.buyer_id = 'P30203'
and substr(A.buyer_add1,1,2) = substr(B.buyer_add1, 1,2);






-- 1�� 1�� ����
-- �԰�� ��ǰ �� �� ���� �ֹ����� ���� ��ǰ�� ��ǰ�з����� ������ ������ ��ǰ�з���� ��ǰ�з��ڵ� ��ȸ
-- ���������� �̿��ϼ��� (������ ����ϽǼ� �����ϴ�)

                                            

select lprod_nm, lprod_id
from lprod
where lprod_gu in (select prod_lgu 
                   from prod
                   where prod_id not in (select cart_prod from cart)
                   and prod_id in (select buy_prod
                                    from buyprod));
                                




CREATE TABLE itmember( 
it_id varchar2(20) not null primary key,
it_name varchar2(20) not null,
it_mail varchar2(20) not null,
it_nickname varchar2(20) not null
);


INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('a001','������','king@batju?.com', '�߻���');
INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('b001','������', 'king@batju?.com', '1');
INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('c001', '�̼���', 'king@batju?.com', 'BIBLE');
INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('d001','������' , 'king@batju?.com', '�ɽ���������');
COMMIT;


select prod_name, lprod_nm, it_name, it_nickname
from itmember,cart, prod,  lprod 
where lprod_nm = 'ȭ��ǰ'
    and (prod_name like '%��Ų%' 
    or prod_name like '%���%')
    and prod_lgu = lprod_gu
    and prod_id = cart_prod
    and cart_member = it_id
order by it_nickname asc;


-- ���� ���̺��� �÷��� ��ȸ�Ұ�� ����������� �ȸ���
-- �ƴ޾ҽ��ϴ�
select prod_name, lprod_nm, it_name, it_nickname
from itmember,cart, prod,  lprod 
where it_id in (select cart_member
                from cart
                where cart_prod in (select prod_id
                                    from prod
                                    where (prod_name like '%��Ų%'
                                    or prod_name like '%���%')
                                    and prod_lgu in (select lprod_gu
                                                     from lprod
                                                     where lprod_nm = 'ȭ��ǰ')))
order by it_nickname asc;


select *
From cart
where cart_no = '2005071100002'
and cart_prod = 'P101000006' ;