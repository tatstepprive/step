-- show db version
select * from v$version;

--show installed components
select * from dba_registry;

--show db name 
select name from v$instance;

--show db unique number (DBID=xxxxxxx where x=1-9)
select dbid from v$database;
