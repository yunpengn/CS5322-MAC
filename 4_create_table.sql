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
  sid     VARCHAR(8)   NOT NULL,
  type    VARCHAR(10)  NOT NULL,
  address VARCHAR(100) NOT NULL,
  PRIMARY KEY (sid, type),
  FOREIGN KEY (sid) REFERENCES users(sid),
  CHECK       (type IN ('mailing', 'billing'))
);

CREATE TABLE fees (
  id       NUMBER      GENERATED AS IDENTITY,
  sid      VARCHAR(8)  NOT NULL,
  type     VARCHAR(20) NOT NULL,
  year     VARCHAR(5)  NOT NULL,
  semester NUMBER(1)   NOT NULL,
  amount   NUMBER(8,2) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (sid)     REFERENCES users(sid),
  CHECK       (type     IN ('admin', 'tuition', 'misc')),
  CHECK       (semester IN (1, 2))
);

CREATE TABLE modules (
  id       NUMBER          GENERATED AS IDENTITY,
  code     VARCHAR(5)      NOT NULL,
  title    VARCHAR(100)    NOT NULL,
  year     VARCHAR(5)      NOT NULL,
  semester NUMBER(1)       NOT NULL,
  lecturer_sid VARCHAR(8)  NOT NULL,
  PRIMARY KEY (id),
  UNIQUE      (code, year, semester),
  FOREIGN KEY (lecturer_sid) REFERENCES users(sid),
  CHECK       (semester      IN (1, 2))
);

CREATE TABLE grades (
  id           NUMBER     GENERATED AS IDENTITY,
  student_sid  VARCHAR(8) NOT NULL,
  module_id    NUMBER     NOT NULL,
  letter_grade VARCHAR(1) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE      (student_sid, module_id),
  FOREIGN KEY (student_sid) REFERENCES users(sid),
  FOREIGN KEY (module_id)   REFERENCES modules(id),
  CHECK       (letter_grade IN ('A', 'B', 'C', 'D', 'F'))
);
