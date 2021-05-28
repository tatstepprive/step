show con_name;

select con_id, name, open_mode 
from v$containers;

--start creating pluggable db (3 steps: be in root container, )
alter session set container=cdb$root;

-- source pdb can be open, but it's not recommended
create pluggable database pdb5 from orclpdb
  file_name_convert =('/u01/app/oracle/oradata/ORCL/orclpdb/',
                      '/u01/app/oracle/oradata/ORCL/pdb5/');
-- check created db => new pdb1 will be in mode MOUNTED
select con_id, name, open_mode 
from v$containers;

alter session set container=pdb5;

alter pluggable database open;

-- 35 users + 1 user pdb1admin= 36 users
select con_id, username, default_tablespace, common
from cdb_users;

--show all datafiles (dbf files) without TEMP datafile
select con_id, file#, name 
from v$datafile;

--show all datafiles includes TEMP datafile
select * from v$tablespace;

