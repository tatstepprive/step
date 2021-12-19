--The DB_RECOVERY_FILE_DEST_SIZE parameter must be set before the DB_RECOVERY_FILE_DEST parameter
--online operations (affects new files)
ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE = 10G;
ALTER SYSTEM SET DB_RECOVERY_FILE_DEST = '/u02/oracle/fra';
