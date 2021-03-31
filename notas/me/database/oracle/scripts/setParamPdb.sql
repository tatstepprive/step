show con_name;

select name, open_mode from v$pdbs;

alter pluggable database all open;

-- params only currently in effect for the session
select name, value, isses_modifiable, issys_modifiable, ispdb_mpdifiable, con_id
from v$parameter
order by name;

select name, value, isses_modifiable, issys_modifiable, ispdb_mpdifiable, con_id
from v$parameter
where name='control_files';
-- issys_modifiable=false, it's static param but can be changed in spfile and restart db needed
-- issys_modifiable=immediate, changes can take effect immediate
-- issys_modifiable=deferred, changes can take effect for future sessions

--v$parameter vs v$parameter2: v$parameter2 is more readable in case the value is multiline (by showing multiple rows with same param and each value)
--name/value1,value2,valuen 
select name, value, isses_modifiable, issys_modifiable, ispdb_mpdifiable, con_id
from v$parameter2
where name='control_files';

--v$system_parameter: shows instance level params (=> all sessions inherit)
-- isdefault=true/false (when false then param is set(overwritten) in spfile/pfile
-- con_id=0 is instance level
select * from v$system_parameter;
select * from v$system_parameter where isdefault='FALSE';


alter session set nls_date_format='dd-mm-yyyy';
--no changes in v$system_parameter (extra info: value is null for nls_date_format param because it's derived. direved=calculated on ohter params)
select name, value, isses_modifiable, issys_modifiable, ispdb_mpdifiable, con_id
from v$system_parameter
where name='nls_date_format';
-- changes in v$parameter
select name, value, isses_modifiable, issys_modifiable, ispdb_mpdifiable, con_id
from v$parameter
where name='nls_date_format';

--v$system_parameter vs v$system_parameter2: v$system_parameter2 is more readable in case the multi values
--name/value1,value2,valuen 
select name, value, isses_modifiable, issys_modifiable, ispdb_mpdifiable, con_id
from v$system_parameter2
where name='control_files';

--open_cursors specifies max number of open cursors a session can have at once
select name,value,issec_modifiable, issys_modifiable, ispdb_modifiable, conn_id
from v$parameter
where name='open_cursors';

show parameter spfile;

alter system set open_cursors=301;
--same as alter system set open_cursors=301 scope=both;
