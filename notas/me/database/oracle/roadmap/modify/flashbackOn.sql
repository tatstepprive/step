--Ensure
--Enable Archive log (offline operation)
--DB_FLASHBACK_RETENTION_TARGET The default value for this parameter is 1440 minutes, which is one day. Set to 3 days 4320 
ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=4320;
--Set flashback on (default disabled)
ALTER DATABASE FLASHBACK ON;
