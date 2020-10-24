-- Checks whether Oracle OLS has been registered.
SELECT STATUS FROM DBA_OLS_STATUS WHERE NAME = 'OLS_CONFIGURE_STATUS';

-- Checks whether Oracle OLS has been enabled.
SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Oracle Label Security';

-- Unlocks OLS default administer.
ALTER USER LBACSYS ACCOUNT UNLOCK IDENTIFIED BY "ols_admin";
GRANT ALL PRIVILEGES TO LBACSYS;
ALTER USER LBACSYS QUOTA UNLIMITED ON USERS;

-- Kills all active connections.
BEGIN
  FOR r IN (select sid, serial# from v$session where username = 'EDU_ADMIN') LOOP
    EXECUTE IMMEDIATE 'alter system kill session ''' || r.sid  || ','  || r.serial# || ''' immediate';
  END LOOP;
END;

-- Drops existing user & records.
DROP USER edu_admin CASCADE;

-- Creates system user.
CREATE USER edu_admin IDENTIFIED BY edu_admin;
GRANT ALL PRIVILEGES TO edu_admin;
ALTER USER edu_admin QUOTA UNLIMITED ON USERS;
