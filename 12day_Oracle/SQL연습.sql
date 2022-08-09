CREATE TABLE Iprod
(
    Iprod_id number(5) NOT NULL, -- 상품분류코드
    Iprod_gu char(4) NOT NULL,   -- 상품분류
    Iprod_nm varchar2(40) NOT NULL, -- 상품분류명
    Constraint pk_Iprod Primary Key (Iprod_gu)
    );

Select * 
From Iprod;


INSERT INTO Iprod (Iprod_id, Iprod_gu, Iprod_nm) 
VALUES (1, 'P101', '컴퓨터제품');
INSERT INTO Iprod (Iprod_id, Iprod_gu, Iprod_nm) 
VALUES (1, 'P102', '컴퓨터제품');

    
select Iprod_gu, Iprod_nm
from Iprod;

--주문내역관리 테이블
Select *
From cart;


-- 거래처정보 테이블
Select *
From buyer;


--회원 테이블에서 회원아이디, 회원이름 조회하기..
Select MEM_ID, MEM_NAME FROM MEMBER;

-- 상품코드와 상품명 판매금액 조회하기..
-- 단, 판매금액 = 판매가 * 55로 계산해서 조회합니다
-- 판매금액이 4백만 이상인 데이터만 조회하기
-- 정렬은 판매금액을 기준으로 내림차순
Select PROD_ID, PROD_NAME,(PROD_SALE*55) as sale
FROM PROD
WHERE (PROD_SALE * 55) >= 4000000
ORDER BY sale DESC;

-- 상품정보에서 거래처코드를 조회해 주세요...
-- 단, 중복을 제거하고 조회해주세요
Select Distinct prod_buyer 
FROM prod;


-- 상품중에 판매가격이 17만원인 상품 조회하기...
select prod_id,prod_price
from prod
WHERE prod_price = 170000;

-- 상품중에 판매가격이 17만원이 아닌 상품 조회하기 ..
select prod_id,prod_sale
from prod
WHERE prod_sale != 170000;


-- 상품중에 판매가격이 17만원 이상이고 20만원 이하인 상품 조회하기..
select prod_id,prod_sale
from prod
WHERE prod_sale >= 170000 
  AND prod_sale <= 200000 ;
  
-- 상품중에 판매가격이 17만원 이상 또는 20만원 이하인 상품 조회하기..
select prod_id,prod_sale
from prod
WHERE prod_sale >= 170000 
  OR prod_sale <= 200000 ;

-- 상품 판매가격이 10만원 이상이고,,,
-- 상품 거래처(공급업체) 코드가 P30203 또는 P10201 인
-- 상품코드, 판매가격, 공급업체 코드 조회하기...
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


-- 한번도 주문한 적이 없는 회원 아이디, 이름을 조회해 주세요...
select mem_id , mem_name
from member
where mem_id not in (select distinct cart_member  from cart);


-- 상품분류 중에 상품정보에 없는 분류코드만 조회해 주세요...
select lprod_gu
from lprod
where  lprod_gu not in (select distinct prod_lgu from prod);



-- 회원의 생일 중에  75년생이 아닌 회원아이디, 생일 조회하기,
-- 정렬은 생일 기준 내림차순
SELECT MEM_ID, MEM_BIR
  FROM MEMBER
 WHERE MEM_BIR NOT BETWEEN '1975-01-01' AND '1975-12-31';


-- 회원 아이디가 a001인 회원이 주문한 상품코드를 조회해 주세요...
-- 조회컬럼은 회원아이디, 상품코드
Select cart_member, cart_prod
From cart
Where cart_member = 'a001';


-- 정렬은 회원이름 기준 오름차순
Select mem_id, mem_name, mem_like, mem_mileage
From member
Where mem_like = '수영'
 And mem_mileage >= 1000
Order By  mem_name Asc;

-- 김은대 회원과 동일한 취미를 가지는
-- 회원 아이디, 회원이름, 회원취미 조회하기
Select mem_like
From member
Where mem_name = '김은대';


Select mem_id, mem_name, mem_like
From member
Where mem_like = (Select mem_like
                    From member
                    Where mem_name='김은대');


-- 주문내역이 있는 회원에 대한 정보를 조회하려고 합니다.
-- 회원아이디, 회원이름, 주문번호, 주문수량, 상품명 조회하기
-- 스칼라 서브쿼리
Select cart_member, cart_no, cart_qty,
      (Select mem_name From member where mem_id = cart_member ) as name,
      (Select prod_name From prod where prod_id=cart_prod) as 상품명
