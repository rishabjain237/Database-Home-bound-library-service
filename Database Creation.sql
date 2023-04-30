CREATE DATABASE home_library;
USE home_library;

CREATE table member(
membership_no VARCHAR(2) NOT NULL  PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
mobile VARCHAR(10) NOT NULL,
registration_date date NOT NULL,
emergency_contact varchar(50) NOT NULL,
permission_to_enter varchar(3) NOT NULL check (permission_to_enter in ('YES', 'NO')),
eligible varchar(3) NOT NULL check (eligible in ('YES', 'NO')),
relation_with_member varchar(20) NOT NULL,
description varchar(500) NOT NULL,
interview_date date NOT NULL
);

CREATE TABLE volunteer(
volunteer_id VARCHAR(2) NOT NULL UNIQUE PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
mobile VARCHAR(10) NOT NULL,
localite varchar(3) NOT NULL check (localite in ('YES', 'NO')),
AgeBracket VARCHAR(20) NOT NULL check (AgeBracket in ('MINOR', 'ADULT', 'SENIOR'))
);

CREATE TABLE library_coordinator(
coordinator_id VARCHAR(2) NOT NULL UNIQUE,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
mobile VARCHAR(10) NOT NULL UNIQUE,
volunteer_id VARCHAR(2) UNIQUE,
is_coordinator_a_volunteer varchar(3) NOT NULL check (is_coordinator_a_volunteer in ('YES', 'NO')),
membership_no VARCHAR(2) UNIQUE,
FOREIGN KEY (membership_no) REFERENCES member (membership_no),
FOREIGN KEY (volunteer_id) REFERENCES volunteer (volunteer_id)
);

CREATE TABLE Resource(
resource_id VARCHAR(2) NOT NULL UNIQUE PRIMARY KEY,
title VARCHAR(100) NOT NULL,
author VARCHAR(100) NOT NULL,
descript VARCHAR(500) NOT NULL,
genre VARCHAR(20) NOT NULL,
publisher VARCHAR(50) NOT NULL,
publish_date DATE NOT NULL
);

CREATE TABLE Borrowing(
borrowing_id VARCHAR(2)NOT NULL UNIQUE PRIMARY KEY,
membership_no VARCHAR(2) NOT NULL,
resource_id VARCHAR(2) NOT NULL,
borrowing_date DATE NOT NULL,
due_date DATE NOT NULL,
FOREIGN KEY (membership_no) REFERENCES member(membership_no),
FOREIGN KEY (resource_id) REFERENCES Resource(resource_id)
);

CREATE TABLE Delivery(
delivery_id VARCHAR(2) NOT NULL UNIQUE PRIMARY KEY,
borrowing_id VARCHAR(2) NOT NULL,
volunteer_id VARCHAR(2) NOT NULL,
membership_no VARCHAR(2) NOT NULL,
delivery_date DATE NOT NULL,
FOREIGN KEY (membership_no) REFERENCES member(membership_no),
FOREIGN KEY (borrowing_id) REFERENCES Borrowing(borrowing_id),
FOREIGN KEY (volunteer_id) REFERENCES Volunteer(volunteer_id)
);

INSERT INTO member (membership_no, first_name, last_name, address, email, mobile, registration_date, emergency_contact, relation_with_member, permission_to_enter, eligible, description, interview_date)
VALUES
('M1', 'John', 'Doe', '123 Main St', 'johndoe@example.com', '555-1234', '2022-01-01', 'Jane Doe', 'Spouse', 'YES', 'YES', 'Regular member', '2022-01-01'),
('M2', 'Tom', 'Johnson', '321 Pine St', 'tomjohnson@example.com', '555-8021', '2022-04-01', 'Samiha Alam', 'Parent', 'YES', 'YES', 'Has a fear of dogs', '2022-05-01'),
('M3', 'Sue', 'Jones', '789 Maple Ave', 'suejones@example.com', '555-3698', '2022-03-01', 'Bob Smith', 'Friend', 'NO', 'YES', 'Allergic to peanuts', '2022-03-01'),
('M4', 'Alex', 'Chen', '987 Broadway', 'alexchen@example.com', '555-3589', '2022-06-01', 'Mary Williams', 'Friend', 'YES', 'YES', 'Likes to swim', '2022-06-01'),
('M5', 'Emma', 'Brown', '654 1st Ave', 'emmabrown@example.com', '555-7146', '2022-07-01', 'Alex Chen', 'Friend', 'YES', 'YES', 'Enjoys hiking', '2022-07-01');

