--Issue: monitor bad logins
--ora-01017 and ora-28000-errors
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

--possible error on the client side in application when using the wrong passwd in config
--Caused by: org.hibernate.HibernateException: 'hibernate.dialect' must be set when no Connection available
--issue on 24/02/2022 see mail
------------------------------------------------
--New version of logon_trigger with catching multiple errors
--disable trigger
alter table SYS.LOGON_TRIGGER add  error_type VARCHAR2(30 BYTE);
alter table SYS.LOGON_TRIGGER add  notas VARCHAR2(60 BYTE);

CREATE OR REPLACE TRIGGER SYS.LOGON_TRIGGER
AFTER SERVERERROR ON DATABASE
DISABLE
BEGIN
  IF (IS_SERVERERROR(1017)) THEN
    INSERT INTO logon_trigger VALUES(SYS_CONTEXT('USERENV', 'AUTHENTICATED_IDENTITY'), SYS_CONTEXT('USERENV', 'HOST'), SYSDATE, 'ORA-01017', 'invalid username/password');
    COMMIT;
  END IF;
  IF (IS_SERVERERROR(1004)) THEN
    INSERT INTO logon_trigger VALUES(SYS_CONTEXT('USERENV', 'AUTHENTICATED_IDENTITY'), SYS_CONTEXT('USERENV', 'HOST'), SYSDATE, 'ORA-01004', 'default username feature not supported');
    COMMIT;
  END IF;
  IF (IS_SERVERERROR(1005)) THEN
    INSERT INTO logon_trigger VALUES(SYS_CONTEXT('USERENV', 'AUTHENTICATED_IDENTITY'), SYS_CONTEXT('USERENV', 'HOST'), SYSDATE, 'ORA-01005', 'null password given');
    COMMIT;
  END IF;
  IF (IS_SERVERERROR(28000)) THEN
    INSERT INTO logon_trigger VALUES(SYS_CONTEXT('USERENV', 'AUTHENTICATED_IDENTITY'), SYS_CONTEXT('USERENV', 'HOST'), SYSDATE, '28000', 'account is locked');
    COMMIT;
  END IF;
END;
/

--enable trigger
select * from logon_trigger order by timestamp desc;
---------------------------------------------------
--second way to audit
--To enable auditing of failed sign-on attempts:
--1 - Add initialization parameters & bounce instance:
--audit_trail=true
--audit_file_dest='/u01/app/oracle/mysid/mydir/'
--2 - Enable auditing of failed logion attempts as SYSDBA:
audit create session whenever not successful;

--3 - You can now view failed login attempts in dba_audit_trail:
select
   os_username,
   username,
   terminal,
   to_char(timestamp,'MM-DD-YYYY HH24:MI:SS')
from
   dba_audit_trail;
----------------------------------------------------
