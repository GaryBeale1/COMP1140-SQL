DROP TABLE IngredientData
DROP TABLE SupplierData
DROP TABLE IngredientOrder
DROP TABLE MenuItem
DROP TABLE DriverStaffPayment
DROP TABLE InstoreStaffPayment
DROP TABLE DriverStaffShift
DROP TABLE InstoreStaffShift
DROP TABLE StaffShift
DROP TABLE DriverStaff
DROP TABLE InstoreStaff
DROP TABLE DeliveryOrder
DROP TABLE PickupOrder
DROP TABLE PhoneOrder
DROP TABLE WalkInOrder
DROP TABLE POrder
DROP TABLE Staff
DROP TABLE StaffPayment
DROP TABLE Customer

CREATE TABLE Customer(
CusId			Char(10) PRIMARY KEY,
fName			VarChar(10)		NOT NULL,
lName			VarChar(10)		NOT NULL,
CusAddress		VarChar(20)		NOT NULL,
Phone			Int				NOT NULL,
)

CREATE TABLE StaffPayment(
PaymentRecId	Char(10) PRIMARY KEY,
GrossPayment	Float			NOT NULL,
TaxWithheld		Float			NOT NULL,
TotalAmountPaid	Float			NOT NULL,
DatePaid		Date			NOT NULL
)

CREATE TABLE StaffShift(
ShiftNo			Char(10) PRIMARY KEY,
StartDate		Date			NOT NULL,
StartTime		Time			NOT NULL,
EndDate			Date			NOT NULL,
EndTime			Time			NOT NULL
)

