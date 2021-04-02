show con_name;

select con_id, name, open_mode 
from v$containers;

alter session set container=PDB$SEED;

select con_id, username, default_tablespace, common
from cdb_users;

--the same as from cdb_users, all=35 users(rows)
select username, default_tablespace, common
from dba_users;

--show all datafiles (dbf files) without TEMP datafile
select con_id, file#, name 
from v$datafile;

--show all datafiles includes TEMP datafile
select * from v$tablespace;

--start creating pluggable db (3 steps: be in root container, )
alter session set container=cdb$root;

create pluggable database pdb1
  admin user pdb1admin identified by welcome
  roles = (dba)
  default tablespace users
  datafile '/u01/app/oracle/oradata/ORCL/pdb1/users01.dbf'
  size 250M autoextend on
  file_name_convert =('/u01/app/oracle/oradata/ORCL/pdbseed/',
                      '/u01/app/oracle/oradata/ORCL/pdb1/');
-- check created db => new pdb1 will be in mode MOUNTED
select con_id, name, open_mode 
from v$containers;

alter session set container=pdb1;

alter pluggable database open;

-- 35 users + 1 user pdb1admin= 36 users
select con_id, username, default_tablespace, common
from cdb_users;

--show all datafiles (dbf files) without TEMP datafile
select con_id, file#, name 
from v$datafile;

--show all datafiles includes TEMP datafile
select * from v$tablespace;

