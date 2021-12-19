------------------------------------------
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
