USE codeup_test_db;

SELECT name AS 'All albums in the table'
FROM albums;

SELECT name AS 'albums released before 1980'
FROM albums
WHERE release_date < 1980;

SELECT name AS 'albums by Michael Jackson'
FROM albums
WHERE artist = 'Michael Jackson';

UPDATE albums
SET sales = sales * 10;
SELECT * FROM albums;

UPDATE albums
SET release_date = release_date - 100
WHERE release_date < 1980;

UPDATE albums
SET artist = 'Peter Jackson'
WHERE artist = 'Michael Jackson';

SELECT * FROM albums;