-- 1. Use the albums_db database.
show databases;
use albums_db;
-- 2. What is the primary key for the albums table?
describe albums;
-- A = id
-- 3. What does the column named 'name' represent?
-- A = the name of the album.
-- 4. What do you think the sales column represents?cd 
-- A = number of sales for the specific album in millions.
-- 5. Find the name of all albums by Pink Floyd.
SELECT name
FROM albums
WHERE artist = 'Pink Floyd';
-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date
FROM albums
WHERE name = "sgt. pepper's lonely hearts club band";
-- A. = 1967
-- 7. What is the genre for the album Nevermind?
SELECT genre
FROM albums
WHERE name = 'Nevermind';
-- A. = 'Grunge, Alternative rock'
-- 8. = Which albums were released in the 1990s?
SELECT name
FROM albums
WHERE release_date >= '1990' and release_date < '2000';
-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name
as low_selling_albums
FROM albums
WHERE sales < '20';