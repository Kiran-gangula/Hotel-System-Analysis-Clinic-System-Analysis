CREATE TABLE clinics (
  cid VARCHAR(50),
  clinic_name VARCHAR(100),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100)
);

CREATE TABLE customer (
  uid VARCHAR(50),
  name VARCHAR(100),
  mobile VARCHAR(20)
);

CREATE TABLE clinic_sales (
  oid VARCHAR(50),
  uid VARCHAR(50),
  cid VARCHAR(50),
  amount INT,
  datetime DATETIME,
  sales_channel VARCHAR(50)
);

CREATE TABLE expenses (
  eid VARCHAR(50),
  cid VARCHAR(50),
  description TEXT,
  amount INT,
  datetime DATETIME
);