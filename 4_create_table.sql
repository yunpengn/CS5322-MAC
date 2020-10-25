-- Drops all tables.
DROP TABLE addresses;
DROP TABLE fees;
DROP TABLE grades;
DROP TABLE modules;
DROP TABLE users;

-- Creates all tables.
CREATE TABLE users (
  sid         VARCHAR(8),
  name        VARCHAR(80) NOT NULL,
  gender      VARCHAR(6)  NOT NULL,
  dob         DATE        NOT NULL,
  nationality VARCHAR(20) NOT NULL,
  PRIMARY KEY (sid),
  CHECK       (gender IN ('male', 'female'))
);

CREATE TABLE addresses (
  sid         VARCHAR(8)   NOT NULL,
  type        VARCHAR(10)  NOT NULL,
  address     VARCHAR(100) NOT NULL,
  PRIMARY KEY (sid, type),
  FOREIGN KEY (sid) REFERENCES users(sid),
  CHECK       (type IN ('mailing', 'billing'))
);

CREATE TABLE fees (
  id          NUMBER      GENERATED AS IDENTITY,
  sid         VARCHAR(8)  NOT NULL,
  type        VARCHAR(20) NOT NULL,
  year        VARCHAR(5)  NOT NULL,
  semester    NUMBER(1)   NOT NULL,
  amount      NUMBER(8,2) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (sid)     REFERENCES users(sid),
  CHECK       (type     IN ('admin', 'tuition', 'misc')),
  CHECK       (semester IN (1, 2))
);

CREATE TABLE modules (
  id           NUMBER       GENERATED AS IDENTITY,
  code         VARCHAR(5)   NOT NULL,
  title        VARCHAR(100) NOT NULL,
  year         VARCHAR(5)   NOT NULL,
  semester     NUMBER(1)    NOT NULL,
  lecturer_sid VARCHAR(8)   NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE       (code, year, semester),
  FOREIGN KEY  (lecturer_sid) REFERENCES users(sid),
  CHECK        (semester      IN (1, 2))
);

CREATE TABLE grades (
  id           NUMBER     GENERATED AS IDENTITY,
  student_sid  VARCHAR(8) NOT NULL,
  module_id    NUMBER     NOT NULL,
  letter_grade VARCHAR(1) NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE       (student_sid, module_id),
  FOREIGN KEY  (student_sid) REFERENCES users(sid),
  FOREIGN KEY  (module_id)   REFERENCES modules(id),
  CHECK        (letter_grade IN ('A', 'B', 'C', 'D', 'F'))
);

-- Assigns OLS policies.
BEGIN
    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        policy_name    => 'edu_ols',
        schema_name    => 'edu_admin',
        table_name     => 'users',
        table_options  => 'all_control',
        label_function => 'edu_admin.label_users()');

    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        policy_name    => 'edu_ols',
        schema_name    => 'edu_admin',
        table_name     => 'addresses',
        table_options  => 'all_control',
        label_function => 'edu_admin.label_addresses(:new.type)');

    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        policy_name    => 'edu_ols',
        schema_name    => 'edu_admin',
        table_name     => 'fees',
        table_options  => 'all_control',
        label_function => 'edu_admin.label_fees()');

    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        policy_name    => 'edu_ols',
        schema_name    => 'edu_admin',
        table_name     => 'modules',
        table_options  => 'read_control',
        label_function => 'edu_admin.label_modules()');

    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        policy_name    => 'edu_ols',
        schema_name    => 'edu_admin',
        table_name     => 'modules',
        table_options  => 'write_control',
        label_function => 'edu_admin.label_modules_write()');

    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
        policy_name    => 'edu_ols',
        schema_name    => 'edu_admin',
        table_name     => 'grades',
        table_options  => 'all_control',
        label_function => 'edu_admin.label_grades(:new.module_id)');
END;
