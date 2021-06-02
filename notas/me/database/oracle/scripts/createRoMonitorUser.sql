CREATE USER monitor_ro IDENTIFIED BY xxx;
GRANT connect TO monitor_ro;
GRANT SELECT ANY DICTIONARY TO monitor_ro;
