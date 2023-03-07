Use codeup_test_db;

DROP TABLE albums;

CREATE TABLE albums (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  artist VARCHAR(102) NOT NULL,
  name VARCHAR(100),
  release_date SMALLINT UNSIGNED,
  sales FLOAT,
  genre VARCHAR(100),
  PRIMARY KEY (id),
  UNIQUE (artist, name)
);