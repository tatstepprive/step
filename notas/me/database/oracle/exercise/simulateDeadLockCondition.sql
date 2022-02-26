--simulate DEADLOCK lock condition (working with 2 sessions)
--auto resolved in 3 seconds, no dba action needed except to contact developer team to inform
--and hope the client code will be improved
--short exec plan steps: rowA_s1--rowB_s2--rowB_s1--rowA_s2 (rowX_sx=rowX_sessionx X=A,B x=1,2)
--===1 session===============================
--show connection info
select sys_context('USERENV','SESSIONID') from dual;
--375110
select userenv('SESSIONID') from dual;
--375110

--create table if does not exist
create table lockdemo as select * from all_users;

--check not used user_id
select * from lockdemo where  user_id=99;
--no rows

select * from lockdemo where username='SYS';
--user_id=0
select * from lockdemo where username='SYSTEM';
--user_id=9

--STEP1 (session 1)
update lockdemo set user_id=99 where username='SYS';
--no commit!

--===2nd session===============================
select sys_context('USERENV','SESSIONID') from dual;
--375121
select userenv('SESSIONID') from dual;
--375121

select * from lockdemo where username='SYS';
--user_id=0
select * from lockdemo where username='SYSTEM';
--user_id=9

--check not used user_id
select * from lockdemo where  user_id=777;
--no rows (100 is used)

--STEP2 (session 2)
update lockdemo set user_id=777 where username='SYSTEM';
--no commit!
--no hangs, because different row update than used in 1st session

--===1 session(again) ===============================

--STEP3 (session 1)
update lockdemo set user_id=999 where username='SYSTEM';
--same row, hangs

--===2nd session(again) DEADLOCK simulation===============================

--STEP4 (session 2)
update lockdemo set user_id=7777 where username='SYS';
--same row, hagns 3 sec 

--===1 session(again) ===============================
--ORA-00060: deadlock detected while waiting for resource

--===============================
--to analyse: find info in trace
--path to trace
select value from v$diag_info where name='Diag Trace';
ssh oracle_user@oracle_db
cd <value>
grep -in ORA-00060 alert_<sid>.log
--output: ORA-00060: Deadlock detected. See Note 60.1 at My Oracle Support for Troubleshooting ORA-60 Errors. More info in file <path_and_file>.
--<path>/trace/<filename>.trc
cat <path_and_file>


