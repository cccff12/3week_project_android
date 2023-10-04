use testdb;

select * from tbl_test;
select * from tbl_t;

drop table tbl_t;
drop table tbl_test;
drop table test1;
-- 테이블생성
create table test11(
t1_1 varchar(10) primary key,
t1_2 varchar(10),
t1_3 int
);

create table test2(
t2_1 varchar(10) primary key,
t2_2 varchar(10) ,
t2_3 int
);
-- 테이블 조회
select * from test11;
-- 테이블 변경
alter table test11 add t1_4 varchar(10);
alter table test11 modify t1_4 int; 
alter table test11 drop t1_4; 

-- 테이블 값 추가
insert into test1(t1_1, t1_2, t1_3) values('1','2',3);
insert into test1(t1_1, t1_2, t1_3) values('4','5',6);
insert into test1(t1_1, t1_2, t1_3) values('7','8',9);
insert into test1(t1_1, t1_2, t1_3) values('10','11',12);
UPDATE test1 SET t1_2 = '5' WHERE t1_1 = '1' ;
UPDATE test1 SET t1_2 = '4' WHERE t1_1 = '1';

select * from test1;
-- 테이블 행 삭제
delete from test1 where t1_1='1';

-- 조회 쿼리 중 in, between, like
select * 
from test1 
where t1_1 in('1','4','7');

select * from test1
where t1_3 between 3 and 9 ; 

select t1_3 
from test1
where t1_3 like '1%';

-- test2에 추가쿼리
insert into test2(t2_1, t2_2, t2_3) values('1','2',3);
insert into test2(t2_1, t2_2, t2_3) values('4','5',6);
insert into test2(t2_1, t2_2, t2_3) values('7','8',9);
insert into test2(t2_1, t2_2, t2_3) values('10','11',12);

-- 삭제 
delete from test2 where t2_1= '10';
delete from test1 where t1_1= '10';

select * from test1;
select * from test2;

-- index 생성
create index testindex on test1(t1_1);

-- left join
select test1.t1_1, test2.t2_2
from test1 left join test2 on test1.t1_1= test2.t2_1   
order by test1.t1_3 asc;

-- 뷰 생성
create view testview as
select *
from test1 
where t1_3<10;

select testview;





use testdb;


select * from test1;
select * from test2;

drop table test1;
drop table test2;

create table test1(
t1 bigint AUTO_INCREMENT PRIMARY key ,
t2 varchar(10) ,
t3 varchar(10)
);

create table test2(
t3 nvarchar(10) PRIMARY KEY,
t4 VARCHAR(10),
t5 varchar(10) not null
);
select * from test1;
-- 삽입 
insert into test1(t2,t3,t7) VALUES('asdasd','dddd',14);
insert into test1(t2,t3) VALUES('55','dddd');
insert into test2(t3,t4,t5) VALUES('33','44','55');
select * from test1;
select t2 from test1;
-- 수정
update test1 set t2='25' where t3='dddd';
-- 삭제
delete from test1 where t2='asdasd';

select * from test1;
desc test1;
-- 칼럼 삽입 변경 삭제
alter table test1 add t7 varchar(2);
alter table test1 modify t7 int;
alter table test1 drop t7;




-- index 생성
create index testindex on test1(t1_1);

-- left join
select test1.t1_1, test2.t2_2
from test1 left join test2 on test1.t1_1= test2.t2_1   
order by test1.t1_3 asc;

-- 뷰 생성
create view testview as
select *
from test1 
where t1_3<10;

select testview;

-- 조회 쿼리 중 in, between, like
select * 
from test1 
where t7 in('1','4','7');

select * from test1
where t7 between 3 and 9 ; 

select * from test1;

select t7 
from test1
where t7 like '%2%';


