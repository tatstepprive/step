--session id from environment
--both function return audit session id, same as V$SESSION.AUDSID
select sys_context('USERENV','SESSIONID') from dual;
select userenv('SESSIONID') from dual;
--375227 --unique id during lifetime of db

--not the same as used in v$session view
--V$SESSION.SID is not unique id for audition, it's unique in time, but reused when session is gone

--Mapping
select *
from V$SESSION
where AUDSID = userenv('SESSIONID');

select *
from V$SESSION
where AUDSID=375227;
--sid=69 serial#=11103 audsid=375227
--audsid is never null
