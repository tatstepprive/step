--connect to pdb and execute next commands
select * from dba_tablespaces;
select * from v$tablespace;

select * from database_properties where property_name like '%TABLESPACE%';

select * from database_properties where property_name in ('GLOBAL_DB_NAME','DEFAULT_PERMANENT_TABLESPACE', 'DEFAULT_TEMP_TABLESPACE');

create user billy IDENTIFIED by billy123;

select dbms_metadata.get_ddl('USER', 'BILLY') from dual;
-- we will see the default tablespace and temp tablespace used by user creation

select * from dba_users where username='BILLY';
-- we will se the default tablespaces in columns DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE

select * from dba_users where common='NO';

select dbms_metadata.get_ddl('USER', 'DEMO') from dual;

create table billy.animal (id number, name varchar2(100));
--OK
insert into billy.animal values (1, 'cat');
--ORA-01950: no privileges on tablespace 'USERS', even if working as super user
insert into billy.animal values (2, 'dog');
--ORA-01950: no privileges on tablespace 'USERS', even if working as super user

--Fix ORA-01950: no privileges on tablespace 'USERS'
grant unlimited tablespace to billy;

insert into billy.animal values (1, 'cat');
--OK
insert into billy.animal values (2, 'dog');
--OK

select * from dba_tablespaces;
select * from v$tablespace;

--data files info
select * from dba_data_files;
select * from v$datafile;

--temp file info
select * from dba_temp_files;
select * from v$tempfile;
-------------------------------------------------
--system tablespace is 99%, find out non system users using system tablespace
SELECT owner, segment_name, segment_type, segment_type
FROM dba_segments
WHERE owner NOT IN ('SYS', 'SYSTEM') –-You can add more oracle default users
AND tablespace_name = 'SYSTEM';
--Use the ‘ALETER TABLE … MOVE TABLESPACE …’ for tables and ‘ALTER INDEX … REBUILD TABLESPACE …’ to move these segments out of the system tablepsace.
--or resize tablespace
------------------------------------------------
--system tablespace analyse content
SELECT owner, segment_name, segment_type, bytes/(1024*1024) size_m

FROM dba_segments

WHERE tablespace_name = 'SYSTEM'

ORDER BY size_m DESC;
----------------------------------------------
