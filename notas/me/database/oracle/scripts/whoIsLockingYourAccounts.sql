--Issue: account is locked
--accounts are automatically locked 1 day (PASSWORD_LOCK_TIME) after 10 failed login attempt (FAILED_LOGIN_ATTEMPTS)
--ora-01017 and ora-28000-errors
--who is locking your oracle accounts (user=schema)
-- in shell: oerr ora 1017
--output: 01017, 00000, "invalid username/password; logon denied"

--FIX: to find who is using bad password
--create table
CREATE TABLE sys.logon_trigger
(
USERNAME VARCHAR2(30),
USERHOST VARCHAR2(128),
TIMESTAMP DATE
);

--create trigger
CREATE OR REPLACE TRIGGER sys.logon_trigger
AFTER SERVERERROR ON DATABASE
BEGIN
  IF (IS_SERVERERROR(1017)) THEN
    INSERT INTO logon_trigger VALUES(SYS_CONTEXT('USERENV', 'AUTHENTICATED_IDENTITY'), SYS_CONTEXT('USERENV', 'HOST'), SYSDATE);
    COMMIT;
  END IF;
END;
/

--simulated a wrong password access with your account with sqldeveloper or sqlplus 

--see result 
ALTER SESSION SET nls_date_format='dd-mon-yyyy hh24:mi:ss';
SELECT * FROM sys.logon_trigger ORDER BY TIMESTAMP DESC;

