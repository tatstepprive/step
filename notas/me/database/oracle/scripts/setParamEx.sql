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
