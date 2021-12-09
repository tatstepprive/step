CREATE OR REPLACE PROCEDURE SYS.SEND_MSG_PROC
(my_subj IN varchar2, my_msg IN varchar2)
IS
begin
execute immediate 'alter session set smtp_out_server=''yourhost.yourdomain''';
utl_mail.send( sender => 'monitor@yourdoomain',
               recipients => 'person_a@yourdomain;person_b@yourdomain',
               subject => my_subj,
               MESSAGE => my_msg);
end;
/


---Show procedure text
select text from all_source where name like 'SEND_MS%' order by line;

--show db info
info over db:
select dbid,host_name, name, db_unique_name, database_role, log_mode, 
flashback_on, version from v$database, v$instance where instance_name=name;

-- monitor invalid objects procedure
CREATE OR REPLACE PROCEDURE SYS.MON_INVALID_OBJ_PROC
AS
cursor syno is
     select d.owner, d.object_name, d.object_type, d.status
     from dba_objects d
     where d.status='INVALID';
v_target_count number;
msg_str varchar2(3000);
my_columns varchar2(200) :='OWNER'||chr(9)||'OBJECT_NAME'||chr(9)||'OBJECT_TYPE'||chr(9)||'STATUS';
my_db varchar2(30);
my_host varchar2(64);
my_subj varchar(150);
begin
   select DB_UNIQUE_NAME into my_db 
   from v$database;
   select host_name into my_host 
   from v$instance;
   select count(*) into v_target_count
   from dba_objects 
   where status='INVALID';
   my_subj:='ALERT invalid objects '||my_db||chr(32)||my_host;
   msg_str:='WARNING: invalid objects';
   msg_str:=msg_str||chr(10)||chr(13)||my_columns;
   for syno_rec in syno 
   loop
   msg_str:=msg_str||chr(10)||chr(13)||syno_rec.owner||chr(9)||syno_rec.object_name||chr(9)||syno_rec.object_type||chr(9)||syno_rec.status;
   end loop;
   if v_target_count <> 0
   then
   dbms_output.put_line(my_subj);
   dbms_output.put_line('There are invalid objects found');
   dbms_output.put_line(msg_str);
   SEND_MSG_PROC(my_subj, 'Hello dba,'||chr(10)||chr(13)||msg_str||chr(10)||chr(13)||'Have a nice day!');
   else
     dbms_output.put_line('NO '||my_subj);
     dbms_output.put_line('No invalid objects found');
   end if;
end;
/

--Setup scheduler
begin
dbms_scheduler.create_job(
job_name=>'mon_invalid_obj',
job_type=>'stored_procedure',
job_action=>'SYS.MON_INVALID_OBJ_PROC',
start_date=>sysdate,
repeat_interval=>'freq=daily;byhour=7,13,17;byminute=01',
enabled=>true,
auto_drop=>false);
end;
/

--===============================================
--Monitor synonyms with no target (target removed, synonyms stays)
CREATE OR REPLACE PROCEDURE SYS.MON_SYN_NO_TARGET_PROC
AS
cursor curr is
     select s.owner, s.synonym_name, s.table_owner, s.table_name
     from all_synonyms s
     where
     s.table_name not in (select object_name from dba_objects where owner=s.table_owner)
     order by owner desc;
