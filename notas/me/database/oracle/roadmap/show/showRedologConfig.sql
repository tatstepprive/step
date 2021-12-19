--Show redo log config (location, groups, members, size)
select * 
from v$log join v$logfile 
using (group#)
order by group#;
-----------------------------------
--Show groups, 1 row/group
--sequence# = number of switches since db created
--status: current, inactive or invalid (new group or bad situation)
select * from v$log:
-----------------------------------
--Show members (files): 1 row/member
--location
select * from v$logfile;
----------------------------------
