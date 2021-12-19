------------------------------------------
--Add group
alter database add logfile
     ('/u01/app/oracle/oradata/orcl/redo_g4m1.rdo',
      '/u01/app/oracle/oradata/orcl/redo_g4m2.rdo')
     size 50m;
-------------------------------------------
-- Add member to group (online operation: db open)
alter database add logfile member
'path'
to group 1;

--check
select * from v$logfile;

--Cycle logfile group until status not INVALID for member
alter system switch logfile;
--------------------------------------------
-- rename redo log memeber (file) (see v$logfile) (offline operation:db down)
--steps: 
--shutdown; 
--mv /diska/logs/log1a.rdo /diskc/logs/log1c.rdo; 
--STARTUP MOUNT; 
ALTER DATABASE RENAME FILE '/diska/logs/log1a.rdo' TO '/diskc/logs/log1c.rdo';
--ALTER DATABASE OPEN; 
---------------------------------------------
--drop redo group
-- conditions: min 2 groups available, status group INACTIVE
-- if OMF (oracle managed files) used: member files will be auto removed on OS
-- if no OMF used: remove member files on OS self
alter database drop logfile group 3;
---------------------------------------------
--drop member
-- conditions: min 2 members in group  available, status group INACTIVE
-- remove member file on OS self alfter sql command
alter database drop logfile member '/diskc/logs/log1c.rdo';
--------------------------------------------
--Resize redo logs (online operation)
--check current size
select group#,members,status,bytes/1024/1024 as mb from v$log;
--check location
select group#,member from v$logfile;
alter database add logfile
     ('/u01/app/oracle/oradata/orcl/redo_g4m1.rdo',
      '/u01/app/oracle/oradata/orcl/redo_g4m2.rdo')
     SIZE 100m;
alter database add logfile
     ('/u01/app/oracle/oradata/orcl/redo_g5m1.rdo',
      '/u01/app/oracle/oradata/orcl/redo_g5m2.rdo')
     size 100m;
alter database add logfile
     ('/u01/app/oracle/oradata/orcl/redo_g6m1.rdo',
      '/u01/app/oracle/oradata/orcl/redo_g6m2.rdo')
     size 100m;
-- drop group inactive, never drop active or current
select group#,members,status,bytes/1024/1024 as mb from v$log;
alter database drop logfile group 1;
alter database drop logfile group 2;

-- take in use new added group
alter system switch logfile;

--get rid from active group 
alter system checkpoint;
alter database drop logfile group 3;

--test all new redo log groups by cycling
alter system switch logfile;
-----------------------------------------
