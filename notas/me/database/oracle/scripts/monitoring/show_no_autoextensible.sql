column file_name format a50
set linesize 300;
select file_name, tablespace_name, autoextensible from dba_data_files where autoextensible='NO';
