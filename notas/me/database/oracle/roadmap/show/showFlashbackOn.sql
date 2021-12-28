--Show flashback on (default disabled, recommend: enabled)
--FLASHBACK_ON=NO if disabled, =YES if enabled 
select FLASHBACK_ON from v$database;
--Show recyclebin on (default) to execute: flashback table t1 to before drop;
--cat be set to off on session or system level
select * from v$parameter where name='recyclebin';