v_target_count number;
msg_str varchar2(3000);
my_columns varchar2(200) :='OWNER'||chr(9)||'SYNONYM_NAME'||chr(9)||'TABLE_OWNER'||chr(9)||'TABLE_NAME';
my_db varchar2(30);
my_host varchar2(64);
my_subj varchar(150);
begin
   select DB_UNIQUE_NAME into my_db
   from v$database;
   select host_name into my_host
   from v$instance;
   select count(*) into v_target_count
     from all_synonyms s
     where
     s.table_name not in (select object_name from dba_objects where owner=s.table_owner);
   my_subj:='ALERT dead target for synonym '||my_db||chr(32)||my_host;
   msg_str:='WARNING: dead target for synonym';
   msg_str:=msg_str||chr(10)||chr(13)||my_columns;
   for curr_rec in curr
   loop
   msg_str:=msg_str||chr(10)||chr(13)||curr_rec.owner||chr(9)||curr_rec.synonym_name||chr(9)||curr_rec.table_owner||chr(9)||curr_rec.table_name;
   end loop;
   if v_target_count <> 0
   then
   dbms_output.put_line(my_subj);
   dbms_output.put_line('There are dead targets for synonyms found');
   dbms_output.put_line(msg_str);
   SEND_MSG_PROC(my_subj, 'Hello dba,'||chr(10)||chr(13)||msg_str||chr(10)||chr(13)||'Have a nice day!');
   else
     dbms_output.put_line('NO '||my_subj);
     dbms_output.put_line('No dead targets for synonyms found');
   end if;
end;
/
begin
 SYS.MON_SYN_NO_TARGET_PROC;
end;
/
begin
dbms_scheduler.create_job(
job_name=>'mon_syn_no_target',
job_type=>'stored_procedure',
job_action=>'SYS.MON_SYN_NO_TARGET_PROC',
start_date=>sysdate,
repeat_interval=>'freq=daily;byhour=6,12,16;byminute=01',
enabled=>true,
auto_drop=>false);
end;
/
--Recreate invalid synonyms (target changed, synonyms became invalid)
CREATE OR REPLACE PROCEDURE SYS.RECREATE_INVALID_SYN_PROC
AS
cursor syno is
   select a.owner, a.synonym_name, a.table_owner, a.table_name
   from all_synonyms a, dba_objects d
   where d.object_type='SYNONYM'
   and d.status='INVALID'
   and d.object_name=a.synonym_name
   and d.owner=a.owner;
ddl_str varchar2(1000);
begin
   for syno_rec in syno
   loop
     execute immediate q'[SELECT regexp_replace((DBMS_LOB.substr((select dbms_metadata.get_ddl('SYNONYM', ']'||syno_rec.synonym_name||q'[',']'||syno_rec.owner||q'[') from dual),1000)),'(\s)',' ') from dual]' into ddl_str;
     dbms_output.put_line(ddl_str||';');
      begin
         execute immediate ddl_str;
      exception
         when others then
         dbms_output.put_line(SQLERRM);
      end;
   end loop;
end;
/

begin
dbms_scheduler.create_job(
job_name=>'mon_recreate_inv_syn',
job_type=>'stored_procedure',
job_action=>'SYS.RECREATE_INVALID_SYN_PROC',
start_date=>sysdate,
repeat_interval=>'freq=daily;byhour=6,13,17;byminute=45',
enabled=>true,
auto_drop=>false);
end;
/
--============================================
--Monitor tablespace high usage (temp not incluced)
CREATE OR REPLACE PROCEDURE SYS.MON_TBS_PROC
AS
v_perc number:=85;
cursor syno is
 select
   a.tablespace_name,
   100 - round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100) Pct_used,
   (select 'WARNING: FULL or ALMOST FULL' from dual where 100 - round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100)>v_perc) status --Pct_used > 85%
   from ( select f.tablespace_name, sum(f.bytes) bytes_alloc,
   sum(decode(f.autoextensible, 'YES',f.maxbytes,'NO', f.bytes)) maxbytes
from
   dba_data_files f
group by
   tablespace_name) a,
(  select
      f.tablespace_name,
      sum(f.bytes) bytes_free
   from
      dba_free_space f
group by
      tablespace_name) b
where
      a.tablespace_name = b.tablespace_name (+)
      and (select 'WARNING: FULL or ALMOST FULL' from dual where 100 - round((nvl(b.bytes_free, 0) / a.bytes_alloc) * 100)>v_perc) like 'WARNING%'
