
-- User 테이블
-- 회원아이디(user_id)varchar(30)
--, 비밀번호(password)varchar2(100)
--, 회원이름(user_name) varchar2(50)
--, 생성일자(created_at) date

create table Users(
    user_id varchar2(30) constraint users_user_id_pk primary key,
    password varchar2(100) constraint users_password_nn not null,
    user_name varchar2(50) constraint users_user_name_nn not null,
    created_at date default sysdate
);
--users 테이블 드랍
drop table Users;
--users 테이블 데이터 삽입
insert into users
values ('user01', '1234', '홍길동', sysdate);
insert into users
values ('user02', '2222', '홍길동', sysdate);
insert into users
values ('user99', '2222', '홍길동', sysdate);
--users 테이블 조회
select *
from Users;

select * from board;

insert into board (board_no, title, content,writer)
values (5, '외래키등록', '외래키테스트', 'user02');
insert into board (board_no, title, content,writer)
values (11, 'user98', '외래키테스트', 'user98');
delete from users
where user_id = 'user';

--board(writer) foreign key
-- users(user_id) -> reference key
alter table board
    add constraint board_users_id_fk foreign key(writer) references users(user_id);
select *
from emp
order by 1 desc;

select * from dept;

update emp
set deptno =50
where empno = 7935;

-- responsibility 칼럼 add.
alter table users add responsibility varchar2(5); --Admin, User
alter table users 
add constraint users_resp_ck check (responsibility in ('User', 'Admin'));

update users
set responsibility = 'Admin'
where 1 =1;

SELECT DISTINCT writer
FROM board
WHERE writer NOT IN (
  SELECT user_id FROM users
);

create table tcons
(   no number(5) constraint tcons_no_pk primary key,
    name varchar2(20) constraint tcons_name_nn not null,
    jumin  VARCHAR2(13)
        CONSTRAINT tcons_jumin_nn NOT NULL
        CONSTRAINT tcons_jumin_uk UNIQUE,
    area   NUMBER CONSTRAINT tcons_area_ck CHECK (area BETWEEN 1 AND 4),
        deptno VARCHAR2(6),
    CONSTRAINT tcons_deptno_fk FOREIGN KEY (deptno) REFERENCES dept2(dcode)
 );
-- 기본키 생성 및 삭제와 외래키 생성 및 삭제
alter table tcons
    add constraint tcons_name_fk foreign key(name) references emp2(name);
    alter table emp2
    add constraint emp_name_uk UNIQUE (NAME);
    alter table emp2
    drop constraint emp_name_uk;
select *
from emp2;
select *
from tcons;
insert into tcons
values(1,'Kurt Russell','1234451212121','1','0001');

--시퀀스
create sequence board_seq;
select board_seq.nextval from dual;

delete from board;

insert into board (board_no, title, content, writer)
values (board_seq.nextval, '오라클 인덱스', '데이터생성시 생성', 'user01');
insert into board (board_no, title, content, writer)
values (board_seq.nextval, 'HTML,CSS,JS', '웹프로그램 작성', 'user02');
insert into board (board_no, title, content, writer)
values (board_seq.nextval, 'Node.js', 'JS활용한 서버프로그램', 'user99');

select *
from board;

insert into board (board_no, title, content, writer)
select board_seq.nextval, title,content, writer from board;

-- orimary key (unique index)
select *
from board
order by board_no;

--paging 기능.
-- 1페이지에 10건씩 페이지.
-- 1page: 1~10/ 2page: 11~20/ 3page: 21~30 ...
select b.*
from (select rownum rn, a.*
        from   (select *
                from board
                order by board_no) a) b
where b.rn > (:page -1) *10
and b.rn <= (:page * 10);

select a.*
from 
(select  /* +INDEX+DESC(b SYS_C008402)*/ rownum rn, b.*
from board b) a
where a.rn > (:page -1) *10
and a.rn <= (:page * 10); --11g 예전방식

--12g 부터
select *
from board
order by board_no
offset (:page -1)*10 rows fetch next 10 rows only;



        
  