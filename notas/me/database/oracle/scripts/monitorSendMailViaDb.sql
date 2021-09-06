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

--============================================