From cart;

-- a001 회원이 주문한 상품에 대한
-- 상품분류코드, 상품분류명 조회하기
Select lprod_gu, lprod_nm 
From lprod
where lprod_gu in (Select prod_lgu
                    From prod
                    Where prod_id in (Select CART_PROD
                                        from cart
                                        Where cart_member = 'a001'));


-- 이쁜이 라는 회원이 주문한 상품 중에
-- 상품분류코드가 P201이고,
-- 거래처코드가 P20101인
-- 상품코드, 상품명을 조회해 주세요..
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
                    where mem_name = '이쁜이'));

Select prod_id, prod_name
From prod
Where prod_id in (Select cart_prod
                from cart
                where cart_member
                 in (Select mem_id
                        from member
                        Where mem_name = '이쁜이'));



-- 서브쿼리(SubQuery) 정리
-- (방법1) Select 조회 칼럼 대신에 사용하는 경우
--  : 단일컬럼의 단일행만 조회

-- (방법2) Where 절에 사용하는 경우
-- In () : 단일컬럼의 단일행 또는 다중행 조회 가능
-- =     : 단일컬럼의 단일행만 조회 가능
-- 


SELECT prod_id 상품코드, prod_name 상품명
from prod
Where prod_name Like '상%';

SELECT prod_id 상품코드, prod_name 상품명
FROM prod
WHERE prod_name LIKE '_성%';

SELECT prod_id 상품코드, prod_name 상품명
FROM prod
WHERE prod_name like '%치';


SELECT mem_id, SUBSTR(mem_name,1,1) 성씨
FROM dual;

-- 상품테이블의 상품명의 넷째 자리부터 두글자가 '칼라'인 상품의
-- 상품코드, 상품명을 검색하시오
Select Substr(prod_name, 4, 2) as subNm
From prod
Where Substr(prod_name, 4, 2) = '칼라';

SELECT buyer_name, REPLACE(buyer_name, '삼','육') "삼>육"
FROM buyer;


SELECT Substr(REPLACE(mem_name,'이','리'),1,1) || Substr(mem_name, 2,3)
FROM member;

-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름 조회하기.
-- 단,상품명에 삼성전자가 포함된 상품을 구매한 회원 ...
--      그리고, 회원의 취미가 수영인 회원 ...
SELECT mem_id, mem_name
from member
where mem_id in (select cart_member 
                    from cart
                    where cart_prod in (select prod_id 
                                        from prod
                                        where prod_name like '%삼성전자%'
                                        and prod_lgu in(
                                            select lprod_gu
                                            from lprod
                                            where lprod_nm like '%전자%')))
AND mem_like = '수영';



SELECT mem_mileage,
    ROUND(mem_mileage/12,2),
    TRUNC(mem_mileage/12,2)
FROM member;

-- 회원조회, 남자=1, 여자=1 으로 조회
select mem_name, mod(substr(mem_regno2,1,1),2)
from member;



SELECT sysdate ,
        sysdate - 1 , sysdate + 1 
FROM dual;


select mem_bir, mem_bir + 12000
from member;


select add_months(sysdate,5) from dual;

select next_day(sysdate,'월요일'),
        last_day(sysdate)
From dual;

select last_day(sysdate)-sysdate
from dual;

select round(sysdate,'YYYY'),
       round(sysdate,'q')
from dual;

-- 날짜에서 필요한 부분만 추출

select extract(year from sysdate)"년도",
        extract(month from sysdate)"월",
     extract(day from sysdate)"일"
from dual;

-- 생일이 3월인 회원을 검색하세요
select mem_name
from member
where extract(month from mem_bir) = 3;


-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000.00-00-00 00/00/00,
select cast('1997/12/25' as date) from dual;

select '[' || CAST('Hello' as CHAR(30)) || ']' "형변환"
from dual;

select to_char(cast('2008-12-25' as date), 'YYYY.MM.DD HH24:MI')
from dual;


select to_char(cast(prod_insdate as date), 'YYYY_MM_DD') as 입고일
from prod;



select  mem_name || '님은 ' ||  to_char(mem_bir,'yyyy') || '년 '
        || to_char(mem_bir,'mm') || '월 출생이고 태어난 요일은 '
        || to_char(mem_bir, 'day')
from member;


select to_char(1234.6,'99,999.00'),
       to_char(1234.6,'9999.99'),
        to_char(1234.6,'999999.99')
