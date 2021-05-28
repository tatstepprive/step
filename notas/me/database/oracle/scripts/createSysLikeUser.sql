--execute in root container
show con_name;
show user;
create user c##copysis identified by copysis
default tablespace users temporary tablespace temp account unlock;

grant connect, dba, sysdba to c##copysis container=all;

--check
select * from dba_users where username='C##COPYSIS';

-- connect via sqlplus / as sysdba;
-- sql> connect c##copysis/copysis@orcl as sysdba
-- sql> select * from session_privs; --253 rows
-- sql> connect c##copysis/copysis@orcl
-- sql> select * from session_privs; --237 rows
