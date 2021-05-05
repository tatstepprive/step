--groups
--column status: inactive (=not used), current (=used by LGWr), active (was recent used and will be applied by recovery if db will crash now
--column sequence: LGWr switch counter after db start
--column member: members/group
select * from v$log; --1row/group
--members
--column member: path to physical file
--column status: empty(=ok), stale(=member not yet used), invalid(=problem!)
select * from v$logfile; --1row/member
--Tip: we should monitor invalid members
--force a log switch, LGWR will take other group to write online redo logs
alter system switch logfile;
--write changes to datafiles (sync redo to datafiles)
alter system checkpoint;
--add member
alter database add logfile member '/u01/app/oracle/oradata/ORCL/redo01A.log' to group 1;
alter database add logfile member '/u01/app/oracle/oradata/ORCL/redo02A.log' to group 2;
alter database add logfile member '/u01/app/oracle/oradata/ORCL/redo03A.log' to group 3;
select * from v$logfile;
--output: status=invalid for new members, 
--fix:we need swith multiple times to use each once and state invalid will gone
alter system switch logfile;
alter system switch logfile;
alter system switch logfile;
select * from v$logfile;
