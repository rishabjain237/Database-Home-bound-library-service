-- Below 3 queries are for PROBLEM 1
SELECT mobile, COUNT(*) as cnt
FROM member GROUP BY mobile HAVING cnt>1;

SELECT GROUP_CONCAT(membership_no) AS membership_numbers,mobile
FROM member
GROUP BY mobile
HAVING COUNT(*) > 1;

UPDATE member SET mobile = '555-3589' WHERE membership_no = 'M4';
SELECT * FROM member;
UPDATE member SET email = 'alexchen1234@example.com' WHERE membership_no = 'M4';
ALTER TABLE member ADD CONSTRAINT UNIQUE(mobile, email, membership_no);

-- Below query is for PROBLEM 2
ALTER TABLE volunteer
ADD COLUMN police_clearance_due_date DATE DEFAULT '2023-01-01',
ADD COLUMN health_and_safety_due_date DATE DEFAULT '2023-01-01';

UPDATE volunteer
SET police_clearance_due_date = '2023-04-01',
health_and_safety_due_date = '2023-06-01'
WHERE volunteer_id = 'V1';

UPDATE volunteer
SET police_clearance_due_date = '2023-06-01',
health_and_safety_due_date = '2023-04-01'
WHERE volunteer_id = 'V2';

UPDATE volunteer
SET police_clearance_due_date = '2023-07-01',
health_and_safety_due_date = '2023-08-01'
WHERE volunteer_id = 'V3';

UPDATE volunteer
SET police_clearance_due_date = '2023-08-01',
health_and_safety_due_date = '2023-09-01'
WHERE volunteer_id = 'V4';

UPDATE volunteer
SET police_clearance_due_date = '2023-09-01',
health_and_safety_due_date = '2023-10-01'
WHERE volunteer_id = 'V5';

-- Below query is for PROBLEM 3
SELECT volunteer_id, first_name, last_name
FROM volunteer
WHERE police_clearance_due_date > CURDATE() and health_and_safety_due_date > CURDATE();

-- Below query is for PROBLEM 4
select volunteer_id from delivery where delivery_date != current_date();

-- Below query is for PROBLEM 5
SELECT v.volunteer_id, v.first_name, v.police_clearance_due_date, v.health_and_safety_due_date, d.delivery_id, d.delivery_date
FROM volunteer v
JOIN delivery d ON v.volunteer_id = d.volunteer_id
WHERE v.police_clearance_due_date > CURDATE()
  AND v.health_and_safety_due_date > CURDATE()
  AND d.delivery_date != CURDATE();

-- Below query is for PROBLEM 6
select * from resource where resource_id in (select resource_id from borrowing where due_date< current_date());