from dual;

select to_char(-1234.6,'L9999.00PR'),
       to_char(-1234.6,'L9999.99PR')
from dual;

-- 여자인 회원이 구매한 상품 중에
-- 상품분류에 전자가 포함되어 있고
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회하기
select prod_id, prod_name
from prod
where prod_id in (select cart_prod
                  from cart
                  where cart_member in (select mem_id
                                        from member
                                        where mod(substr(mem_regno2,1,1),2)=0))
                                        
and prod_lgu in (select lprod_gu 
                 from lprod 
                 where lprod_nm like '%전자%')
                 
and prod_buyer in (select buyer_id
                    from buyer 
                    where substr(buyer_add1,1,2) ='서울');
                    
-- 1. 테이블 찾기
--  - 제시된 칼럼들의 소속 찾기
-- 2. 테이블 간의 관계 찾기
--  - ERD에서 연결된 순서대로 PK와 FK컬럼 또는 ,
--  - 성격이 같은 값으로 연결할 수 있는 컬럼 찾기
-- 3. 작성 순서 정하기
--  - 조회하는 컬럼이 속한 테이블이 가장 밖.. 1순위..
-- - 1순위 테이블부터 ERD 순서대로 작성
-- - 조건은 : 해당 컬럼이 속한 테이블에서 조건 처리..



-- 3day
-- [조회 방법 정리]
-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름 조회하기
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원...
--      그리고, 회원의 취미가 수영인 회원..

select mem_id, mem_name
from member
where mem_like = '수영'
and mem_id in (select cart_member 
                 from cart
                 where cart_prod in (select prod_id
                                     from prod
                                     where prod_lgu in (select lprod_gu
                                                        from lprod
                                                        where lprod_nm like '%전자%')
                                    and prod_name like '%삼성전자%'));


-- [문제]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다
-- 거래처코드, 거래처명, 지역 (서울 or 인천 ...), 거래처 전화번호 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만 ...

select buyer_id, substr(buyer_add1,1,2) as add1 ,buyer_comtel
from buyer
where buyer_id in (select prod_buyer
                   from prod
                   where prod_id in (select cart_prod
                                     from cart
                                     where cart_member in (select mem_id
                                                            from member
                                                            where mem_name = '김형모')
                    and prod_lgu in (select lprod_gu
                                     from lprod
                                     where lprod_nm like '%캐주얼%')));


-- 여자인 회원이 구매한 상품 중에
-- 상품분류에 전자가 포함되어 있고
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회하기..

select prod_id, prod_name
from prod
where prod_lgu in (select lprod_gu
                   from lprod
                   where lprod_nm like '%전자%')
and prod_buyer in (select buyer_id
                     from buyer
                     where substr(buyer_add1,1,2) = '서울')
and prod_id in (select cart_prod
                  from cart
                  where cart_member in (select mem_id
                                        from member
                                        where mod(substr(mem_regno2,1,1),2)=0));
                                        

-- 상품 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회하기
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수
select cart_prod as 상품코드,
        max(cart_qty) as 최대값,
        min(cart_qty) as 최소값,
        round(avg(cart_qty),2) as 평균값,
        sum(cart_qty) as 합계,
        count(cart_qty) as 갯수
from cart
group by cart_prod;


select *
from cart;

-- 오늘이 2005년도 7월 11일 이라 가정하고 장바구니테이블에 발생될
-- 추가주문번호를 검색하시오
-- 조회 칼럼 : 현재 마지막 주문번호, 추가주문번호
select max(cart_no) as mno, Max(cart_no) +1 as npno 
from cart
where cart_no like '%20050711%';

-- 회원테이블의 회원전체의 마일리지 평균, 마일리지 합계,
-- 최고 마일리지, 최소 마일리지, 인원수를 검색하시오 
select round(avg(mem_mileage),2) as 마일리지평균,
       sum(mem_mileage) as 마일리지합계,
       max(mem_mileage) as 최고마일리지,
       min(mem_mileage) as 최소마일리지,
       count(mem_mileage) as 인원수
from member;


-- (문제)
-- 상품테이블에서 거래처별, 상품분류코드별로,
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회해 주세요..
-- 정렬은 자료수를 기준으로 내림차순
-- 추가로, 거래처명, 상품분류명도 조회 ...
-- 단, 합계가 100 이상인 것

