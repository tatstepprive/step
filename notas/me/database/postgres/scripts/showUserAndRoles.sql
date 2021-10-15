SELECT r.rolname as username,r1.rolname as "role"
FROM pg_catalog.pg_roles r LEFT JOIN pg_catalog.pg_auth_members m
ON (m.member = r.oid)
LEFT JOIN pg_roles r1 ON (m.roleid=r1.oid)                                  
WHERE r.rolcanlogin
ORDER BY 1;
