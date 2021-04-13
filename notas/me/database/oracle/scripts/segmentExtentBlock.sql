--Relation: Tablespace-Segments-Extents-Blocks
select * from dba_tablespaces where tablespace_name='TS1';
--see blocksize, initial_extent, max_size

select * from dba_tables where table_name='CITY' and owner='MOLLY';

--no segments if table is empty, segment_name==table_name (table==segment)
select * from dba_segments 
where owner='MOLLY' and segment_name='CITY';
--Segment_subtype=ASSM = automatic storage management
-- if one row, 1 extent, 8 blocks
-- see bytes to know how big is table, table size in bytes

--or use other segment table, for current user (if logged in as molly)
select * from user_segments
where owner='MOLLY' and segment_name='CITY';

--see parameter for deferred (later) segment creation, if true no segments if table empty (default is true)
--if false, segment will be created by table creation, if true segment will be created only by table insertion
show parameter deferred_segment_creation

--set parameter to false, 2 ways
-- 1 way
alter session set deferred_segment_creation=false;
-- 2nd way
create table bla (n nubmer) segment creation immediate;

--reset the parameter deferred_segment_creation to default true, so no segments if no inserts
--deferred=later
alter session set deferred_segment_creation=true;
create table bla2 (n number) segment creation deferred;

--extents info
select * from dba_extents
where owner='MOLLY' and segment_name='CITY';

--insert 1000 rows
begin
for i in 1..1000
loop
insert into molly.city values(i, 'london');
end loop;
commit;
end;
--without / select query will be not executed
/
select * from molly.city;

--insert 1000 rows
begin
for i in 1..1000
loop
insert into molly.city values(i, 'antwerp');
end loop;
commit;
end;
/

select * from molly.city;
--insert 1000000 rows (1 mil rows)
begin
for i in 1..1000000
loop
insert into molly.city values(i, 'bruges');
end loop;
commit;
end;
/
--check segment and extent info
-- segment info
select * from dba_segments 
where owner='MOLLY' and segment_name='CITY';
--34 extents

--extents info
select * from dba_extents
where owner='MOLLY' and segment_name='CITY';
--row count=34

--rowid info
select rowid, id, name from molly.city where id=1000000;
--output rowid=AAAR1cAAcAAAAUFAAP=AAAR1c AAc AAAAUF AAP
--rowid is pseudo column
--exp: rowid 000000FFFBBBBBBRRR
--000000 object number
--FFF relative file number
--BBBBBB data block number
--RRR row number
--this is the info for find data in datafile
