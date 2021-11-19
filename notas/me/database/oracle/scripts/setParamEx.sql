select name, value
from v$parameter
order by name;

select name,value,isses_modifiable,issys_modifialbe,ispdb_modifiable 
from v$parameter
where name='nls_date_format';

select sysdate from dual;

alter session set nls_date_format='dd-mm-yyyy';
-- or change in sqldevelop via menu Tools,Preferences, in tree Database, NLS (it will be session level change)

select sysdate from dual;

--query all params modifiable on session level
select name, value, isses_modifiable, issys_modifiable, ispdb_modifiable
from v$parameter
where isses_modifiable='true';

--show diff what in memory and what in spfile on disk, use 
--v$spparameter view which contains info from spfile only
select * from v$spparameter;

--show byte or char, use char on session level and use byte on database level
select parameter, value , 'session' as my_level from nls_session_parameters where parameter = 'NLS_LENGTH_SEMANTICS'
union all
select parameter, value , 'database' as my_level from nls_database_parameters where parameter = 'NLS_LENGTH_SEMANTICS'
union all
select parameter, value , 'instance' as my_level from nls_instance_parameters where parameter = 'NLS_LENGTH_SEMANTICS';
