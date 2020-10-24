-- Checks whether Oracle OLS has been registered.
SELECT STATUS FROM DBA_OLS_STATUS WHERE NAME = 'OLS_CONFIGURE_STATUS';

-- Checks whether Oracle OLS has been enabled.
SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Oracle Label Security';

-- Unlocks OLS default administer.
ALTER USER LBACSYS ACCOUNT UNLOCK IDENTIFIED BY "ols_admin";

-- Grants unlimited table space.
ALTER USER LBACSYS QUOTA UNLIMITED ON USERS;

-- Grants necessary privileges.
GRANT ALL PRIVILEGES TO LBACSYS;