select * from member;

INSERT INTO volunteer(volunteer_id, first_name, last_name, address, email, mobile, localite, AgeBracket)
VALUES
('V1', 'Emily', 'Davis', '567 Maple Rd, Anytown, USA', 'emilydavis@email.com', '555-0123', 'NO', 'MINOR'),
('V2', 'William', 'Wilson', '890 Elm St, Anytown, USA', 'williamwilson@email.com', '555-4567', 'YES', 'SENIOR'),
('V3', 'Sarah', 'Miller', '432 Pine Ave, Anytown, USA', 'sarahmiller@email.com', '555-8901', 'NO', 'ADULT'),
('V4', 'Jason', 'Clark', '678 Cedar St, Anytown, USA', 'jasonclark@email.com', '555-2345', 'YES', 'ADULT'),
('V5', 'Sophia', 'Davis', '234 Maple St, Apt 6C', 'sophia.davis@email.com', '1234567890', 'NO', 'ADULT');

INSERT INTO library_coordinator(coordinator_id, first_name, last_name, email, mobile, volunteer_id, is_coordinator_a_volunteer, membership_no)
VALUES
('C1', 'Michael', 'Lee', 'michael.lee@email.com', '9876543210', 'V5', 'NO', 'M2'),
('C2', 'Emily', 'Davis', 'emilydavis@email.com', '555-0123', 'V1', 'YES', 'M1'),
('C3', 'Emily', 'Taylor', 'emily.taylor@email.com', '1234567890', 'V2', 'NO', 'M3'),
('C4', 'Daniel', 'Anderson', 'daniel.anderson@email.com', '9876543223', 'V3', 'YES', 'M4'),
('C5', 'Sophia', 'Davis', 'sophia.davis@email.com', '1234567345', 'V4', 'YES', 'M5');

INSERT INTO Resource (resource_id, title, author, descript, genre, publisher, publish_date)
VALUES
('R1', 'To Kill a Mockingbird', 'Harper Lee', 'A lawyer in the Deep South defends a black man accused of rape.', 'Fiction', 'J.B. Lippincott & Co.', '1960-07-11'),
('R2', '1984', 'George Orwell', 'A dystopian novel set in a totalitarian society.', 'Science Fiction', 'Secker & Warburg', '1949-06-08'),
('R3', 'The Lord of the Rings', 'J.R.R. Tolkien', 'A group of hobbits and other characters journey to destroy a powerful ring.', 'Fantasy', 'Allen & Unwin', '1954-07-29'),
('R4', 'Pride and Prejudice', 'Jane Austen', 'A woman navigates social status and relationships in Regency England.', 'Fiction', 'T. Egerton, Whitehall', '1813-01-28'),
('R5', 'The Hunger Games', 'Suzanne Collins', 'A girl is forced to compete in a brutal televised competition in a dystopian society.', 'Science Fiction', 'Scholastic', '2008-09-14');

INSERT INTO Borrowing(borrowing_id, membership_no, resource_id, borrowing_date, due_date)
VALUES
('B1', 'M5', 'R3', '2023-04-01', '2023-04-08'),
('B2', 'M4', 'R4', '2023-04-05', '2023-04-12'),
('B3', 'M3', 'R5', '2023-04-06', '2023-04-13'),
('B4', 'M2', 'R2', '2023-04-08', '2023-04-15'),
('B5', 'M1', 'R1', '2023-04-10', '2023-04-17');

update borrowing set due_date='2023-04-26' where borrowing_id='B5';

INSERT INTO Delivery(delivery_id, borrowing_id, volunteer_id, membership_no, delivery_date)
VALUES
('D1', 'B4', 'V5', 'M2', '2023-04-08'),
('D2', 'B3', 'V3', 'M4', '2023-04-12'),
('D3', 'B5', 'V1', 'M5', '2023-04-13'),
('D4', 'B2', 'V2', 'M3', '2023-04-15'),
('D5', 'B1', 'V4', 'M1', '2023-04-17');

