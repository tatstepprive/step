--range partitioning
create table sales_od (
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by range (order_date)
(
partition sales_p2101 values less than (to_date('2021-01-01', 'YYYY-MM-DD')),
partition sales_p2102 values less than (to_date('2021-02-01', 'YYYY-MM-DD')),
partition sales_p2103 values less than (to_date('2021-03-01', 'YYYY-MM-DD')),
partition sales_p2104 values less than (to_date('2021-04-01', 'YYYY-MM-DD')),
...
partition sales_pmax values less than (MAXVALUE))
);

insert into sales_od values(1,'25-jan-21',10,'west');
select * from sales_od;
select * from sales_od partition(sales_p2102);

--interval partitioning to avoid ORA-14400 inserted partition key does not map to any partition
create table sales_odi (
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by range (order_date)
interval ( NUMTOYMINTERVAL(1, 'MONTH'))
(
partition sales_p2107 values less than (to_date('2021-07-01', 'YYYY-MM-DD')),
partition sales_p2108 values less than (to_date('2021-08-01', 'YYYY-MM-DD')),
partition sales_p2109 values less than (to_date('2021-09-01', 'YYYY-MM-DD')),
partition sales_p2110 values less than (to_date('2021-10-01', 'YYYY-MM-DD')),
partition sales_pmax values less than (MAXVALUE))
);

insert into sales_odi values(1,'25-jan-21',10,'west');
select * from sales_odi;
select * from sales_odi partition(sales_p2102);


--list partitioning
create table sales_r (
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by list (region)
(
partition rw values ('west'),
partition re values ('east'),
partition rns values ('north', 'south')
);

insert into sales_r values(1,'25-jan-21',10,'west');
select * from sales_r;
select * from sales_r partition(rw);

--hash partitioning
create table sales_h (
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by hash (customer_id)
(
partition d1,
partition d2,
partition d3
);

insert into sales_r values(1,'25-jan-21',10,'west');
select * from sales_d;
select * from sales_r partition(d1);
select * from sales_r partition(d2);
select * from sales_r partition(d3);

--composite partitioning (like multi-array)
create table sales_c ( 
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by range (order_date)
subpartition by hash (customer_id) subpartitions 4
(
partition sales_p2101 values less than (to_date('2021-01-01', 'YYYY-MM-DD')),
partition sales_p2102 values less than (to_date('2021-02-01', 'YYYY-MM-DD')),
partition sales_p2103 values less than (to_date('2021-03-01', 'YYYY-MM-DD')),
partition sales_p2104 values less than (to_date('2021-04-01', 'YYYY-MM-DD')),
partition sales_pmax values less than (MAXVALUE))
);

insert into sales_c values(1,'25-jan-21',10,'west');
select * from sales_c;
select * from sales_c partition(sales_p2101);

--show partitions
select * from all_tab_partiotions where table_name like 'SALE%';

--add partition
ALTER TABLE SALES_OD ADD PARTITION
(PARTITION 'P2001' VALUES LESS THAN TO_DATE ('2020-01-01', 'YYYY-MM-DD'));

--drop partition
ALTER TABLE SALES_OD DROP PARTITION P2001;

