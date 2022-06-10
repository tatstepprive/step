--show if the database is dataguard 
select protection_level from v$database;
--UNPROTECTED if no dataguard
