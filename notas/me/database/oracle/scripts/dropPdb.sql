show con_name;

select con_id, name, open_mode 
from v$containers;

alter session set container=CDB$ROOT;
show con_name;

alter pluggable database pdb1 close;

-- all datafiles will be removed, but dir name pdb1 will stay
drop pluggable database pdb1 including datafiles;

--check if dropped pdb not more in containers 
select con_id, name, open_mode 
from v$containers;
