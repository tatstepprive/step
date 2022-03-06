--show version 
select * from v$version;
select banner from v$version;
--show features versions (all should have the same version as db, except APEX that has own upgrade routine)
select * from dba_registry;
select comp_id, version from dba_registry;
