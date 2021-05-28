show con_name;

--set local db/go from root container to a local pdb
alter session set container=orclpdb;

--check values for default profile
select * from dba_profiles;

create profile orclpdb_profile
limit
SESSIONS_PER_USER 4
IDLE_TIME 15
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LIFE_TIME 180;

--check values for new profile
select * from dba_profiles;
-- where column limit=DEFAULT see the value of DEFAULT profile


create user nora identified by nora123;
-- create with profile
--create user mila identified by mila123 profile orclpdb_profile;

grant create session, create table, unlimited tablespace to nora;

alter user nora profile orclpdb_profile;

--check user profile
select * from dba_users where username='NORA';

--check parameter to be able use profile limits, parameter should be true
show parameter resource_limit;
