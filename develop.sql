select
    *
from
    emp;

--추가작업 (origin merge 테스트)
select
    *
from
    dept;

select
    *
from
    board
ORDER BY
    1;

ALTER TABLE
    board
modify
    click_count number default 0;

--4/ 글등록연습/ user01/sql연습중
insert into
    board (board_no, title, writer, content)
values
    (
        (
            select
                max(board_no) + 1
            from
                board
        ),
        :title,
        :writer,
        :content
    );

SELECT
    max(board_no) + 1
FROM
    board;

-- insert 완성.
SELECT
    max(board_no) + 1
FROM
    board;

update
    board
set
    click_count = click_count + 1,
    title = :title,
    content = :content
where
    board_no = :bno;

select
    *
from
    board
ORDER BY
    1;

delete from
    board
where
    content like '%바인드%';
    
--상품테이블(product_tbl)
--상품코드,상품명, 가격,상품설명,평점(default3),제조사,등록일자
-- key   notnull  notnull        3              sysdate
CREATE TABLE product_tbl(
                prod_code varchar2(50) PRIMARY KEY
                ,prod_name varchar2(50) not null
                ,prod_price number not null
                ,prod_cont varchar2(500) not null
                ,prod_score number default 3
                ,prod_mk varchar2(50)
                ,prod_date date default sysdate
);
drop table product_tbl;

insert into product_tbl(prod_code,prod_name, prod_price, prod_cont,prod_date)
values((
  's' || LPAD(
    (SELECT MAX(TO_NUMBER(SUBSTR(prod_code,2))) + 1 FROM product_tbl),
    4,
    '0'
  )
  ),:name,:price,:cont,:p_date);
  
  --merge into table1
  -- using table2
  -- on 병합조건
  --when matched then
  --update ...
  --when not matched then
  --insert ...
merge into product_tbl tbl1
using (select 'S0014' prod_code
                ,'새로운상품13' prod_name
                ,14000 prod_price
                ,'아주좋은 13상품' prod_cont
                from dual) tbl2
ON (tbl1.prod_code = tbl2.prod_code)
when matched then
update 
set tbl1.prod_name = tbl2.prod_name
    ,tbl1.prod_price = tbl2.prod_price
    ,tbl1.prod_cont = tbl2.prod_cont
when not matched then
insert (prod_code, prod_name, prod_price, prod_cont)
values (tbl2.prod_code, tbl2.prod_name,tbl2.prod_price, tbl2.prod_cont);

select *
from product_tbl;

select (
  'S' || LPAD(
    (SELECT MAX(TO_NUMBER(SUBSTR(prod_code,2))) + 1 FROM product_tbl),
    4,
    '0'
  )
  )
from product_tbl;
update product_tbl
set prod_code='S0010'
where prod_code='s0010'