select prod_buyer as 거래처,
       prod_lgu as 상품코드,
       max(prod_sale) as 최고,
       count(prod_id) as 자료수,
       round(avg(prod_sale),2) as 평균,
       sum(prod_sale) as 합계,
       (select buyer_name from buyer where buyer_id = prod_buyer) as 거래처명,
       (select lprod_nm from lprod where lprod_gu = prod_lgu) as 상품분류명
from prod, buyer
group by prod_buyer, prod_lgu
having sum(prod_sale) >= 100
order by 자료수 desc;


update buyer set buyer_charger = NULL
WHERE buyer_charger LIKE '김%';

update buyer set buyer_charger = ''
where buyer_charger like '성%';

select buyer_charger
from buyer
where buyer_charger is NOT Null;

SELECT buyer_name,
       NVL(buyer_charger, '없다') as charger
FROM buyer;


select prod_lgu,
    DECODE( SUBSTR(prod_lgu,1,2),
            'P1', '컴퓨터/전자 제품',
            'P2', '의류',
            'P3', '잡화',
            '기타') as lgu_nm
from prod;


select prod_id, prod_name, prod_lgu
from prod
where EXISTS(
    select lprod_gu
    from lprod
    where lprod_gu = prod_lgu);
    
    
    
select * from lprod,prod;
select * from lprod cross join prod;


-- Inner join 조건
-- PK와 FK가 있어야 합니다.
-- 관계조건 성립 : PK = FK
-- 관계조건의 갯수 : From절에 제시된 (테이블의 갯수 - 1 개)
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


-- 상품테이블에서 상품코드, 상품명, 분류명, 거래처명,
-- 거래처주소를 조회
-- 1) 판매가격이 11만원 이하 이고
-- 2) 거래처 주소가 부산인 경우만 조회
-- 일반형식, 표준방식... 모두 해보기..

-- 1. 테이블 찾기 
-- 2. 관계조건식 찾기
-- 3. 순서 정하기 ...
select prod_id, prod_name, lprod_nm, buyer_name
from prod, lprod, buyer
where prod_lgu = lprod_gu
and prod_buyer = buyer_id
and substr(buyer_add1,1,2) = '부산'
and prod_sale <= 110000;



select prod_id, prod_name, lprod_nm, buyer_name
from prod inner join lprod
           on (prod_lgu = lprod_gu
           and  prod_sale <= 110000)
           inner join buyer
           on (prod_buyer = buyer_id
           and substr(buyer_add1,1,2) = '부산');


-- (문제)
-- 상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
-- 단, 상품분류 코드가 P101, P201, P301 인 것
--      매입수량이 15개 이상인 것
--      서울에 살고 있는 회원 중에 생일이 1974년생인 회원
-- 정렬은 회원아이디 기준 내림차순, 매입수량 기준 오름차순
-- 일반방식, 표준방식..

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
and substr(mem_add1,1,2)='서울'
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
          and mem_add1 like '서울%')
order by mem_id desc ,buy_qty asc;




-- 제품이름이 남성과 여성으로 시작하는 제품의 각각의 소매점 대기시간 평균을 집계하세요
-- 소매점대기시간은 주문일 - 매입일
-- 소매점 대기시간이 0 이하인 값들은 제외
-- 대기시간 평균을 소수점 둘째자리까지만 나타내어주세요
-- alias명을 성별제품, 소매점대기시간으로 나타내어주세요

select substr(prod_name,1,2) as 성별제품,
       round(avg(to_date(cast(substr(cart_no,1,8) as date), 'YYYY.MM.DD') - to_date(cast(buy_date as date), 'YYYY.MM.DD')),2) as 소매점대기시간
       
from cart, buyprod, (select prod_name,prod_id 
                     from prod
                     where prod_name like '남성%' 
                     or prod_name like '여성%')
where  
    to_date(cast(substr(cart_no,1,8) as date), 'YYYY.MM.DD') - to_date(cast(buy_date as date), 'YYYY.MM.DD') > 0 
    and cart_prod = prod_id
    and prod_id = buy_prod
    
group by substr(prod_name,1,2);
                                
                                
-- 4day
-- [문제]
-- 상품테이블과 상품분류테이블에서 상품분류코드가 'P101'인 것에 대한
-- 상품분류코드(상품테이블에 있는 컬럼), 상품명, 상품분류명을 조회해 주세요
-- 정렬은 상품아이디로 내림차순...

select prod_lgu, prod_name, lprod_nm
from prod inner join lprod
          on (prod_lgu = lprod_gu
          and prod_lgu = 'P101')
order by prod_id desc;


