--Last Edited: 16/10/2022
--Patrick Holt
--Assignment 3
--------------------------------------------------------------------------------------------------------------------------------
--2.1

DROP TABLE Staff
DROP TABLE Student
DROP TABLE Moveable
DROP TABLE Immovable
DROP TABLE Loan
DROP TABLE CourseOfferingPrivilege
DROP TABLE StudentCourseOffering
DROP TABLE Acquisition
DROP TABLE Reservation
DROP TABLE Member
DROP TABLE Resource
DROP TABLE Category
DROP DATABASE SCS

CREATE DATABASE SCS

CREATE TABLE Member(
	memberID Varchar(10) NOT NULL,
	name Varchar(30) NOT NULL,
	address Varchar(50),
	phone Varchar(13),
	email Varchar(30),
	status Varchar(10) default 'Active' CHECK (status IN ('Active', 'Inactive')) NOT NULL,
	comments Varchar(150),

	PRIMARY KEY (memberID),
	);
GO

CREATE TABLE Staff(
	memberID Varchar(10) NOT NULL,
	role Varchar(40) NOT NULL,

	PRIMARY KEY (memberID),
	FOREIGN KEY (memberID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE StudentCourseOffering(
	offerID Varchar(10) NOT NULL,
	courseName Varchar(40) NOT NULL,
	dateStart Datetime  NOT NULL,
	dateEnd Datetime  NOT NULL,

	PRIMARY KEY (offerID),
	);
GO
CREATE TABLE Student(
	memberID Varchar(10) NOT NULL,
	borrowed Int NOT NULL default '0',
	totalOwed Varchar(8),
	studentStatus Varchar(8) default 'Enabled' CHECK (studentStatus IN ('Enabled', 'Disabled')) NOT NULL,
	offerID Varchar(10) NOT NULL,

	PRIMARY KEY (memberID),
	FOREIGN KEY (memberID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (offerID) REFERENCES StudentCourseOffering(offerID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE Category(
	categoryID Varchar(10) NOT NULL,
	name Varchar(20) NOT NULL,
	categoryDescription Varchar(100) NOT NULL,
	durationDays Int NOT NULL,
	durationHours Int NOT NULL,

	PRIMARY KEY (categoryID),
	);
GO

CREATE TABLE Resource(
	resourceID Varchar(10) NOT NULL,
	categoryID Varchar(10) NOT NULL,
	resourceDescription Varchar(100),
	resourceStatus Varchar(11) NOT NULL default 'Available' CHECK (resourceStatus IN ('Available', 'Occupied', 'Damaged')),
	campus Varchar(30) default 'SDS' NOT NULL,
	building Varchar(30) default 'BSD' NOT NULL,
	room Varchar(25) default 'School Resource Centre' NOT NULL,

	PRIMARY KEY (resourceID),
	FOREIGN KEY (categoryID) REFERENCES Category(categoryID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE Moveable(
	resourceID Varchar(10) NOT NULL,
	name Varchar(40) NOT NULL,
	manufacturer Varchar(25) NOT NULL,
	model Varchar(40) NOT NULL,
	year Int NOT NULL,
	assetValue Varchar(8) NOT NULL,

	PRIMARY KEY (resourceID),
	FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE Immovable(
	resourceID Varchar(10) NOT NULL,
	capacity Int NOT NULL,

	PRIMARY KEY (resourceID),
	FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE Loan(
	loanID Varchar(10) NOT NULL,	
	dateTimeBorrowed Datetime  NOT NULL,
	dateTimeReturned Datetime,
	dateTimeDue Datetime  NOT NULL,
	memberID Varchar(10) NOT NULL,
	resourceID Varchar(10) NOT NULL,

	PRIMARY KEY (loanID),
	FOREIGN KEY (memberID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE CourseOfferingPrivilege(
	privID Varchar(10) NOT NULL,
	privilegeDescription Varchar(100),
	borrowCapacity Int default '3' NOT NULL,
	categoryID Varchar(10) NOT NULL,
	offerID Varchar(10) NOT NULL,

	PRIMARY KEY (privID),
	FOREIGN KEY (categoryID) REFERENCES Category(categoryID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (offerID) REFERENCES StudentCourseOffering(offerID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE Acquisition(
	acquisitionID Varchar(10) NOT NULL,
	name Varchar(40) NOT NULL,
	manufacturer Varchar(25) NOT NULL,
	model Varchar(40) NOT NULL,
	year Int NOT NULL,
	price Varchar(8) NOT NULL,
	reasoning Varchar(100) NOT NULL,
	urgency Varchar(10) NOT NULL default 'Not Urgent' CHECK (urgency IN ('Not Urgent', 'Urgent')),
	memberID Varchar(10) NOT NULL,

	PRIMARY KEY (acquisitionID),
	FOREIGN KEY (memberID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

CREATE TABLE Reservation(
	reservationID Varchar(10) NOT NULL,
	reservedForDateTime datetime  NOT NULL,
	memberID Varchar(10) NOT NULL,
	resourceID Varchar(10) NOT NULL,

	PRIMARY KEY (reservationID),
	FOREIGN KEY (memberID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON UPDATE CASCADE ON DELETE NO ACTION,
	);
GO

--------------------------------------------------------------------------------------------------------------------------------
--2.2
--2.2.1

INSERT INTO StudentCourseOffering(offerID, courseName, dateStart, dateEnd) values('10100-3399', 'Introduction To Photography', '2021-12-10 00:00:01', '2022-12-10 00:00:01')
INSERT INTO StudentCourseOffering(offerID, courseName, dateStart, dateEnd) values('10100-2135', 'Introduction To Sound Design', '2021-12-10 00:00:01', '2022-12-10 00:00:01')
INSERT INTO StudentCourseOffering(offerID, courseName, dateStart, dateEnd) values('10100-4890', 'Software Engineering Fundamentals', '2021-12-10 00:00:01', '2022-12-10 00:00:01')
INSERT INTO StudentCourseOffering(offerID, courseName, dateStart, dateEnd) values('10100-6011', 'Primary School Teaching', '2021-12-10 00:00:01', '2022-12-10 00:00:01')

INSERT INTO Member(memberID, name, address, phone, email, comments) values('9400-61910', 'Johnny Knox', '590/12 Booket Pl', '0947521700', 'johnnyknox123@gmail.com', 'Failed to return resource on time 11/09/2020')
INSERT INTO Member(memberID, name, address, phone, email, comments) values('9400-82257', 'Samual Web', '120 Smith St', '0911844292', 'sammy2241@hotmail.com', 'Returned a resource damaged, willing to pay so can continue to borrow')
INSERT INTO Member(memberID, name, address, phone, email, comments) values('9400-29537', 'Rebecca Tyka', '17 Myst St', '0933582001', 'tykatyka1212@yahoo.com', 'Good standing')
INSERT INTO Member(memberID, name, address, phone, email) values('9400-68021', 'Alanna Simmons', '31 Kira Cl', '0998627450', 'asimmy@gmail.com')
INSERT INTO Member(memberID, name, address, phone, email, comments) values('9400-28461', 'Mick Burkett', '12 Silly St', '0922893811', 'm.burkett1@sds.edu.au.com', 'Requires extra time on some resources')
INSERT INTO Member(memberID, name, address, phone, email) values('9400-89211', 'Bill Sader', '21/50 Buckingwood Pl', '0935938100', 'b.sader@sds.edu.au.com')
INSERT INTO Member(memberID, name, address, phone, email, comments) values('9400-96032', 'Shaun Ying', '3 Sizzle Cl', '0931012186', 'shaun.ying@sds.edu.au.com', 'Need to update phone number, Likes to reserve the same room on Tuesdays')
INSERT INTO Member(memberID, name, address, phone, email) values('9400-69346', 'Keeley Skarsgard', '22 Meak St', '0922483302', 'kskars@sds.edu.au.com')

INSERT INTO Staff(MemberID, role) values('9400-28461', 'Senior Photography Coordinator')
INSERT INTO Staff(MemberID, role) values('9400-89211', 'Music Professor')
INSERT INTO Staff(MemberID, role) values('9400-96032', 'Tutor')
INSERT INTO Staff(MemberID, role) values('9400-69346', 'Information Technology Professor')

INSERT INTO Student(MemberID, totalOwed, studentStatus, offerID) values('9400-61910', '$12.50', 'Disabled', '10100-3399')
INSERT INTO Student(MemberID, totalOwed, offerID) values('9400-82257', '$59.99', '10100-2135')
INSERT INTO Student(MemberID, borrowed, offerID) values('9400-29537', '2', '10100-4890')
INSERT INTO Student(MemberID, offerID) values('9400-68021', '10100-6011')

INSERT INTO Category(categoryID, name, categoryDescription, durationDays, durationHours) values('1200100-12', 'Room', 'A room that can be used for tutoring, lectures, or studying', '0', '3')
INSERT INTO Category(categoryID, name, categoryDescription, durationDays, durationHours) values('1200100-90', 'Camera', 'A device to take photos, mostly used by photography students and staff', '7', '0')
INSERT INTO Category(categoryID, name, categoryDescription, durationDays, durationHours) values('1200100-21', 'Software', 'Downloadable software given to students for computer based courses', '150', '0')
INSERT INTO Category(categoryID, name, categoryDescription, durationDays, durationHours) values('1200100-56', 'Speaker', 'A device used that produces sound that are mostly used by music students and staff', '0', '3')

INSERT INTO Resource(resourceID, categoryID, resourceDescription) values('11100-2122', '1200100-21', 'Course-recommended diagram designer')
INSERT INTO Resource(resourceID, categoryID, resourceDescription) values('11100-2371', '1200100-90', 'A high-tech camera used for high-definition photography')
INSERT INTO Resource(resourceID, categoryID, resourceDescription) values('11100-3217', '1200100-21', 'Course-recommended source-code editor subscription')
INSERT INTO Resource(resourceID, categoryID, resourceDescription) values('11100-4190', '1200100-56', 'Large guitar amp')
INSERT INTO Resource(resourceID, categoryID, resourceDescription, building, room) values('1110-00101', '1200100-12', 'Main lecture hall in B01', 'B01', '101')
INSERT INTO Resource(resourceID, categoryID, resourceDescription, building, room) values('1110-00205', '1200100-12', 'Small classroom in B01 on 2nd floor', 'B01', '205')
INSERT INTO Resource(resourceID, categoryID, resourceDescription, building, room) values('1110-00325', '1200100-12', 'Small classroom in B01 on 3rd floor', 'B01', '325')
INSERT INTO Resource(resourceID, categoryID, resourceDescription, building, room) values('1110-01102', '1200100-12', 'Second largest lecture hall in B02', 'B02', '102')

INSERT INTO Moveable(resourceID, name, manufacturer, model, year, assetValue) values('11100-2122', 'Visia', 'Microsoft', 'N/A', '2021', '$6.90/m')
INSERT INTO Moveable(resourceID, name, manufacturer, model, year, assetValue) values('11100-2371', 'Super Frame', 'Nokia', 'NSF200051', '2022', '$1200')
INSERT INTO Moveable(resourceID, name, manufacturer, model, year, assetValue) values('11100-3217', 'Visual Studio Code Premium', 'Microsoft', 'N/A', '2015', '$40/m')
INSERT INTO Moveable(resourceID, name, manufacturer, model, year, assetValue) values('11100-4190', 'Super Loud GAmp', 'Samsung', 'SGA221345', '2017', '$350')

INSERT INTO Immovable(resourceID, capacity) values('1110-00101', '200')
INSERT INTO Immovable(resourceID, capacity) values('1110-00205', '30')
INSERT INTO Immovable(resourceID, capacity) values('1110-00325', '30')
INSERT INTO Immovable(resourceID, capacity) values('1110-01102', '50')

INSERT INTO Loan(loanID, dateTimeBorrowed, dateTimeDue, memberID, resourceID) values('7011-02122', '2021-12-21 12:50:55', '2022-05-20 12:50:55', '9400-29537', '11100-2122')
INSERT INTO Loan(loanID, dateTimeBorrowed, dateTimeDue, memberID, resourceID) values('7011-02123', '2021-12-25 16:32:12', '2022-05-24 16:32:12', '9400-29537', '11100-3217')
INSERT INTO Loan(loanID, dateTimeBorrowed, dateTimeReturned, dateTimeDue, memberID, resourceID) values('7011-06900', '2022-10-01 09:12:42', '2022-10-07 12:12:53', '2022-10-08 09:12:42', '9400-61910', '11100-2371')
INSERT INTO Loan(loanID, dateTimeBorrowed, dateTimeReturned, dateTimeDue, memberID, resourceID) values('7011-04235', '2022-03-11 10:25:40', '2022-03-11 13:01:22', '2022-03-11 13:25:40', '9400-89211', '11100-4190')


INSERT INTO CourseOfferingPrivilege(privID, privilegeDescription, borrowCapacity, categoryID, offerID) values('10211-3399', 'Photography students may borrow 1 cameras for their study', '1', '1200100-90', '10100-3399')
INSERT INTO CourseOfferingPrivilege(privID, privilegeDescription, borrowCapacity, categoryID, offerID) values('10211-2135', 'Music students may borrow 1 speaker for their study', '1', '1200100-56', '10100-2135')
INSERT INTO CourseOfferingPrivilege(privID, privilegeDescription, borrowCapacity, categoryID, offerID) values('10211-4890', 'Software engineering students may borrow 3 software subscriptions or products for their study', '3', '1200100-21', '10100-4890')
INSERT INTO CourseOfferingPrivilege(privID, privilegeDescription, borrowCapacity, categoryID, offerID) values('10211-6011', 'Primary school teachers can loan rooms for study', '1', '1200100-12', '10100-6011')

INSERT INTO Acquisition(acquisitionID, name, manufacturer, model, year, price, reasoning, urgency, memberID) values('2112-01554', 'Extra Super Load GAmp NEW', 'Samsung', 'SGA3221555', '2022', '$499.99', 'Super Loud GAmp is aged and needs replacing', 'Urgent', '9400-89211')
INSERT INTO Acquisition(acquisitionID, name, manufacturer, model, year, price, reasoning, memberID) values('2112-82157', 'BlueJ Premium', 'Michael Kölling', 'NA', '2022', '$12.55/m', 'Hard to program without this', '9400-29537')
INSERT INTO Acquisition(acquisitionID, name, manufacturer, model, year, price, reasoning, memberID) values('2112-37432', 'Teaching For Dummies', 'John Simone', 'NA', '2021', '$55.00', 'Require new textbooks for teaching', '9400-68021')
INSERT INTO Acquisition(acquisitionID, name, manufacturer, model, year, price, reasoning, urgency, memberID) values('2112-23144', 'Masters Film Camera', 'Toshiba', 'Film Pro', '2022', '$4500.00', 'Need film camera for next years movie making course', 'Urgent', '9400-28461')

INSERT INTO Reservation(reservationID, reservedForDateTime, memberID, resourceID) values('6990-01561', '2022-05-01 06:22:11', '9400-96032', '1110-00325')
INSERT INTO Reservation(reservationID, reservedForDateTime, memberID, resourceID) values('6990-02122', '2022-06-05 09:40:59', '9400-96032', '1110-00325')
INSERT INTO Reservation(reservationID, reservedForDateTime, memberID, resourceID) values('6990-03288', '2022-09-19 15:22:14', '9400-28461', '11100-2371')
INSERT INTO Reservation(reservationID, reservedForDateTime, memberID, resourceID) values('6990-03167', '2022-11-20 1:00:00', '9400-89211', '11100-4190')

--2.2.1
--Q1:
SELECT m.name
FROM Member m JOIN Student s
ON (m.memberID = s.memberID)
WHERE s.offerID = '10100-4890'

--Q2:
SELECT p.borrowCapacity 
FROM Member m JOIN Student s
ON (m.memberID = s.memberID) 
JOIN CourseOfferingPrivilege p
ON (s.offerID = p.offerID)
WHERE m.name = 'Samual Web' AND p.offerID = '10100-2135'

--Q3:
SELECT m.name, m.phone, COUNT(r.reservationID) AS totalReservations
FROM Member m JOIN Reservation r
ON (m.memberID = r.memberID)
WHERE m.memberID = '9400-96032' AND YEAR(r.reservedForDateTime) = 2022
GROUP BY m.name, m.phone;

--Q4:
SELECT m.name
FROM Member m JOIN Loan l
ON (m.memberID = l.memberID)
JOIN Moveable mr
ON (l.resourceID = mr.resourceID)
JOIN Resource r
ON (r.resourceID = mr.resourceID)
JOIN Category c
ON (c.categoryID = r.categoryID)
WHERE c.name = 'Camera' AND mr.model = 'NSF200051' AND YEAR(l.dateTimeBorrowed) = YEAR(GETDATE())

--Q5:
SELECT TOP 1 m.name, m.resourceID
FROM Loan l JOIN Moveable m
ON (m.resourceID = l.resourceID)
JOIN Resource r
ON (m.resourceID = r.resourceID)
WHERE MONTH(l.dateTimeBorrowed) = MONTH(GETDATE())
GROUP BY m.name, m.resourceID

--Q6:
SELECT r.reservedForDateTime, COUNT(r.reservationID) as reservationsMade, re.room
FROM Reservation r JOIN Resource re
ON (r.resourceID = re.resourceID)
WHERE DAY(r.reservedForDateTime) = 01 AND MONTH(r.reservedForDateTime) = 05 AND YEAR(r.reservedForDateTime) = 2022 OR
	  DAY(r.reservedForDateTime) = 05 AND MONTH(r.reservedForDateTime) = 06 AND YEAR(r.reservedForDateTime) = 2022 OR
	  DAY(r.reservedForDateTime) = 19 AND MONTH(r.reservedForDateTime) = 09 AND YEAR(r.reservedForDateTime) = 2022
GROUP BY r.reservedForDateTime, re.campus, re.building, re.room

--Display Database
SELECT *
FROM Member

SELECT *
FROM Staff

SELECT *
FROM Student

SELECT *
FROM StudentCourseOffering

SELECT *
FROM CourseOfferingPrivilege

SELECT *
FROM Resource

SELECT *
FROM Moveable

SELECT *
FROM Immovable

SELECT *
FROM Category

SELECT *
FROM Loan

SELECT *
FROM Acquisition

SELECT *
FROM Reservation