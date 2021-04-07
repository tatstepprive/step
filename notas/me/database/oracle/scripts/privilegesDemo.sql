show con_name;
alter session set container=ORCLPDB;
show con_name;

--if common=no then added user only for this pdb
select username, account_status, common 
from dba_users;

-- used user for this session
select username, account_status, common 
from user_users;

--all system privileges (257 rows)
select * from system_privilege_map;

-- create user (he can not yet login)
create user donald identified by donald123;

--check user
select username, account_status, common, created
from dba_users
where common='NO';

--try login (error)
connect donald/donald123@oracledb:1521/orclpdb;
--ORA-01045: user DONALD lacks CREATE SESSION privilege; logon denied

--Start giving system privileges
--grant login
grant create session to donald;
--try login (OK)


--login as donald and check directly given sys privilege
select * from user_sys_privs;

--create table (error)
--ORA-01031: insufficient privileges
create table members(name varchar(255));

--fix create table
grant create table to donald;

-- check directly given sys privileges
select username, privilege from user_sys_privs;

--create table (fixed)
--OK
create table members(name varchar(255));

--insert table (error)
--ORA-01950: no privileges on tablespace 'USERS'
insert into members values('alisa');

--fix insert table as super user
-- the user can now do operations on table insert, update, delete, select table
-- alter table, create refs, index any table in his schema (owned tables) 
-- and drop table	
grant unlimited tablespace to donald;

--check new privilege as donald
select * from user_sys_privs;

--check insert
--OK
insert into members values('alisa');
--now user can insert, update, delete rows in owned tables or drop owned table

--To complete give other privileges to donald as super user
grant create view, create procedure, create sequence, create synonym
to donald;

--Create other table with primary key
create table emp (empid number CONSTRAINT emp_pk PRIMARY KEY,
ename varchar2(100)
);
insert into emp values (1, 'donald');
create sequence emp_seq;
create index ename_ind on emp (ename);
alter table emp add (salary number);
create or replace view emp_v as select empid, ename from emp;
--End giving system privileges

--Give object privileges as super user or hr user
--give access to users schama objects 
--unlarge access to objects in schema (owner (and superuser)) to other simple users
--let look on world of owner (where superuser can look too) to other guests
grant select on hr.employees to donald;

--check privilege when logged in as donald (grantee=donald, owner=hr, table=employees, privilege=select)
--donald has right (he is grantee) to select table owned by hr.
--grantor=hr even if grant given by super user.
select * from user_tab_privs;
select * from hr.employees;

--Give object privileges as super user or hr (owner) user
grant all on hr.locations to donald;

--Check given all privileges on table locations owned by hr (12 rows)
select * from user_tab_privs where table_name='LOCATIONS';
--12 rows -> privileges: alter, delete, index, insert, select, update, references
-- privileges: read, on commit refresh, query rewrite, debug, flashback

--Give object privileges as superuser or hr (owner) user to everyone
grant select on hr.countries to public;
--Every user can select from countries
--Nobody can skip hr prefix now, to fix: create public synonym 
select * from hr.countries;
select * from all_synonyms where table_name='COUNTRIES';
--no rows

--Show all privileges for user given by roles and directly
select * from session_privs;

------- End giving objects privileges--------------

--User can login and change his pass
alter user donald identified by donald123456;

--Show all privileges
--privileges for logged in user from direct grant and roles
select * from session_privs;

--privileges for logged in user from direct grant
select * from user_sys_privs;

--privileges in logged user schema given to outside world (other simple users) 
select * from user_tab_privs;
select * from user_tab_privs_made;
select * from user_tab_privs_recd;

--privileges in logged user schema given to outside world (other simple users) on column base 
select * from user_col_privs;
select * from user_col_privs_made;
select * from user_col_privs_recd;