ORDER BY 2 desc;
v_target_count number:=0;
msg_str varchar2(6000);
my_columns varchar2(200) :='TABLESPACE_NAME'||chr(9)||'PTC_USED'||chr(9)||'STATUS';
my_db varchar2(30);
my_host varchar2(64);
my_subj varchar(150);
begin
   select DB_UNIQUE_NAME into my_db
   from v$database;
   select host_name into my_host
   from v$instance;
   my_subj:='ALERT tablespace high usage '||my_db||chr(32)||my_host;
   msg_str:='WARNING: tablespace high usage >'||v_perc||chr(37);
   msg_str:=msg_str||chr(10)||chr(13)||my_columns;
   for syno_rec in syno
   loop
   v_target_count:=v_target_count+1;
   msg_str:=msg_str||chr(10)||chr(13)||syno_rec.tablespace_name||chr(9)||syno_rec.Pct_used||chr(37)||chr(9)||syno_rec.status;
   end loop;
   if v_target_count <> 0
   then
   dbms_output.put_line(my_subj);
   dbms_output.put_line('The tablespace high usage found');
   dbms_output.put_line(msg_str);
   SEND_MSG_PROC(my_subj, 'Hello dba,'||chr(10)||chr(13)||msg_str||chr(10)||chr(13)||'Have a nice day!');
   else
     dbms_output.put_line('NO '||my_subj);
     dbms_output.put_line('No tablespace high usage found');
   end if;
end;
/



begin
dbms_scheduler.create_job(
job_name=>'mon_tbs',
job_type=>'stored_procedure',
job_action=>'SYS.MON_TBS_PROC',
start_date=>sysdate,
repeat_interval=>'freq=daily;byhour=6,13,17;byminute=45',
enabled=>true,
auto_drop=>false);
end;
/

--==============================================================
--Monitor byte to char
CREATE OR REPLACE PROCEDURE SYS.MON_BYTE2CHAR_PROC
AS
cursor curr is
  select OWNER,
         TABLE_NAME,
         COLUMN_NAME,
         DATA_TYPE||' ('||DATA_LENGTH||')' "DATA_TYPE",
         CHAR_USED
  from ALL_TAB_COLUMNS
  where OWNER NOT IN('APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','FLOWS_FILES','GSMADMIN_INTERNAL','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','ORDSYS','OUTLN','PERFSTAT','SYS','SYSTEM','WMSYS','XDB')
  and TABLE_NAME not in (select v.TABLE_NAME from ALL_TAB_COMMENTS v where OWNER NOT IN ('APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','FLOWS_FILES','GSMADMIN_INTERNAL','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','ORDSYS','OUTLN','PERFSTAT','SYS','SYSTEM','WMSYS','XDB') and TABLE_TYPE = 'VIEW')
  and CHAR_USED='B'
  and TABLE_NAME not in (select TABLE_NAME from all_part_tables apt where apt.owner=owner and apt.table_name=table_name) --exclude partitioned tables
  order by OWNER, TABLE_NAME;
v_target_count number:=0;
msg_str varchar2(6000);
my_columns varchar2(200) :='OWNER'||chr(9)||'TABLE_NAME'||chr(9)||'COLUMN_NAME'||chr(9)||'DATA_TYPE'||chr(9)||'CHAR_USED';
my_db varchar2(30);
my_host varchar2(64);
my_subj varchar(150);
begin
   select DB_UNIQUE_NAME into my_db
   from v$database;
   select host_name into my_host
   from v$instance;
   my_subj:='ALERT byte to char '||my_db||chr(32)||my_host;
   msg_str:='WARNING: byte to char ';
   msg_str:=msg_str||chr(10)||chr(13)||my_columns;
   for curr_rec in curr
   loop
   v_target_count:=v_target_count+1;
   msg_str:=msg_str||chr(10)||chr(13)||curr_rec.owner||chr(9)||curr_rec.table_name||chr(9)||curr_rec.column_name||chr(9)||curr_rec.data_type||chr(9)||curr_rec.char_used;
   end loop;
   if v_target_count <> 0
   then
   dbms_output.put_line(my_subj);
   dbms_output.put_line('The table byte to char found');
   dbms_output.put_line(msg_str);
   SEND_MSG_PROC(my_subj, 'Hello dba,'||chr(10)||chr(13)||msg_str||chr(10)||chr(13)||'Have a nice day!');
   else
     dbms_output.put_line('NO '||my_subj);
     dbms_output.put_line('No table byte to char found');
   end if;
