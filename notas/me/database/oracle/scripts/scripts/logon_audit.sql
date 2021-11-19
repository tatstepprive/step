DROP TRIGGER SYS.LOGON_AUDIT_TRIGGER;

CREATE OR REPLACE TRIGGER SYS.LOGON_AUDIT_TRIGGER
AFTER LOGON
ON DATABASE
begin
  if sys_context('USERENV','SESSIONID') <> 0 then
     insert into login_log values (
          user,
          null,
          sys_context('USERENV','SESSIONID'),
          sys_context('USERENV','HOST'),
          null,
          sysdate,
          null);
     update login_log
     set (osuser, last_program) = 
         (select osuser, program from v$session
          where audsid = sys_context('USERENV','SESSIONID'))
     where sys_context('USERENV','SESSIONID') = session_id;
  end if;
end;
/


DROP TRIGGER SYS.LOGOFF_AUDIT_TRIGGER;

CREATE OR REPLACE TRIGGER SYS.logoff_audit_trigger
before logoff on database
declare
pragma autonomous_transaction;
begin
  if sys_context('USERENV','SESSIONID') <> 0 then
     --
     -- update the logoff day
     --
     update login_log
     set logoff_day = sysdate
     where sys_context('USERENV','SESSIONID') = session_id;
     commit;
  end if;
end;
/


--show logon triggers
select * from dba_triggers where triggering_event like '%LOGON%';
