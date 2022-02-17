--show privileges on directories
SELECT *
from all_tab_privs
where table_name in
  (select directory_name
   from dba_directories);

--show all directories and path on OS
select * from dba_directories;