end;
/

--scheduler
begin
dbms_scheduler.create_job(
job_name=>'mon_byte2char',
job_type=>'stored_procedure',
job_action=>'SYS.MON_BYTE2CHAR_PROC',
start_date=>sysdate,
repeat_interval=>'freq=daily;byhour=6;byminute=45',
enabled=>true,
auto_drop=>false);
end;
/

-- check with partitioned table
select OWNER,
         TABLE_NAME,
         COLUMN_NAME,
         DATA_TYPE||' ('||DATA_LENGTH||')' "DATA_TYPE",
         CHAR_USED
  from ALL_TAB_COLUMNS
  where OWNER NOT IN('APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','FLOWS_FILES','GSMADMIN_INTERNAL','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','ORDSYS','OUTLN','PERFSTAT','SYS','SYSTEM','WMSYS','XDB')
  and TABLE_NAME not in (select v.TABLE_NAME from ALL_TAB_COMMENTS v where OWNER NOT IN ('APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','FLOWS_FILES','GSMADMIN_INTERNAL','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','ORDSYS','OUTLN','PERFSTAT','SYS','SYSTEM','WMSYS','XDB') and TABLE_TYPE = 'VIEW')
  and CHAR_USED='B'
 -- and TABLE_NAME not in (select TABLE_NAME from all_part_tables apt where apt.owner=owner and apt.table_name=table_name) --exclude partitioned tables
  order by OWNER, TABLE_NAME;

--check without partitioned table
  select OWNER,
         TABLE_NAME,
         COLUMN_NAME,
         DATA_TYPE||' ('||DATA_LENGTH||')' "DATA_TYPE",
         CHAR_USED
  from ALL_TAB_COLUMNS
  where OWNER NOT IN('APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','FLOWS_FILES','GSMADMIN_INTERNAL','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','ORDSYS','OUTLN','PERFSTAT','SYS','SYSTEM','WMSYS','XDB')
  and TABLE_NAME not in (select v.TABLE_NAME from ALL_TAB_COMMENTS v where OWNER NOT IN ('APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','FLOWS_FILES','GSMADMIN_INTERNAL','MDSYS','OJVMSYS','OLAPSYS','ORDDATA','ORDSYS','OUTLN','PERFSTAT','SYS','SYSTEM','WMSYS','XDB') and TABLE_TYPE = 'VIEW')
  and CHAR_USED='B'
 and TABLE_NAME not in (select TABLE_NAME from all_part_tables apt where apt.owner=owner and apt.table_name=table_name) --exclude partitioned tables
  order by OWNER, TABLE_NAME;
--========================================================================================
--Monitor autoextensible
CREATE OR REPLACE PROCEDURE SYS.MON_AUTOEXTEND_PROC
AS
cursor curr is
  select file_name, tablespace_name, autoextensible
  from dba_data_files
  where autoextensible='NO';
