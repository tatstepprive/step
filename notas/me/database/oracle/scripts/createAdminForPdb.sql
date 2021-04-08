--execute in root container
show con_name;
show user;
--switch in pdb
alter session set container=orclpdb;

create user orclpdb_admin identified by orclpdb_admin
default tablespace users temporary tablespace temp account unlock;

grant connect, dba to orclpdb_admin;

--check
select * from dba_users where username='ORCLPDB_ADMIN';

-- connect via sqlplus / as sysdba;
-- sql> connect orclpdb_admin/orclpdb_admin@orclpdb
-- sql> select * from session_privs; --237 rows
