--Show archive mode (default disabled, recommend: enabled)
--log_mode=ARCHIVELOG if on 
select log_mode from v$database;
--archiver=started if on
select archiver from v$instance;
--in sqlplus SQL> archive log list;

--show archive logs destination
select * from v$archive_dest;

--show log archive name format
-- %d = unique db id
-- %t = thread number (see v$instance thread# column)
-- %r = incarnation number
-- %s = log switch sequence
-- default value= %t_%s_%r.dbf
-- value = arch_%d_%t_%r_%s.log
select * from v$parameter where name like 'log_archive_format';
