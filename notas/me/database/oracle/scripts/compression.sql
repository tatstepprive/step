show CON_NAME;

select * from v$pdbs;
show user;

select * from dba_users where username='PDB1ADMIN';
------------------------------------------------------
-- limitation rules
-- compress can not be set on table with more then 255 colums
-- compressed table can not drop column, only set column unused
-- compress basic vs compress advanced = normal (indirect) insert with data compressed works only on advanced 
------------------------------------------------------
--TESTING compression

select * from dba_objects;
--about 72 000 rows

--no compression -> NO COMRESS 
create table my_table_01
as
select * from dba_objects where rownum <=10000;

--see nocompress
select dbms_metadata.get_ddl('TABLE','MY_TABLE_01') from dual;

analyze table my_table_01 compute statistics;

--see storage use
select table_name, blocks, pct_free, compression, compress_for
from user_tables where table_name='MY_TABLE_01';
-- output 186 blocks with compression=disabled

---------------------------------------------------------

--basic compression -> COMPRESS works
create table my_table_02 compress basic
as
select * from dba_objects where rownum <=10000;

--see compress basic
select dbms_metadata.get_ddl('TABLE','MY_TABLE_02') from dual;

analyze table my_table_02 compute statistics;

--see storage use
select table_name, blocks, pct_free, compression, compress_for
from user_tables where table_name='MY_TABLE_02';
-- output 43 blocks with compression=enabled compress_for=basic

------------------------------------------------------

--normal (indirect) insert into empty table defined as compress basic -> COMPRESS but NO EFFECTS
create table my_table_O3 compress basic
as select * from dba_objects where 1=2;
--false condition with where creates empty table

select dbms_metadata.get_ddl('TABLE',upper('my_table_O3')) from dual;

--normal insert
insert into my_table_O3
select * from dba_objects where rownum <=10000;

analyze table my_table_O3 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_O3';
-- output 244 blocks with compression=enabled compress_for=basic
-------------------------------------------------------

--direct path insert into empty table defined as compress basic -> COMPRESS works
create table my_table_04 compress basic
as select * from dba_objects where 1=2;
--false condition with where creates empty table

select dbms_metadata.get_ddl('TABLE',upper('my_table_04')) from dual;

--direct insert using append=data is append to the end of the table, by-passing (not using) the buffer cache analize free space
insert /*+ append */ into my_table_04
select * from dba_objects where rownum <=10000;

analyze table my_table_04 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_04';
-- output 43 blocks with compression=enabled compress_for=basic

---------------------------------------------------

--table without compression, after changed to compressed -> COMPRESS works after alter move command
create table my_table_05
as select * from dba_objects where rownum <=10000;;

select dbms_metadata.get_ddl('TABLE',upper('my_table_05')) from dual;

analyze table my_table_05 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_05';
-- output 186 blocks with compression=enabled compress_for=basic

-- set compression --> COMPRESS but NO EFFECTS
alter table my_table_05 compress basic;

analyze table my_table_05 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_05';
-- output 186 blocks with compression=enabled compress_for=basic
-- old data will not compress this way

--FIX compression for old/existent rows
alter table my_table_05 move;

analyze table my_table_05 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_05';
-- output 43 blocks with compression=enabled compress_for=basic
-- old data is compressed

--------------------------------------------------
--advanced compression -> COMPRESS works
create table my_table_06 row store compress advanced
as select * from dba_objects where rownum <=10000;;

analyze table my_table_06 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_06';
-- output 48 blocks with compression=enabled compress_for=advanced

--------------------------------------------------
--normal (indirect) insert into empty table defined as compress advanced -> COMPRESS works
create table my_table_07 row store compress advanced
as select * from dba_objects where 1=2;
--false condition with where creates empty table

select dbms_metadata.get_ddl('TABLE',upper('my_table_07')) from dual;

--normal (indirect) insert
insert into my_table_07
select * from dba_objects where rownum <=10000;

analyze table my_table_07 compute statistics;

select table_name, blocks, pct_free, compression, compress_for
from user_tables
where table_name='MY_TABLE_07';
-- output 50 blocks with compression=enabled compress_for=advanced

--------------------------------------------------