-- [문제]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다.
-- 거래처코드, 거래처명, 회원거주지역(서울 or 인천...) 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만...

select buyer_id, buyer_name, substr(mem_add1,1,2)
from  buyer, prod, lprod , cart, member
where mem_name = '김형모'
and lprod_nm like '%캐주얼%'
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
            and lprod_nm like '%캐주얼%')
where mem_name = '김형모';



-- [문제]
-- 상품분류명에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름, 상품분류명 조회하기
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원과...
-- 회원의 취미가 수영인 회원

select mem_id, mem_name, lprod_nm 
from  member, cart , prod, lprod
where lprod_nm like '%전자%'
and prod_name like '%삼성전자%'
and mem_like = '수영'
and mem_id = cart_member
and cart_prod = prod_id
and prod_lgu = lprod_gu;


-- [문제]
-- 상품분류테이블과 상품테이블과 거래처테이블과 장바구니 테이블 사용...
-- 상품분류코드가 'P101'인 것을 조회...
-- 그리고, 정렬은 상품분류명을 기준으로 내림차순,
--              상품아이디를 기준으로 오름차순 하세요..
-- 상품분류명, 상품아이디, 상품판매가, 거래처담당자, 회원아이디
-- 주문수량을 조회...

select lprod_nm, prod_id, prod_sale, buyer_charger, mem_id, cart_qty  
from lprod, prod, buyer, cart, member
where lprod_gu = 'P101'
and lprod_gu = prod_lgu
and prod_buyer = buyer_id
and prod_id = cart_prod
and cart_member = mem_id
order by lprod_nm desc, prod_id asc;



-- [문제]
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회하기
-- 단, 상품명에 삼성이 포함된 상품을 구매한 회원에 대해서만
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수

select prod_id as 상품코드
              , max(cart_qty) as 최대값
              , min(cart_qty) as 최소값
              , round(avg(cart_qty),2) as 평균값
              , sum(cart_qty) as 합계
              , count(cart_qty) as 갯수
from prod, cart
where prod_id = cart_prod
and prod_name like '%삼성%'
group by prod_id;



-- [문제]
-- 거래처코드 및 상품분류코드별로,
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회해 주세요
-- 조회컬럼, 거래처코드, 거래처명, 상품분류코드, 상품분류명,
--              판매가에 대한 최고,최소, 자료수, 평균, 합계
-- 정렬은 평균을 기준으로 내림차순
-- 단, 판매가의 평균이 100 이상인 것


select buyer_id as 거래처코드,
       buyer_name as 거래처명,
       lprod_gu as 상품분류코드,
       lprod_nm as 상품분류명,
       max(prod_sale) as 최고,
       min(prod_sale) as 최소,
       count(prod_sale) as 갯수,
       round(avg(prod_sale),2) as 평균,
       sum(prod_sale) as 합계
from buyer inner join prod
            on(buyer_id = prod_buyer)
            inner join lprod
            on(prod_lgu = lprod_gu)
group by buyer_id, lprod_gu, buyer_name, lprod_nm
having round(avg(prod_sale),2)>=100
order by 평균 desc;


-- [문제]

-- 거래처별로 group 지어서 매입금액의합을 검색하고자 합니다...
-- 조건은 상품입고테이블의 2005년도 1월의 매입일자(입고일자)인것들...
-- 매입금액 = 매입수량 * 매입금액 ...
-- 조회컬럼 : 거래처코드, 거래처명, 매입금액의합
-- (매입금액의합이 null인 경우 0으로 조회)
-- 정렬은 거래처 코드 및 거래처명을 기준으로 내림차순

select buyer_id, buyer_name, sum(nvl(buy_qty * buy_cost ,0))
from buyer inner join prod
           on (buyer_id = prod_buyer)
           inner join buyprod
           on (prod_id = buy_prod)
where buy_date between '05/01/01' and '05/01/31'
group by buyer_id, buyer_name
order by buyer_id desc, buyer_name desc;


-- [문제]

-- 거래처별로 group 지어서 매입금액의 합을 계산하여
-- 매입금액의합이 1천만원 이상인 상품코드, 상품명을 검색하고자 합니다....
-- 조건은 상품입고테이블의 2005년도 1월의 매입일자(입고일자)인것들...
-- 매입금액 = 매입수량 * 매입금액..
-- (매입금액의 합이 null인 경우 0으로 조회)
-- 조회컬럼 : 상품코드, 상품명
-- 정렬은 상품명을 기준으로 오름차순
select prod_id, prod_name
from prod, buyprod, buyer
where prod_id = buy_prod
and prod_buyer = buyer_id
and buy_date between '05/01/01' and '05/01/31'
group by buyer_id
having sum(nvl(buy_qty * buy_cost ,0)) >= 10000000
order by prod_name asc;



