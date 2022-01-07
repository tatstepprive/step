-- AMM automatic memory management (memory transfer between pga and sga possible)
CONN / AS SYSDBA
-- Set the static parameter. Leave some room for possible future growth without restart.
ALTER SYSTEM SET MEMORY_MAX_TARGET=6G SCOPE=SPFILE;

-- Set the dynamic parameters. Assuming Oracle has full control.
ALTER SYSTEM SET MEMORY_TARGET=5G SCOPE=SPFILE;
ALTER SYSTEM SET PGA_AGGREGATE_TARGET=0 SCOPE=SPFILE;
ALTER SYSTEM SET SGA_TARGET=0 SCOPE=SPFILE;

-- Restart instance.
SHUTDOWN IMMEDIATE;
STARTUP;

--Once the database is restarted the MEMORY_TARGET parameter can be amended as required without an instance restart.
ALTER SYSTEM SET MEMORY_TARGET=6G SCOPE=SPFILE;
