CREATE DATABASE IF NOT EXISTS theater_db;
USE theater_db;

-- DROP TABLE IF EXISTS movies;
-- DROP TABLE IF EXISTS showtimes;
-- DROP TABLE IF EXISTS customers;
-- DROP TABLE IF EXISTS tickets;

CREATE TABLE IF NOT EXISTS movies (
	movie_id 	VARCHAR(5), 
	title 		VARCHAR(100) UNIQUE,
    duration 	INT, 
    category 	VARCHAR(50),
    PRIMARY KEY(movie_id)
);

CREATE TABLE IF NOT EXISTS showtimes (
	show_id 	VARCHAR(5),
    movie_id 	VARCHAR(5),
    room_name 	VARCHAR(10),
    start_time 	DATETIME,
    ticket_price DECIMAL(10,2),
	PRIMARY KEY(show_id)
);

CREATE TABLE IF NOT EXISTS customers (
	customer_id VARCHAR(5),
    full_name 	VARCHAR(100),
    email 		VARCHAR(100) UNIQUE,
    phone 		VARCHAR(15) UNIQUE,
    PRIMARY KEY(customer_id)
);

CREATE TABLE IF NOT EXISTS tickets (
	ticket_id 	INT 		AUTO_INCREMENT,
    show_id 	VARCHAR(5),
    customer_id VARCHAR(5),
    seat_number VARCHAR(10) UNIQUE,
    status 		VARCHAR(10) DEFAULT 'Booked',
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES showtimes(show_id)
);

INSERT INTO movies (movie_id, title, duration,category) VALUES
('M01' , 'Avatar 2' 	, 190 , 'Hành động'),
('M02' , 'Joker' 		, 120 , 'Tâm Lý'),
('M03' , 'Toy Story 4' 	, 100 , 'Hoạt hình'),
('M04' , 'Interstellar' , 169 , 'Khoa học');

INSERT INTO showtimes (show_id, movie_id, room_name, start_time, ticket_price) VALUES
('S01','M01','Cinema 01','2025-10-01 19:00:00', 120000.00),
('S02','M02','Cinema 02','2025-10-01 20:00:00', 90000.00),
('S03','M03','Cinema 03','2025-10-02 09:00:00', 80000.00),
('S04','M04','Cinema 04','2025-10-02 14:00:00', 150000.00);

INSERT INTO customers (customer_id, full_name, email, phone) VALUES
('C01' , 'Nguyễn Văn An'	, 'an.nv@gmail.com'	, '0911111111'),
('C02' , 'Nguyễn Thị Mai'	, 'mai.nt@gmail.com', '0922222222'),
('C03' , 'Trần Quang Hải'	, 'hai.tq@gmail.com', '0933333333');

INSERT INTO tickets (ticket_id, show_id, customer_id, seat_number, status) VALUES
(1, 'S01', 'C01', 'A01', 'Booked'),
(2, 'S02', 'C02', 'B05', 'Booked'),
(3, 'S01', 'C03', 'A02', 'Cancelled');

SET SQL_SAFE_UPDATES = 0;
-- 3
UPDATE showtimes
SET    ticket_price = ticket_price * 1.1
WHERE  show_id = 'S01';
-- 4
UPDATE customers
SET    phone = '0988888888'
WHERE  show_id = 'Nguyễn Văn An';
-- 5
DELETE FROM customers
WHERE status = 'Cancelled';

SET SQL_SAFE_UPDATES = 1;

-- 6
SELECT * 
FROM movies 
WHERE duration > 120 ;

-- 7
SELECT full_name, email
FROM customers
WHERE full_name LIKE '%Mai';

-- 8
SELECT show_id, room_name, start_time
FROM tickets
ORDER BY start_time DESC;

-- 9
SELECT *
FROM showtime
ORDER BY ticket_price DESC
LIMIT 3;

-- 10
SELECT title, duration
FROM movies
LIMIT 3 OFFSET 1;

-- 15
SELECT s.show_id , s.room_name, s.ticket_price
FROM showtimes s
WHERE s.ticket_price < (SELECT AVG(ticket_price) FROM showtimes);
