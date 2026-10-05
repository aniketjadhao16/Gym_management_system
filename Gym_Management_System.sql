-- =========================================================
-- GYM MANAGEMENT SYSTEM - DBMS MINI PROJECT
-- DBMS: MySQL
-- =========================================================

DROP DATABASE IF EXISTS gym_management;
CREATE DATABASE gym_management;
USE gym_management;

-- 1. TRAINERS TABLE
CREATE TABLE trainers (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    trainer_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- 2. MEMBERS TABLE
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    join_date DATE NOT NULL,
    trainer_id INT,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- 3. MEMBERSHIP PLANS TABLE
CREATE TABLE membership_plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL UNIQUE,
    duration_months INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CHECK (duration_months > 0),
    CHECK (price > 0)
);

-- 4. MEMBERSHIPS TABLE
CREATE TABLE memberships (
    membership_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('Active','Expired','Cancelled') DEFAULT 'Active',
    FOREIGN KEY (member_id) REFERENCES members(member_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES membership_plans(plan_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 5. PAYMENTS TABLE
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    membership_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash','UPI','Card') NOT NULL,
    FOREIGN KEY (membership_id) REFERENCES memberships(membership_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CHECK (amount > 0)
);

-- SAMPLE TRAINERS
INSERT INTO trainers (trainer_name, specialization, phone, email) VALUES
('Rahul Sharma', 'Weight Training', '9876543210', 'rahul@gym.com'),
('Priya Patil', 'Yoga and Fitness', '9876543211', 'priya@gym.com'),
('Amit Verma', 'Cardio Training', '9876543212', 'amit@gym.com');

-- SAMPLE MEMBERS
INSERT INTO members (member_name, gender, phone, email, join_date, trainer_id) VALUES
('Aarav Joshi', 'Male', '9000000001', 'aarav@gmail.com', '2026-01-10', 1),
('Sneha Kulkarni', 'Female', '9000000002', 'sneha@gmail.com', '2026-02-05', 2),
('Rohan Patil', 'Male', '9000000003', 'rohan@gmail.com', '2026-03-12', 3),
('Ananya Deshmukh', 'Female', '9000000004', 'ananya@gmail.com', '2026-04-15', 2),
('Vivek Singh', 'Male', '9000000005', 'vivek@gmail.com', '2026-05-20', 1);

-- MEMBERSHIP PLANS
INSERT INTO membership_plans (plan_name, duration_months, price) VALUES
('Basic', 1, 1000.00),
('Standard', 3, 2700.00),
('Premium', 6, 4800.00);

-- MEMBERSHIPS
INSERT INTO memberships (member_id, plan_id, start_date, end_date, status) VALUES
(1, 2, '2026-01-10', '2026-04-09', 'Expired'),
(2, 3, '2026-02-05', '2026-08-04', 'Expired'),
(3, 1, '2026-03-12', '2026-04-11', 'Expired'),
(4, 2, '2026-04-15', '2026-07-14', 'Expired'),
(5, 3, '2026-05-20', '2026-11-19', 'Active');

-- PAYMENTS
INSERT INTO payments (membership_id, payment_date, amount, payment_method) VALUES
(1, '2026-01-10', 2700.00, 'UPI'),
(2, '2026-02-05', 4800.00, 'Card'),
(3, '2026-03-12', 1000.00, 'Cash'),
(4, '2026-04-15', 2700.00, 'UPI'),
(5, '2026-05-20', 4800.00, 'Card');

-- =========================================================
-- BASIC CRUD OPERATIONS
-- =========================================================

-- CREATE / INSERT
INSERT INTO members
(member_name, gender, phone, email, join_date, trainer_id)
VALUES ('Kunal More', 'Male', '9000000006', 'kunal@gmail.com', '2026-06-01', 1);

-- READ
SELECT * FROM members;

-- UPDATE
UPDATE members
SET phone = '9111111111'
WHERE member_id = 6;

-- DELETE
DELETE FROM members
WHERE member_id = 6;

-- =========================================================
-- USEFUL SELECT QUERIES
-- =========================================================

-- 1. Display all trainers
SELECT * FROM trainers;

-- 2. Display all membership plans
SELECT * FROM membership_plans;

-- 3. Display all members with their trainers
SELECT m.member_id, m.member_name, m.phone, t.trainer_name
FROM members m
LEFT JOIN trainers t ON m.trainer_id = t.trainer_id;

-- 4. Display membership details with member and plan
SELECT m.member_name, p.plan_name, p.duration_months,
       ms.start_date, ms.end_date, ms.status
FROM memberships ms
JOIN members m ON ms.member_id = m.member_id
JOIN membership_plans p ON ms.plan_id = p.plan_id;

-- 5. Display payment details
SELECT py.payment_id, m.member_name, py.payment_date,
       py.amount, py.payment_method
FROM payments py
JOIN memberships ms ON py.membership_id = ms.membership_id
JOIN members m ON ms.member_id = m.member_id;

-- 6. Find active members
SELECT m.member_id, m.member_name, ms.end_date
FROM members m
JOIN memberships ms ON m.member_id = ms.member_id
WHERE ms.status = 'Active';

-- 7. Find members assigned to a particular trainer
SELECT m.member_name, t.trainer_name
FROM members m
JOIN trainers t ON m.trainer_id = t.trainer_id
WHERE t.trainer_name = 'Rahul Sharma';

-- 8. Total payment collected
SELECT SUM(amount) AS total_revenue
FROM payments;

-- 9. Revenue by payment method
SELECT payment_method, SUM(amount) AS total_amount
FROM payments
GROUP BY payment_method;

-- 10. Count members handled by each trainer
SELECT t.trainer_name, COUNT(m.member_id) AS member_count
FROM trainers t
LEFT JOIN members m ON t.trainer_id = m.trainer_id
GROUP BY t.trainer_id, t.trainer_name;

-- =========================================================
-- VIEW
-- =========================================================

CREATE OR REPLACE VIEW active_members_view AS
SELECT m.member_id, m.member_name, m.phone,
       p.plan_name, ms.start_date, ms.end_date
FROM members m
JOIN memberships ms ON m.member_id = ms.member_id
JOIN membership_plans p ON ms.plan_id = p.plan_id
WHERE ms.status = 'Active';

SELECT * FROM active_members_view;

-- =========================================================
-- TRIGGER
-- Automatically changes membership status after INSERT
-- =========================================================

DELIMITER //

CREATE TRIGGER before_membership_insert
BEFORE INSERT ON memberships
FOR EACH ROW
BEGIN
    IF NEW.end_date < CURDATE() THEN
        SET NEW.status = 'Expired';
    ELSE
        SET NEW.status = 'Active';
    END IF;
END //

DELIMITER ;

-- =========================================================
-- TRANSACTION EXAMPLE
-- =========================================================

START TRANSACTION;

INSERT INTO payments
(membership_id, payment_date, amount, payment_method)
VALUES (5, CURDATE(), 4800.00, 'UPI');

-- If everything is correct:
COMMIT;

-- If there is an error, use ROLLBACK instead of COMMIT.
-- ROLLBACK;

-- =========================================================
-- END OF PROJECT
-- =========================================================
