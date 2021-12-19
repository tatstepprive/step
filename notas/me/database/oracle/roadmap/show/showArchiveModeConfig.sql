--Show archive mode (default disabled, recommend: enabled)
--log_mode=ARCHIVELOG if on 
select log_mode from v$database;
--archiver=started if on
select archiver from v$instance;