v_target_count number:=0;
msg_str varchar2(6000);
my_columns varchar2(200) :='FILE_NAME'||chr(9)||'TABLESPACE'||chr(9)||'AUTOEXTEND';
my_db varchar2(30);
my_host varchar2(64);
my_subj varchar(150);
begin
   select DB_UNIQUE_NAME into my_db
   from v$database;
   select host_name into my_host
   from v$instance;
   my_subj:='ALERT non autoextensible files'||my_db||chr(32)||my_host;
   msg_str:='WARNING: non autoextensible files';
   msg_str:=msg_str||chr(10)||chr(13)||my_columns;
   for curr_rec in curr
   loop
   v_target_count:=v_target_count+1;
   msg_str:=msg_str||chr(10)||chr(13)||curr_rec.file_name||chr(9)||curr_rec.tablespace_name||chr(9)||curr_rec.autoextensible;
   end loop;
   if v_target_count <> 0
   then
   dbms_output.put_line(my_subj);
   dbms_output.put_line('Non autoextensible file found');
   dbms_output.put_line(msg_str);
   SEND_MSG_PROC(my_subj, 'Hello dba,'||chr(10)||chr(13)||msg_str||chr(10)||chr(13)||'Have a nice day!');
   else
     dbms_output.put_line('NO '||my_subj);
     dbms_output.put_line('No non autoextensible file found');
   end if;
end;
/
begin
dbms_scheduler.create_job(
job_name=>'mon_autoextend',
job_type=>'stored_procedure',
job_action=>'SYS.MON_AUTOEXTEND_PROC',
start_date=>sysdate,
repeat_interval=>'freq=daily;byhour=6,13,17;byminute=45',
enabled=>true,
auto_drop=>false);
end;
/
  select file_name, tablespace_name, autoextensible
  from dba_data_files
  where autoextensible='NO';

--==============================================================================
--Monitor open cursors
CREATE OR REPLACE PROCEDURE SYS.MON_OPEN_CUR_PROC
AS
v_perc number:=300;
cursor syno is
  select p.value as def_max, (p.value-a.value) as diff, a.value, s.username, s.machine, s.sid, s.serial#
  from v$sesstat a, v$statname b, v$session s, v$parameter p
  where a.statistic# = b.statistic#
  and s.sid=a.sid
  and b.name = 'opened cursors current'
  and s.username is not null
  and p.name= 'open_cursors'
  and (p.value-a.value) < v_perc
  order by a.value desc;
v_target_count number:=0;
msg_str varchar2(6000);
my_columns varchar2(200) :='DEF_MAX'||chr(9)||'DIFF'||chr(9)||'VALUE'||chr(9)||'USERNAME'||chr(9)||'MACHINE'||chr(9)||'SID'||chr(9)||'SERIAL#';
my_db varchar2(30);
my_host varchar2(64);
my_subj varchar(150);
begin
   select DB_UNIQUE_NAME into my_db
   from v$database;
   select host_name into my_host
   from v$instance;
   my_subj:='ALERT open cursors high usage '||my_db||chr(32)||my_host;
   msg_str:='WARNING: high value for open cursors ';
   msg_str:=msg_str||chr(10)||chr(13)||my_columns;
   for syno_rec in syno
   loop
   v_target_count:=v_target_count+1;
   msg_str:=msg_str||chr(10)||chr(13)||syno_rec.def_max||chr(9)||syno_rec.diff||chr(9)||syno_rec.value||chr(9)||syno_rec.username||chr(9)||syno_rec.machine||chr(9)||syno_rec.sid||chr(9)||syno_rec.serial#;
   end loop;
   if v_target_count <> 0
   then
   dbms_output.put_line(my_subj);
   dbms_output.put_line('There are high value for open cursors found');
   dbms_output.put_line(msg_str);
   SEND_MSG_PROC(my_subj, 'Hello dba,'||chr(10)||chr(13)||msg_str||chr(10)||chr(13)||'Have a nice day!');
   else
     dbms_output.put_line('NO '||my_subj);
     dbms_output.put_line('No high value for open cursors found');
   end if;
end;
/
--monitor every 5 minutes
begin
dbms_scheduler.create_job(
job_name=>'mon_open_cur',
job_type=>'stored_procedure',
job_action=>'SYS.MON_OPEN_CUR_PROC',
start_date=>sysdate,
repeat_interval=>'freq=minutely; interval=5',
enabled=>true,
auto_drop=>false);
end;
/

-----------------------------------------
