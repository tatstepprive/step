--simulate lock condition (working with 3 sessions)

--===1 session===============================
--show connection info
select sys_context('USERENV','SESSIONID') from dual;
--374912
select userenv('SESSIONID') from dual;
--374912

create table lockdemo as select * from all_users;

--check not used user_id
select * from lockdemo where  user_id=99;
--no rows

--start blocking (do DML and wait with commit)
update lockdemo set user_id=99 where username='SYS';

--===2nd session===============================
select sys_context('USERENV','SESSIONID') from dual;
--374913
select userenv('SESSIONID') from dual;
--374913

select * from lockdemo;
--no issue
select * from lockdemo where username='SYS';
--no issue

--check not used user_id
select * from lockdemo where  user_id=101;
--no rows (100 is used)

update lockdemo set user_id=101 where username='SYS';
--HANGS

--when killing of 1st session happens, this 2nd session will stop hanging and have ORA and contunue update 
--ORA-01013: user requested cancel of current operation 

--===3d session with SYSTEM or SYS (monitoring and resolving)===============================
--mapping between env session id which is audit session always unique and sid which is reused
select *
from V$SESSION
where AUDSID = 374912;
--sid=88 serial=10868

select *
from V$SESSION
where AUDSID = 374913;
--sid=1 serial=9755

--Show blocking issue
select username, sid, serial#, blocking_session
from v$session
where blocking_session is not null;
--sid=1  serial#=9755 blocking_session=88
--if no one hangs, no rows even the session that can block exist, but now is not blocking so no result

--Show blocking issue = Session of blocked and blokker
select a.SID "Blocking Session", b.SID "Blocked Session"  
from v$lock a, v$lock b 
where a.SID != b.SID and a.ID1 = b.ID1  and a.ID2 = b.ID2 and 
b.request > 0 and a.block = 1;


---Show blocking issue = Session of blocked and blokker with connection details
select s1.username || '@' || s1.machine
 || ' ( SID=' || s1.sid || ' ) is blocking '
 || s2.username || '@' || s2.machine 
 || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
 from v$lock l1, v$session s1, v$lock l2, v$session s2
 where s1.sid=l1.sid and s2.sid=l2.sid
 and l1.BLOCK=1 and l2.request > 0
 and l1.id1 = l2.id1
 and l2.id2 = l2.id2 ;

---Show Lock Wait Time (nice to use in monitoring)
SELECT 
  blocking_session "BLOCKING_SESSION",
  sid "BLOCKED_SESSION",
  serial# "BLOCKED_SERIAL#",
  seconds_in_wait "WAIT_TIME(SECONDS)",
  round(seconds_in_wait/60) "WAIT_TIME(MINUTES)"
FROM v$session
WHERE blocking_session is not NULL
ORDER BY blocking_session;

--Show Blocked SQL (sql that hangs without termination) using parameter
SELECT SES.SID, SES.SERIAL# SER#, SES.PROCESS OS_ID, SES.STATUS, SQL.SQL_FULLTEXT
FROM V$SESSION SES, V$SQL SQL, V$PROCESS PRC
WHERE
   SES.SQL_ID=SQL.SQL_ID AND
   SES.SQL_HASH_VALUE=SQL.HASH_VALUE AND 
   SES.PADDR=PRC.ADDR AND
   SES.SID=&Enter_blocked_session_SID;
   
--Show Blocked SQL (sql that hangs without termination)
   SELECT SES.SID, SES.SERIAL# SER#, SES.PROCESS OS_ID, SES.STATUS, SQL.SQL_FULLTEXT
FROM V$SESSION SES, V$SQL SQL, V$PROCESS PRC
WHERE
   SES.SQL_ID=SQL.SQL_ID AND
   SES.SQL_HASH_VALUE=SQL.HASH_VALUE AND 
   SES.PADDR=PRC.ADDR AND
   SES.SID=1;
   
 --Show Locked Table  
select lo.session_id,lo.oracle_username,lo.os_user_name,
lo.process,do.object_name,do.owner,
decode(lo.locked_mode,0, 'None',1, 'Null',2, 'Row Share (SS)',
3, 'Row Excl (SX)',4, 'Share',5, 'Share Row Excl (SSX)',6, 'Exclusive',
to_char(lo.locked_mode)) mode_held
from gv$locked_object lo, dba_objects do
where lo.object_id = do.object_id
order by 5;

--Resolve lock by killing the blokker
--alter system kill session 'SID,Serial#';
--alter system kill session 'Blocking_SID,Serial#';
--find serial#
select serial# from v$session where SID=88;
--kill 
alter system kill session '88,10868';
--=================================================================











