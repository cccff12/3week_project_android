use testdb;


select * from test111;
select * from test22;

drop table tbl_t;
drop table tbl_test;
drop table test1;

-- 테이블생성
create table test111(
t1_1 varchar(10) primary key,
t1_2 varchar(10),
t1_3 int
);

create table test22(
t2_1 varchar(10) primary key,
t2_2 varchar(10) ,
t2_3 int
);
-- 테이블 조회
select * from test111;
-- 테이블 변경
alter table test111 add t1_4 varchar(10);
alter table test111 modify t1_4 int; 
alter table test111 drop t1_4; 

-- 테이블 값 추가
insert into test111(t1_1, t1_2, t1_3) values('1','2',3);
insert into test111(t1_1, t1_2, t1_3) values('4','5',6);
insert into test111(t1_1, t1_2, t1_3) values('7','8',9);
insert into test111(t1_1, t1_2, t1_3) values('10','11',12);
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


-- select 칼럼명
-- from 테이블명
-- where 칼럼명 like 's%' or between 3 and 9  or in ('s','a','d') 


-- 10.6
create table sql1(
t1_1 varchar(10) primary key ,
t1_2 varchar(10)
);
create table sql2(
t2_1 varchar(10) primary key ,
t2_2 varchar(10)
);

select * from sql1;

desc sql1;

alter table sql1 add t1_3 varchar(10);
alter table sql1 modify t1_3 int;
alter table sql1 drop t1_3;


alter table sql2 add t2_3 varchar(10);
alter table sql2 modify t2_3 int ;
alter table sql2 drop t2_3;

select * from sql1;
insert into sql1(t1_1, t1_2, t1_3) values('aaa','c',12345678);
update sql1 set t1_3= 123456 where t1_1= 'a' and t1_2 = 'b';
delete from sql1 where t1_1='a' or t1_2='c'; -- 이걸 실행하면 여기에 해당하는 튜플이 삭제됨



select * from sql1 
where t1_1 in('a','b','c') or t1_3 like '%5%';
select * from sql1 where t1_1 between 'a' and 'c'; -- between은 숫자 뿐만 아니라 아스키 코드 같은 문자도 가능

select t1_2 , avg(t1_3)
from sql1 
group by t1_2
order by t1_2 desc ; -- order by 예제


select t1_2 , avg(t1_3)
from sql1 
group by t1_2
having avg(t1_3) >10000000; -- having 예제 그룹으로 모은 것 중에서 조건을 달아 그 필터를 통과한 것들만 출력



-- distinct 예제- 속성에 같은 값들이 있다면 중복된걸 제거하고 보여줌
-- distinct 다음에 칼럼명이 오는데 이 칼럼은 select 뒤에 
-- 있기 때문에 보여지는건 이 칼럼 뿐임
select distinct t1_2
 from sql1;

insert into sql2(t2_1, t2_2, t2_3) values ('fa','b',123);

select * from sql1;
select * from sql2;
-- left join
select test1.t1_1, test2.t2_2
from test1 left join test2 on test1.t1_1= test2.t2_1   
order by test1.t1_3 asc;


-- left join
select * from sql1 left join sql2 on sql1.t1_1= sql2.t2_1;
-- right join 
select * from sql1 right join sql2 on sql2.t2_1= sql1.t1_1;
-- 이 두가지의 차이점은 중심이 누구냐 하는 것이다. 
-- left join은 from 다음에 있는 sql1 을 중심으로 같은 값이 있다면 보여주는 것이고
-- right join은 right join 다음에 있는 sql2 를 중심으로 보여주는 것이다

-- 이제 뷰랑 인덱스 생성만 외우고 sql은 마무리한다