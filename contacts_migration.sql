USE zenith_test_db;

DROP TABLE contacts;

CREATE TABLE contacts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(47),
  created_at DATE,
  age TINYINT,
  PRIMARY KEY (id)
);