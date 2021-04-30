-- LIBRARY DATABASE SCRIPT
Drop table Phone
drop table Loan
drop table Member
drop table MemberType
drop table Book




-- BOOK TABLE
CREATE TABLE Book(
accNo				CHAR(10) PRIMARY KEY,  	-- accession number
title				VARCHAR(200),			-- title of book
authors				VARCHAR(250),			-- authors of book
isbn				CHAR(20)				-- isbn number of book
)

-- MEMBERTYPE TABLE
CREATE TABLE MemberType (
code				CHAR(4) PRIMARY KEY,	-- Member type identifier
memberTypeDetails	VARCHAR(100),			-- Member type description
maxBooks			INT						-- Number of books that can be borrowed at once by member tyoe
)

-- MEMBER TABLE
CREATE TABLE Member (
memberNo			CHAR(10) PRIMARY KEY,			-- Member number
memberName			VARCHAR(250),					-- Name of member
mType				CHAR(4),						-- Member type
FOREIGN KEY(mType) REFERENCES MemberType(code) ON UPDATE CASCADE ON DELETE NO ACTION,
)

-- LOAN TABLE
CREATE TABLE Loan (
accNo				CHAR(10),						-- Accession number
memberNo			CHAR(10),						-- Member number
dateBorrowed		DATETIME	DEFAULT GETDATE(),	-- Date and time borrowed	
dueDate				DATETIME,						-- Due date of book 
dateReturned		DATETIME,						-- Date book is returned
PRIMARY KEY(accNo, memberNo, dateBorrowed),
FOREIGN KEY(accNo) REFERENCES Book(accNo) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(memberNo) REFERENCES Member(memberNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

go
--Phone Table
Create Table Phone (
memberNo		CHAR(10),       --Member Number
phoneNo			CHAR(15),		--Phone Number +61430663366  or +61283722883
phoneType		VARCHAR(10),    --Type of Phone No. Mobile, Home, Work
Primary Key (memberNo, phoneNo),
FOREIGN KEY(memberNo) REFERENCES Member(memberNo) ON UPDATE CASCADE ON DELETE NO ACTION
)
go



-- LOADING SAMPLE DATA
-- LOADING TO Book TABLE
INSERT INTO Book VALUES ('A110034567', 'Database Management Systems', 
	'Ramakrishnan, Gehrke', 'ISD-00123-0211-09287')
INSERT INTO Book VALUES ('A110233444', 'The UML User Guide', 
	'Booch, Rumbaugh, Jacobson', 'ISD-00123-02231-0923')
INSERT INTO Book VALUES ('A112344567', 'Teach Yourself C++', 
	'Al Stevens', 'ISD-00123-0211-008')
INSERT INTO Book VALUES ('A123234567', 'Oracle 9i: The Complete Reference', 
	'Loney, Koch', 'ISD-00123-0231-0928')
INSERT INTO Book VALUES ('A133234567', 'Access 2003 VBA', 
	'Cardoza, Hennig, Seach, Stein', 'ISD-00123-0322-1947')
INSERT INTO Book VALUES ('A133234570', 'Excel 2010 VBA For Dummies', 
	'Wije, Simon, Stein', 'ISD-00123-0321-2017')
INSERT INTO Book VALUES ('A133234575', 'SQL', 
	'Chris Fehily', 'ISBN-0-321-11803-0')
INSERT INTO Book VALUES ('A133234576', 'SQL in A Nutshell', 
	'Kline and Kline', 'ISBN-1-56592-744-3')
INSERT INTO Book VALUES ('A133234578', 'A UML Pattern Language', 
	'Paul Evitts', 'ISBN-1-57870-118-X')
INSERT INTO Book VALUES ('A133234577', 'Red Hat Certified Engineer Linux-Study Guide Fourth Edition', 
	'Michael Jang', 'ISBN-0-07-225365-7')
INSERT INTO Book VALUES ('A133234579', 'Current Research in Modelling, Data Mining & Quantitative Techniques', 
	'Prem, Mellor, Peiris, Rajasekera', 'ISBN-0-9751599-0-9')
INSERT INTO Book VALUES ('A132234580', 'Mathematics for Engineers', 
	'McLeod, Ganderton', 'ISBN-0-7329-2369-7')
INSERT INTO Book VALUES ('A133234581', 'C# A Beginners Guide', 
	'Tom Jones', 'ISBN-0-56231-1103-9')
INSERT INTO Book VALUES ('A134234565', 'Managing Undergraduates', 
	'Jo Trump', 'ISBN-01-451-123903-8')
INSERT INTO Book VALUES ('A134234566', 'How to Prepare for a Higher Research Degree', 
	'Sally Chan', 'ISBN-87654-234-0-8')
INSERT INTO Book VALUES ('A136234568', 'Photoshop in a Day', 
	'Lucky Au', 'ISBN-87754-8634-0-9')
INSERT INTO Book VALUES ('A134234569', 'Python in AI', 
	'Jones, Brown, Ip', 'ISBN-8-7224-2340-8')

go

-- LOADING TO MemberType TABLE
INSERT INTO MemberType VALUES ('USTD', 'Undergraduate Student', 2)
INSERT INTO MemberType VALUES ('GSTD', 'Graduate Student', 4)
INSERT INTO MemberType VALUES ('FACL', 'Faculty Member', 10)
INSERT INTO MemberType VALUES ('VSAC', 'Visiting Academic', 5)
go

-- LOADING TO Member TABLE
INSERT INTO Member VALUES ('M123456789', 'Chris Davies', 'USTD')
INSERT INTO Member VALUES ('M12333789', 'Angalie Patterson', 'USTD')
INSERT INTO Member VALUES ('M12234789', 'Mohammed Muftaz', 'USTD')
INSERT INTO Member VALUES ('M123256789', 'Upul Wijesinghe', 'GSTD')
INSERT INTO Member VALUES ('F123456789', 'Young Black', 'FACL')
INSERT INTO Member VALUES ('F123333790', 'Nick Lomma', 'FACL')
INSERT INTO Member VALUES ('F123334791', 'Tim Jones', 'FACL')
INSERT INTO Member VALUES ('F123335792', 'Lisa Wong', 'FACL')
INSERT INTO Member VALUES ('F123336793', 'Sue Brown', 'FACL')
INSERT INTO Member VALUES ('F123337794', 'Will Dennis', 'FACL')
INSERT INTO Member VALUES ('F123338795', 'Joe Dennis', 'FACL')
INSERT INTO Member VALUES ('M123256119', 'Arun Abe', 'GSTD')
INSERT INTO Member VALUES ('M123256286', 'Paul Borden', 'GSTD')
INSERT INTO Member VALUES ('M123256387', 'Vlad Kawasakie', 'GSTD')
INSERT INTO Member VALUES ('M123256484', 'Rita Bosh', 'GSTD')


go
--Loading To Phone Table
INSERT INTO Phone VALUES ('M123456789', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M12333789',  '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M12234789',  '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M123256789', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123456789', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123333790', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123334791', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123335792', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123336793', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123337794', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('F123338795', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M123256119', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M123256286', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M123256387', '+61456754441', 'Mobile')
INSERT INTO Phone VALUES ('M123256484', '+61456754441', 'Mobile')

INSERT INTO Phone VALUES ('F123456789', '+61467892545', 'Work')
INSERT INTO Phone VALUES ('F123333790', '+61467892599', 'Work')
INSERT INTO Phone VALUES ('F123334791', '+61467892597', 'Work')
INSERT INTO Phone VALUES ('F123335792', '+61467892598', 'Work')
INSERT INTO Phone VALUES ('F123336793', '+61467893235', 'Work')
INSERT INTO Phone VALUES ('F123337794', '+61467893126', 'Work')
INSERT INTO Phone VALUES ('F123338795', '+61467892989', 'Work')
INSERT INTO Phone VALUES ('M123256119', '+61467892537', 'Work')
INSERT INTO Phone VALUES ('M123256286', '+61467892556', 'Work')
INSERT INTO Phone VALUES ('M123256387', '+61467892621', 'Work')
INSERT INTO Phone VALUES ('M123256484', '+61467892537', 'Work')

INSERT INTO Phone VALUES ('M123456789', '+61297891344', 'Home')
INSERT INTO Phone VALUES ('M12333789',  '+61387654891', 'Home')
INSERT INTO Phone VALUES ('M12234789',  '+61645987431', 'Home')
INSERT INTO Phone VALUES ('M123256789', '+61798902340', 'Home')



go

-- LOADING TO Loan TABLE
INSERT INTO Loan VALUES ('A110034567', 'M123456789', '23-APR-2019', '23-JUN-2019', null)
INSERT INTO Loan VALUES ('A110034567', 'F123456789', '25-MAY-2018', '25-SEP-2018', '20-OCT-2018')
INSERT INTO Loan VALUES ('A112344567', 'M123456789', '28-FEB-2019', '31-MAY-2019', null)
INSERT INTO Loan VALUES ('A112344567', 'F123456789', '25-MAY-2018', '25-OCT-2018', '24-OCT-2018')
INSERT INTO Loan VALUES ('A123234567', 'F123456789', '28-FEB-2017', '31-MAY-2017', '30-MAR-2017')
INSERT INTO Loan VALUES ('A133234567', 'M123456789', '27-FEB-2019', '30-MAY-2019', null)

INSERT INTO Loan VALUES ('A133234575', 'M123456789', '23-SEP-2019', '30-OCT-2019', null)
INSERT INTO Loan VALUES ('A133234575', 'M123456789', '23-APR-2018', '23-JUN-2018', '15-JUN-2018')
INSERT INTO Loan VALUES ('A133234575', 'F123456789', '23-JAN-2017', '23-MAR-2017', '10-APR-2017')
INSERT INTO Loan VALUES ('A134234566', 'F123456789', '23-APR-2019', '23-JUN-2019', '15-JUL-2019')
INSERT INTO Loan VALUES ('A134234566', 'M123256119', '23-SEP-2019', '25-NOV-2019', null)


INSERT INTO Loan VALUES ('A133234578', 'F123333790', '23-DEC-2018', '28-FEB-2019', '15-MAR-2019')
INSERT INTO Loan VALUES ('A134234566', 'F123333790', '23-SEP-2019', '30-OCT-2019', null)
INSERT INTO Loan VALUES ('A133234581', 'F123333790', '12-AUG-2018', '12-OCT-2018', '11-OCT-2018')
INSERT INTO Loan VALUES ('A134234569', 'M123256119', '23-SEP-2019', '30-OCT-2019', null)

go

UPDATE MemberType
SET maxBooks = maxBooks+2
go

SELECT m.memberNo, COUNT(*) AS MyCount
FROM Member m, Loan l
WHERE m.memberNo = l.memberNo
GROUP BY m.memberNo, l.memberNo
go

DELETE FROM Phone
WHERE memberNo = 'M123456789'

SELECT b.*
FROM Phone b