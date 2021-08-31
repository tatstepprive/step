-- show db version
select * from v$version;

--show installed components
select * from dba_registry;

--show db name 
select name from v$instance;

--show db unique number (DBID=xxxxxxx where x=1-9)
select dbid from v$database;

--show connection info
SELECT SYS_CONTEXT('USERENV','SERVER_HOST') FROM dual;
SELECT host_name FROM v$instance;
SELECT terminal, machine FROM v$session WHERE username = 'HR';
