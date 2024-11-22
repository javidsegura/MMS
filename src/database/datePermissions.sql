CREATE ROLE staff;
CREATE ROLE user;

GRANT SELECT, INSERT, UPDATE ON mms.* TO staff;
GRANT SELECT ON mms.* TO user;

GRANT staff TO 'staff_user'@'localhost';
GRANT user TO 'general_user'@'localhost';