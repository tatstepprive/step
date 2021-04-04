show con_name;

select con_id, name, open_mode
from v$pdbs;

alter session set container=CDB$ROOT;
show con_name;

alter pluggable database pdb5 close immediate;

-- pdb5 is mounted
select con_id, name, open_mode
from v$pdbs;

alter pluggable database pdb5 unplug into '/u01/app/oracle/oradata/pdb5.xml';

-- keep datafiles 
drop pluggable database pdb5 keep datafiles;

--check if dropped pdb not more in pdbs 
select con_id, name, open_mode 
from v$pdbs;

/*
declare
 l_result boolean;
 begin
 l_result :=dbms_pdb.check_plug_compatibility(
pdb_descr_file => '/u01/app/oracle/oradata/pdb5.xml',
pdb_name => 'PDB5');
if l_result then 
 dbms_output.put_line('compatible');
else 
 dbms_output.put_line('incompatible');
end if;
end;
*/

create pluggable database pdbtest
using '/u01/app/oracle/oradata/pdb5.xml'
FILE_NAME_CONVERT=('/u01/app/oracle/oradata/ORCL/pdb5/',
                   '/u01/app/oracle/oradata/ORCL/pdbtest/');
--In stead of FILE_NAME_CONVERT we can use NOCOPY TEMPFILE REUSE; 
--Then no copy datafiles executed and datafiles from old location will be used
--Dont use this option

--check new db added
select con_id, name, open_mode 
from v$pdbs;

--open new db
alter pluggable database pdbtest open;
