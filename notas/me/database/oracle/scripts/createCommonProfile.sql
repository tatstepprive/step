show con_name;

--check values for default profile
select * from dba_profiles;

create profile c##general
limit
SESSIONS_PER_USER 4
IDLE_TIME 15
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LIFE_TIME 180
container=all;

--check values for new profile
select * from dba_profiles;
-- where column limit=DEFAULT see the value of DEFAULT profile


create user c##alice identified by alice container=all;
-- create with profile
--create user c##robin identified by robin123 profile c##general container=all;

grant create session, create table, unlimited tablespace to c##alice container=all;

--change profile
alter user c##alice profile c##general container=all;

--check user profile
select * from dba_users where username='C##ALICE';

--check parameter to be able use profile limits, parameter should be true
show parameter resource_limit;
