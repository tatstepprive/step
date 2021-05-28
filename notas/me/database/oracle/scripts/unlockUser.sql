show con_name;

select con_id, name, open_mode 
from v$containers;

--start creating pluggable db (3 steps: be in root container, )
alter session set container=pdb5;

--unlock user
alter user HR  account unlock;

--unlock user and reset pass
alter user HR identified by <new_pass> account unlock;
