--show server host
SELECT SYS_CONTEXT('USERENV','SERVER_HOST') FROM dual;
SELECT host_name FROM v$instance;
SELECT terminal, machine FROM v$session WHERE username = 'HR';