-- 거래처별로 group 지어서 매입금액의합을 검색하고자 합니다...
-- 조건은 상품입고테이블의 2005년도 1월의 매입일자(입고일자)인것들...
-- 매입금액 = 매입수량 * 매입금액...
-- 조회칼럼 : 거래처코드, 거래처명, 매입금액의합
-- (매입금액의합이 null인 경우 0으로 조회)
-- 정렬은 거래처 코드 및 거래처명을 기준으로 내림차순

-- 위의 결과를 이용하여 ..
-- 매입금액의합이 1천만원 이상인 상품코드, 상품명을 검색

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
-- 전체분류의 상품자료 수를 검색 조회
select lprod_gu 분류코드, lprod_nm 분류명,
       count(prod_lgu) 상품자료수
from lprod, prod
where lprod_gu = prod_lgu(+)
group by lprod_gu, lprod_nm
order by lprod_gu;

select lprod_gu 분류코드, lprod_nm 분류명,
       count(prod_lgu) 상품자료수
from lprod, prod
where lprod_gu = prod_lgu
group by lprod_gu, lprod_nm
order by lprod_gu;


-- outer join은 무조건 ANSI 표준으로
select lprod_gu 분류코드, lprod_nm 분류명,
       count(prod_lgu) 상품자료수
from lprod
    left outer join prod on (lprod_gu = prod_lgu)
group by lprod_gu, lprod_nm
order by lprod_gu;



select prod_id 상품코드,
      prod_name 상품명,
      sum(buy_qty) 입고수량
from prod, buyprod
where prod_id = buy_prod
and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name;

select prod_id 상품코드,
      prod_name 상품명,
      sum(buy_qty) 입고수량
from prod, buyprod
where prod_id = buy_prod(+)
and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

select prod_id 상품코드,
      prod_name 상품명,
      sum(buy_qty) 입고수량
from prod left outer join buyprod
on( prod_id = buy_prod)
and buy_date between '2005-01-01' and '2005-01-31'
group by prod_id, prod_name
order by prod_id, prod_name;

-- self join은 조건은 A로 싹다
-- 조회는 B로 싹다 하는 방식이 있다
select B.buyer_id 거래처코드,
      B.buyer_name 거래처명,
      B.buyer_add1 ||''|| B.buyer_add2 주소
From buyer A, buyer B
where A.buyer_id = 'P30203'
and substr(A.buyer_add1,1,2) = substr(B.buyer_add1, 1,2);






-- 1조 1번 문제
-- 입고된 상품 중 한 번도 주문되지 않은 상품의 상품분류명을 제외한 나머지 상품분류명과 상품분류코드 조회
-- 서브쿼리만 이용하세요 (조인은 사용하실수 없습니다)

                                            

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
     VALUES 	('a001','이정빈','king@batju?.com', '잘생김');
INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('b001','권지은', 'king@batju?.com', '1');
INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('c001', '이성경', 'king@batju?.com', 'BIBLE');
INSERT INTO 	itmember (it_id, it_name, it_mail, it_nickname)
     VALUES 	('d001','조혜리' , 'king@batju?.com', '걸스데이혜리');
COMMIT;


select prod_name, lprod_nm, it_name, it_nickname
from itmember,cart, prod,  lprod 
where lprod_nm = '화장품'
    and (prod_name like '%스킨%' 
    or prod_name like '%향수%')
    and prod_lgu = lprod_gu
    and prod_id = cart_prod
    and cart_member = it_id
order by it_nickname asc;


-- 여러 테이블에서 컬럼을 조회할경우 서브쿼리방법 안먹힘
-- 꺠달았습니다
select prod_name, lprod_nm, it_name, it_nickname
from itmember,cart, prod,  lprod 
where it_id in (select cart_member
                from cart
                where cart_prod in (select prod_id
                                    from prod
                                    where (prod_name like '%스킨%'
                                    or prod_name like '%향수%')
                                    and prod_lgu in (select lprod_gu
                                                     from lprod
                                                     where lprod_nm = '화장품')))
order by it_nickname asc;


select *
From cart
where cart_no = '2005071100002'
and cart_prod = 'P101000006' ;