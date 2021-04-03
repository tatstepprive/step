show con_name;

select con_id, name, open_mode 
from v$containers;

--start creating pluggable db (3 steps: be in root container, )
alter session set container=pdb5;

alter user HR identified by <new_pass> account unlock;
