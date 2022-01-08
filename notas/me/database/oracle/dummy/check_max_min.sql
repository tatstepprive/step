create table check_max_min (no1 number, no2 number, no3 number);

insert into check_max_min values (2,4,0);
insert into check_max_min values (1,3,2);
insert into check_max_min values (1,2,2);
insert into check_max_min values (1,1,1);
insert into check_max_min values (2,4,0);

commit;
select * from check_max_min;

select max(no2), min(no3) from check_max_min;
--4 0

select max(no2), min(no3) from check_max_min where no1=1;
--3 1

select no1, max(no2), min(no3) from check_max_min group by no1;
--1 3 1
--2 4 0