CREATE TABLE Staff(
EmployeeNo		Char(10) PRIMARY KEY,
FirstName		VarChar(10)		NOT NULL,
LastName		VarChar(10)		NOT NULL,
PostalAddress	VarChar(20)		NOT NULL,
TaxFileNo		Char(10),
ContactNumber	Int				NOT NULL,
AvalibleFrom	Time			NOT NULL,
AvalibleTo		Time			NOT NULL,
WorkStatus		Char(8) CHECK (WorkStatus IN ('avalible','leave'))	Default 'avalible'	NOT NULL,
PaymentRecId	Char(10)		NOT NULL
FOREIGN KEY(PaymentRecId) REFERENCES StaffPayment(PaymentRecId) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE POrder(
OrderNo			Char(10) PRIMARY KEY,
TotalCost		Float			NOT NULL,
NoOfItems		Int				NOT NULL,
DateOrdered		Date			DEFAULT (GETDATE())		NOT NULL,
CustomerId		Char(10)		NOT NULL,
StaffNo			Char(10)		NOT NULL,
FOREIGN KEY(CustomerId) REFERENCES Customer(Cusid) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(StaffNo) REFERENCES Staff(EmployeeNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE WalkInOrder(
OrderNo			Char(10) PRIMARY KEY REFERENCES POrder(OrderNo),
WalkInTime		Time			NOT NULL
)

CREATE TABLE PhoneOrder(
OrderNo			Char(10) PRIMARY KEY REFERENCES POrder(OrderNo),
TimeAnswered	Time			NOT NULL,
TimeEnded		Time			NOT NULL
)

CREATE TABLE DeliveryOrder(
OrderNo			Char(10) PRIMARY KEY REFERENCES PhoneOrder(OrderNo),
DeliveryAddress	VarChar(20)		NOT NULL,
DeliveryTime	Time			NOT NULL
)

CREATE TABLE PickupOrder(
OrderNo			Char(10) PRIMARY KEY REFERENCES PhoneOrder(OrderNo),
PickupTime		Time			NOT NULL
)

CREATE TABLE DriverStaff(
EmployeeNo		Char(10) PRIMARY KEY REFERENCES Staff(EmployeeNo),
PayPerDelivery	Float			NOT NULL,
DriverLicense	Char(10)		NOT NULL	
)

CREATE TABLE InstoreStaff(
EmployeeNo		Char(10) PRIMARY KEY REFERENCES Staff(EmployeeNo),
HoursWorked		Float			NOT NULL
)

CREATE TABLE DriverStaffShift(
ShiftNo			Char(10) PRIMARY KEY REFERENCES StaffShift(ShiftNo),
DeliveriesMade	Int		DEFAULT '0'		NOT NULL, 
EmployeeNo		Char(10)		NOT NULL,
FOREIGN KEY(EmployeeNo) REFERENCES DriverStaff(EmployeeNo) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE InstoreStaffShift(
ShiftNo			Char(10) PRIMARY KEY REFERENCES StaffShift(ShiftNo),
HourlyPayrate	Float			NOT NULL,
EmployeeNo		Char(10)		NOT NULL,
FOREIGN KEY(EmployeeNo) REFERENCES InstoreStaff(EmployeeNo) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE DriverStaffPayment(
PaymentRecId	Char(10) PRIMARY KEY REFERENCES StaffPayment(PaymentRecId),
PaidDelsMade	Int				NOT NULL,
DeliveriesPad	Int				NOT NULL,
ShiftNo			Char(10)		NOT NULL,
FOREIGN KEY(ShiftNo) REFERENCES DriverStaffShift(ShiftNo) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE InstoreStaffPayment(
PaymentRecId	Char(10) PRIMARY KEY REFERENCES StaffPayment(PaymentRecId),
HourlyPayrate	Float			NOT NULL,
HoursPaid		Float			NOT NULL,
ShiftNo			Char(10)		NOT NULL,
FOREIGN KEY(ShiftNo) REFERENCES InstoreStaffShift(ShiftNo) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE MenuItem(
ItemNo			Char(10) PRIMARY KEY,
ItemName		VarChar(10)		NOT NULL,
CurrentSelling  Float,
ItemDescription VarChar(100)	NOT NULL,
OrderId			Char(10)		NOT NULL,
FOREIGN KEY(OrderId) REFERENCES POrder(OrderNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE IngredientOrder(
IngOrderNo		Char(10) PRIMARY KEY,
DateOrdered		Date			NOT NULL
)

CREATE TABLE IngredientData(
IngredientNo	Char(10) PRIMARY KEY,
IngName			VarChar(10)		NOT NULL,
ItemNo			Char(10)		NOT NULL,
IngOrderNo		Char(10)		NOT NULL,
FOREIGN KEY(IngOrderNo) REFERENCES IngredientOrder(IngOrderNo) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY(ItemNo) REFERENCES MenuItem(ItemNo) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE SupplierData(
SupplierNo		Char(10) PRIMARY KEY,
SupplierName	VarChar(20)		NOT NULL,
SupplierAddress	VarChar(20)		NOT NULL,
SupplierPhone	Char(10),
Email			VarChar(20),
ContactName		VarChar(20)		NOT NULL,
IngOrderNo		Char(10)		NOT NULL,
FOREIGN KEY(IngOrderNo) REFERENCES IngredientOrder(IngOrderNo) ON UPDATE CASCADE ON DELETE NO ACTION
)


INSERT INTO Customer VALUES('0111111111','Gary','Beale','61 Bradys Gully','0432104205')
INSERT INTO Customer VALUES('0111111112','Jakob','Parris','2 Golden Ave','0429471028')
INSERT INTO Customer VALUES('0111111113','Gayle','Wilson','14 Minerton St','0457294199')

INSERT INTO StaffShift VALUES('0611111111','10/31/2019','12:00PM','10/31/2019','3:30PM')
INSERT INTO StaffShift VALUES('0611111112','10/31/2019','4:00PM','10/31/2019','11:30PM')
INSERT INTO StaffShift VALUES('0611111113','10/31/2019','12:00PM','10/31/2019','8:00PM')
INSERT INTO StaffShift VALUES('0611111114','11/1/2019','12:00PM','11/1/2019','4:30PM')
INSERT INTO StaffShift VALUES('0611111115','11/1/2019','4:00PM','11/1/2019','11:15PM')
INSERT INTO StaffShift VALUES('0611111116','11/1/2019','12:00PM','11/1/2019','7:45PM')
INSERT INTO StaffShift VALUES('0611111117','11/2/2019','12:00PM','11/2/2019','4:00PM')
INSERT INTO StaffShift VALUES('0611111118','11/2/2019','4:00PM','11/2/2019','11:00PM')
INSERT INTO StaffShift VALUES('0611111119','11/2/2019','12:00PM','11/2/2019','8:15PM')

INSERT INTO StaffPayment VALUES('0911111111','250','10','240','11/30/2019')
INSERT INTO StaffPayment VALUES('0911111112','192.5','14','178.5','11/30/2019')
INSERT INTO StaffPayment VALUES('0911111113','0','0','0','11/30/2019')
INSERT INTO StaffPayment VALUES('0911111114','221','11','210','11/30/2019')
INSERT INTO StaffPayment VALUES('0911111115','0','0','0','11/30/2019')
INSERT INTO StaffPayment VALUES('0911111116','210','12','198','10/30/2019')

INSERT INTO Staff VALUES('0311111111','Savannah','Tilley','3 Golden Ave','6773991732','0428401825','12:00PM','4:00PM','avalible','0911111111')
INSERT INTO Staff VALUES('0311111112','Khalid','Whittaker','63 Buff Cl','7482018274','0419274912','4:00PM','11:00PM',Default,'0911111112')
INSERT INTO Staff VALUES('0311111113','Todd','White','42 Carti St','3810382038','0429332102','6:00PM','11:00PM','leave','0911111113')
INSERT INTO Staff VALUES('0311111114','Keanu','McIntosh','12 Ming Rd','2801824702','0436271773','12:00PM','8:00PM','avalible','0911111114')
INSERT INTO Staff VALUES('0311111115','Genevieve','Baker','72 Mingara Rd',NULL,'0448292842','12:00PM','11:00PM','leave','0911111115')
INSERT INTO Staff VALUES('0311111116','Symere','Woods','13 Eternal Ave','4910299489','0433661836','7:00PM','10:00PM','avalible','0911111116')

INSERT INTO POrder VALUES('0211111111','9.99','2','10/30/2019','0111111111','0311111111')
INSERT INTO POrder VALUES('0211111112','7.00','1','10/30/2019','0111111112','0311111112')
INSERT INTO POrder VALUES('0211111113','9.99','2','10/31/2019','0111111111','0311111111')
INSERT INTO POrder VALUES('0211111114','20','4','10/31/2019','0111111113','0311111112')
INSERT INTO POrder VALUES('0211111115','12.50','2',Default,'0111111113','0311111112')
INSERT INTO POrder VALUES('0211111116','15','3','11/1/2019','0111111112','0311111112')
INSERT INTO POrder VALUES('0211111117','7.00','1','11/2/2019','0111111113','0311111112')
INSERT INTO POrder VALUES('0211111118','12.50','2','11/2/2019','0111111111','0311111111')
INSERT INTO POrder VALUES('0211111119','7.00','1','11/2/2019','0111111112','0311111111')


INSERT INTO DriverStaff VALUES('0311111114','8.50','2718472810')
INSERT INTO DriverStaff VALUES('0311111115','12.75','2850295383')
INSERT INTO DriverStaff VALUES('0311111116','10.25','2280182421')

INSERT INTO InstoreStaff VALUES('0311111111','10.5')
INSERT INTO InstoreStaff VALUES('0311111112','14')
INSERT INTO InstoreStaff VALUES('0311111113','13.25')

INSERT INTO WalkInOrder VALUES('0211111111','8:32PM')
INSERT INTO WalkInOrder VALUES('0211111115','6:46PM')
INSERT INTO WalkInOrder VALUES('0211111116','7:22PM')

INSERT INTO PhoneOrder VALUES('0211111114','8:44PM','8:51PM')
INSERT INTO PhoneOrder VALUES('0211111112','6:03PM','6:07PM')
INSERT INTO PhoneOrder VALUES('0211111113','7:52PM','8:01PM')
INSERT INTO PhoneOrder VALUES('0211111117','5:34PM','5:40PM')
INSERT INTO PhoneOrder VALUES('0211111118','9:23PM','9:27PM')
INSERT INTO PhoneOrder VALUES('0211111119','7:12PM','7:21PM')

INSERT INTO DeliveryOrder VALUES('0211111112','61 Bradys Gully','9:14PM')
INSERT INTO DeliveryOrder VALUES('0211111113','61 Bradys Gully','8:11PM')
INSERT INTO DeliveryOrder VALUES('0211111118','61 Bradys Gully','9:47PM')

INSERT INTO PickupOrder VALUES('0211111114','9:12PM')
INSERT INTO PickupOrder VALUES('0211111117','5:59PM')
INSERT INTO PickupOrder VALUES('0211111119','7:43PM')


INSERT INTO DriverStaffShift VALUES('0611111115','1','0311111114')
INSERT INTO DriverStaffShift VALUES('0611111116',default,'0311111116')
INSERT INTO DriverStaffShift VALUES('0611111117','2','0311111116')
INSERT INTO DriverStaffShift VALUES('0611111118','0','0311111114')

INSERT INTO InstoreStaffShift VALUES('0611111112','15.65','0311111112')
INSERT INTO InstoreStaffShift VALUES('0611111111','10','0311111111')
INSERT INTO InstoreStaffShift VALUES('0611111113','10','0311111111')
INSERT INTO InstoreStaffShift VALUES('0611111114','15.65','0311111112')

INSERT INTO DriverStaffPayment VALUES('0911111114','1','1','0611111115')
INSERT INTO DriverStaffPayment VALUES('0911111115','0','0','0611111116')
INSERT INTO DriverStaffPayment VALUES('0911111116','2','1','0611111117')

INSERT INTO InstoreStaffPayment VALUES('0911111111','12.50','14','0611111111')
INSERT INTO InstoreStaffPayment VALUES('0911111112','15.75','12','0611111112')
INSERT INTO InstoreStaffPayment VALUES('0911111113','9.25','0','0611111113')

INSERT INTO MenuItem VALUES('0411111111','Veg','6.00','Vegitarian pizza','0211111111')
INSERT INTO MenuItem VALUES('0411111112','Cheese','4.50','Cheese Pizza','0211111111')
INSERT INTO MenuItem VALUES('0411111113','Pepperoni','5.00','Pepperoni Pizza','0211111112')

INSERT INTO IngredientOrder VALUES('0611111111','10/31/2019')
INSERT INTO IngredientOrder VALUES('0611111112','11/2/2019')
INSERT INTO IngredientOrder VALUES('0611111113','11/2/2019')

INSERT INTO IngredientData VALUES('0511111111','Spinach','0411111111','0611111112')
INSERT INTO IngredientData VALUES('0511111112','Tomato','0411111111','0611111112')
INSERT INTO IngredientData VALUES('0511111113','Cheese','0411111112','0611111113')
INSERT INTO IngredientData VALUES('0511111114','Ham','0411111113','0611111111')

INSERT INTO SupplierData VALUES('0711111111','Gregs Gardens','4 Mangrove Rd','0438192094',NULL,'Greg Bertoss','0611111112')
INSERT INTO SupplierData VALUES('0711111112','Chad Cheese','128 Dungog St',NULL,'chad@cheese.com','Chad Singleton','0611111113')
INSERT INTO SupplierData VALUES('0711111113','Manny Meat','1 Elder Cl','0418493001','manny@gmail.com.','Manny Jr','0611111111')

go

SELECT i.EmployeeNo, s.FirstName, s.LastName, p.HourlyPayrate
FROM InstoreStaff i, Staff s, InstoreStaffPayment p
WHERE s.EmployeeNo = i.EmployeeNo AND
	  s.EmployeeNo ='0311111111' AND
	  p.PaymentRecId = s.PaymentRecId

SELECT w.*
FROM StaffShift w, Staff s, DriverStaffShift d
WHERE s.FirstName = 'Keanu' AND
	  s.LastName = 'McIntosh' AND
	  w.StartDate BETWEEN '11/1/2019' AND '11/2/2019' AND
	  d.EmployeeNo = s.EmployeeNo AND
	  w.ShiftNo = d.ShiftNo

SELECT o.*
FROM POrder o, Customer c, WalkInOrder w
WHERE c.fName = 'Gary' AND
	  c.lName = 'Beale' AND
	  o.DateOrdered BETWEEN '10/31/2019' AND '11/1/2019' AND
	  w.OrderNo = o.OrderNo

SELECT p.TotalAmountPaid, s.FirstName
FROM StaffPayment p, DriverStaff d, Staff s
WHERE s.PaymentRecId = p.PaymentRecId AND
	  d.EmployeeNo = s.EmployeeNo AND
	  MONTH(p.DatePaid) = MONTH(GETDATE()) AND
	  s.FirstName = 'Symere' AND
	  s.LastName = 'Woods'


SELECT d.IngName, s.SupplierName
FROM IngredientData d, IngredientOrder o, SupplierData s
WHERE o.IngOrderNo = s.IngOrderNo AND
	  s.SupplierNo = '0711111111' AND
	  o.DateOrdered = '11/2/2019' AND
	  o.IngOrderNo = d.IngOrderNo