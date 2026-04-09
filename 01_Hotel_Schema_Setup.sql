CREATE TABLE users (
  user_id VARCHAR(50),
  name VARCHAR(100),
  phone_number VARCHAR(20),
  mail_id VARCHAR(100),
  billing_address TEXT
);

CREATE TABLE bookings (
  booking_id VARCHAR(50),
  booking_date DATETIME,
  room_no VARCHAR(50),
  user_id VARCHAR(50)
);

CREATE TABLE items (
  item_id VARCHAR(50),
  item_name VARCHAR(100),
  item_rate INT
);

CREATE TABLE booking_commercials (
  id VARCHAR(50),
  booking_id VARCHAR(50),
  bill_id VARCHAR(50),
  bill_date DATETIME,
  item_id VARCHAR(50),
  item_quantity FLOAT
);