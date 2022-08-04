--show all jobs
select * from dba_scheduler_jobs;
--output 22 rows (default)

--show all user jobs
select * from user_scheduler_jobs;
--output 20 rows for user sys

--show job time runs
select * from times;

--show job running status, shows also dropped jobs
select * from dba_scheduler_job_log;
select * from user_scheduler_job_log;

--detailed info about runned jobs (content is cleared by job purge_log for data older then 30 days)
select * from dba_scheduler_job_run_details;

--show current running processes that are job related (CJQn/Jnnn n=number)
select program from v$process where program like '%J%';
--output 1 row=CJQ0

--Show if scheduler can function (job_queue_processes value > 0; default=1000)
show parameter job_queue_processes;
--output 20 (tip: when 0=zero the scheduler wont work)

desc dbms_scheduler;

--show resource manager plans
select * from v$rsrc_plan;
--output: default 2 rows (internal_plan and ora$internal_cdb_plan)

--show defined windows
select * from dba_scheduler_windows;
--output 9 rows (MONDAY_WINDOW->SUNDAY_WINDOW; WEEKNIGHT_WINDOW, WEEKEND_WINDOW)
--show recent job runs
SELECT job_name,status,actual_start_date,run_duration
FROM DBA_SCHEDULER_JOB_RUN_DETAILS
ORDER BY ACTUAL_START_DATE DESC;
----------------------------------------------
--Create job
create table hr.times (my_date TIMESTAMP);

alter session set nls_date_format='dd-mm-yy hh24:mi:ss';

select * from hr.times;
begin
dbms_scheduler.create_job(
job_name=>'savedate',
job_type=>'plsql_block',
job_action=>'insert into hr.times values(systimestamp);',
start_date=>sysdate,
repeat_interval=>'freq=minutely;interval=1',
enabled=>true,
auto_drop=>false);
end;
/

--   start_date      =>  TO_DATE('22-02-2013 14:00','DD-MM-YYYY HH24:MI'),
--   repeat_interval => 'FREQ=DAILY;BYHOUR=7,13,18; BYMINUTE=00', 

select * from dba_scheduler_jobs where job_name='SAVEDATE';

select * from dba_scheduler_job_log where job_name='SAVEDATE';

--execute job manually
begin
dbms_scheduler.run_job('SAVEDATE');
end;
/

--job action with parameters
begin
dbms_scheduler.create_job (
    job_name => 'myjob',
    job_type => 'PLSQL_BLOCK',
    job_action => 'BEGIN myproc(''first arg'',''second arg''); END;',
    start_date => sysdate,
    repeat_interval => 'FREQ=HOURLY',
    enabled => true
);
end;
/
