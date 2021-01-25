CREATE Table Users
(
username VARCHAR(20) PRIMARY KEY,
password VARCHAR(20),
first_name VARCHAR(20) ,
last_name VARCHAR(20),
email VARCHAR(50) NOT NULL 
)

CREATE TABLE User_mobile_numbers
(
mobile_number VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES Users  
PRIMARY KEY(mobile_number,username)
);

CREATE TABLE User_Addresses
(
address VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES Users 
);

CREATE TABLE Customer 
(
username VARCHAR(20) PRIMARY KEY FOREIGN KEY REFERENCES Users ,
points int DEFAULT 0
);

CREATE TABLE Admins
(
username VARCHAR(20) PRIMARY KEY FOREIGN KEY REFERENCES Users
);

CREATE TABLE Vendor
(
username VARCHAR(20) PRIMARY KEY FOREIGN KEY REFERENCES Users ,
activated BIT DEFAULT 0,
company_name VARCHAR(20),
bank_acc_no VARCHAR(20),
admin_username VARCHAR(20) FOREIGN KEY REFERENCES admins(username)
);

CREATE TABLE Delivery_Person
(
is_activated BIT ,
username VARCHAR(20) PRIMARY KEY FOREIGN KEY REFERENCES Users 
);

CREATE TABLE Credit_Card
(
number VARCHAR(20) PRIMARY KEY,
expiry_date DATE ,
cvv_code VARCHAR(20)
)

CREATE TABLE Delivery
(
id int IDENTITY PRIMARY KEY,
type varchar(20),
time_duration INT,
fees INT,
username VARCHAR(20) FOREIGN KEY REFERENCES Users  
);

CREATE TABLE Giftcard
(
code varchar(10) PRIMARY KEY ,
expiry_date datetime,
amount int,
username varchar(20) FOREIGN KEY REFERENCES Users
)
CREATE TABLE Orders
(
order_no INT IDENTITY PRIMARY KEY,
order_date datetime,
total_amount decimal(10,2) NOT NULL ,
cash_amount decimal(10,2),
credit_amount decimal(10,2),
payment_type varchar(20),
order_status varchar(20) DEFAULT 'not processed',
remaining_days int,
time_limit int,
Gift_Card_code_used varchar(10) FOREIGN KEY REFERENCES Giftcard ,
customer_name varchar(20) FOREIGN KEY REFERENCES customer(username),
delivery_id int FOREIGN KEY REFERENCES Delivery(id),
creditCard_number varchar(20) FOREIGN KEY REFERENCES Credit_Card 
)

CREATE TABLE Product
(
serial_no INT IDENTITY PRIMARY KEY ,
product_name varchar(20),
category varchar(20), 
product_description text ,
price decimal(10,2),
final_price decimal(10,2), 
color varchar(20),
avaliable bit DEFAULT 1,
rate int default 0,
vendor_username VARCHAR(20) FOREIGN KEY REFERENCES	vendor(username) ,
customer_username VARCHAR(20) FOREIGN KEY REFERENCES customer(username),
customer_order_id INT FOREIGN KEY REFERENCES Orders(order_no) ,
)

CREATE TABLE CustomerAddstoCartProduct
(
serial_no int FOREIGN KEY REFERENCES PRODUCT,
customer_name varchar(20) FOREIGN KEY REFERENCES Customer(username) ,
PRIMARY KEY(serial_no,customer_name)
)

CREATE TABLE Todays_Deals
(
deal_id int IDENTITY PRIMARY KEY ,
deal_amount int NOT NULL,
admin_username varchar(20) FOREIGN KEY REFERENCES ADMINs(username),
expiry_date dateTIME,
)

CREATE TABLE Todays_Deals_Product 
(
deal_id INT FOREIGN KEY REFERENCES Todays_Deals,
serial_no INT FOREIGN KEY REFERENCES Product,
PRIMARY KEY (deal_id,serial_no)
)

CREATE TABLE offer 
(
offer_id int IDENTITY PRIMARY KEY,
offer_amount int NOT NULL,
expiry_date dateTIME
)

CREATE TABLE offerOnProduct
(
offer_id int FOREIGN KEY REFERENCES offer ,
serial_no int FOREIGN KEY REFERENCES Product ,
Primary KEY(offer_id,serial_no)
)

CREATE TABLE Customer_Question_Product
(
serial_no INT FOREIGN KEY REFERENCES Product ,
customer_name varchar(20) FOREIGN KEY REFERENCES Customer(username),
question text,
answer text,
PRIMARY KEY(serial_no,customer_name)
)

CREATE TABLE Wishlist
(
username varchar(20) FOREIGN KEY REFERENCES CUSTOMER,
name varchar(20) NOT NULL ,
PRIMARY KEY (username,name)
)



CREATE TABLE Wishlist_Product
(
username varchar(20) ,
wish_name varchar(20) ,
serial_no int FOREIGN KEY REFERENCES product ,
FOREIGN KEY (username,wish_name) REFERENCES Wishlist,
PRIMARY KEY(username,wish_name,serial_no)
)

CREATE TABLE Admin_Customer_Giftcard
(
code varchar(10) FOREIGN KEY REFERENCES Giftcard,
customer_name varchar(20) FOREIGN KEY REFERENCES Customer(username) ,
admin_username varchar(20) FOREIGN KEY REFERENCES Admins(username),
remaining_points int,
PRIMARY KEY(code,customer_name,admin_username)
)

CREATE TABLE Admin_Delivery_Order 
(
delivery_username varchar(20) Foreign key REFERENCES DELIVERY_PERSON,
order_no INT REFERENCES ORDERs,
admin_username varchar(20) Foreign key REFERENCES ADMINS,
delivery_window varchar(20) 
)
CREATE TABLE Customer_CreditCard
(
customer_name varchar(20) Foreign key references customer(username),
cc_num varchar(20) Foreign key references Credit_card(number),
Primary key(customer_name,cc_num)
)
GO
CREATE PROC customerRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
INSERT INTO Users VALUES(@username,@password,@first_name,@last_name,@email)
INSERT INTO Customer (username) VALUES(@username)

go
CREATE PROC vendorRegister 
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),
@company_name VARCHAR(20),
@bank_acc_no VARCHAR(20)
AS
Insert into Users VALUES(@username,@password,@first_name,@last_name,@email)
INSERT INTO Vendor (username,company_name,bank_acc_no) VALUES(@username,@company_name,@bank_acc_no)


go
CREATE PROC userLogin
@username VARCHAR(20),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS
if EXISTS(SELECT C.* FROM Customer C INNER JOIN Users U ON C.username=U.username WHERE @username=C.username AND @password=U.password)
BEGIN
SET @success=1
SET @type=0
END
ELSE if EXISTS(SELECT A.* FROM Admins A INNER JOIN Users U ON A.username=U.username WHERE @username=A.username AND @password=u.password)
BEGIN 
SET @success=1
SET @type=2
END 
ELSE IF EXISTS(SELECT V.* FROM Vendor V INNER JOIN Users U ON V.username=U.username WHERE @username=V.username AND @password=u.password)
BEGIN 
SET @success=1
SET @type=1
END 
ELSE IF EXISTS(SELECT D.* FROM Delivery_Person D INNER JOIN Users U ON D.username=U.username WHERE @username=D.username AND @password=u.password)
BEGIN 
SET @success=1
SET @type=3
END
ELSE 
SET @success=0





GO 
CREATE PROC addMobile 
@username varchar(20),
@mobile_number varchar(20)
AS
INSERT INTO User_mobile_numbers VALUES(@mobile_number,@username)

GO 
CREATE PROC addAddress
@username VARCHAR(20),
@address VARCHAR(100)
AS
INSERT INTO User_Addresses VALUES(@address,@username)

GO 
CREATE PROC showProducts
AS
SELECT product_name,category,product_description,price,final_price,color FROM Product WHERE avaliable=1
GO 
CREATE PROC ShowProductsbyPrice
AS
SELECT  serial_no,product_name,category,price,final_price,product_description,color FROM PRODUCT WHERE avaliable=1 ORDER BY price 

GO 
CREATE PROC searchbyname
@text VARCHAR(30)
AS
SELECT product_name,category,product_description,final_price,color,vendor_username FROM PRODUCT WHERE avaliable=1 AND product_name LIKE '%'+@text+'%'     
go 
CREATE PROC AddQuestion
@serial int,
@customer varchar(20),
@Question varchar(50)
AS
INSERT INTO Customer_Question_Product (serial_no,customer_name,question) VALUES(@serial,@customer,@Question)
go
CREATE PROC addToCart
@customername varchar(20),
@serial int
AS
if EXISTS(SELECT P.* FROM Product P WHERE P.serial_no=@serial AND P.avaliable=1) 
INSERT INTO CustomerAddstoCartProduct VALUES(@serial,@customername)


go
CREATE PROC removefromCart
@customername varchar(20),
@serial int
AS
DELETE FROM CustomerAddstoCartProduct WHERE @customername=customer_name AND @serial=serial_no

go
CREATE PROC createWishlist
@customername VARCHAR(20),
@name VARCHAR(20)
AS
INSERT INTO Wishlist VALUES(@customername,@name)

GO 
CREATE PROC AddtoWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int
AS
INSERT INTO Wishlist_Product VALUES(@customername,@wishlistname,@serial)

GO
CREATE PROC removefromWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int
AS
DELETE FROM Wishlist_Product WHERE @customername=username AND @wishlistname=wish_name AND @serial=serial_no

GO
CREATE PROC showWishlistProduct
@customername varchar(20),
@name varchar(20)
AS
SELECT P.product_name,P.category,P.product_description,P.price,P.final_price,P.color FROM Product P INNER JOIN Wishlist_Product W ON P.serial_no=W.serial_no WHERE W.username=@customername AND @name=W.wish_name

go
CREATE PROC viewMyCart 
@customer varchar(20)
AS
SELECT P.serial_no,product_name,P.category,P.product_description,p.price,P.final_price,P.color FROM Product P INNER JOIN CustomerAddstoCartProduct C ON P.serial_no=C.serial_no WHERE c.customer_name=@customer
go
CREATE PROC vewMyCart 
@customer varchar(20)
AS
SELECT P.product_name,P.category,P.product_description,p.price,P.final_price,P.color FROM Product P INNER JOIN CustomerAddstoCartProduct C ON P.serial_no=C.serial_no WHERE c.customer_name=@customer
GO
CREATE PROC calculatepriceOrder
@customername varchar(20),
@sum decimal(10,2) OUTPUT
AS
SELECT @sum =SUM(P.final_price) FROM CustomerAddstoCartProduct C INNER JOIN PRODUCT P ON C.serial_no=P.serial_no  WHERE C.customer_name=@customername
GO
CREATE PROC emptyCart 
@customername varchar(20)
AS
DELETE FROM CustomerAddstoCartProduct  WHERE customer_name=@customername
GO

GO
create proc productsinorder
@customername varchar(20),
@orderID int
AS
UPDATE Product 
set avaliable=0,customer_order_id=@orderID,customer_username=@customername
WHERE
serial_no IN (SELECT serial_no FROM CustomerAddstoCartProduct WHERE customer_name=@customername)
DELETE FROM CustomerAddstoCartProduct WHERE serial_no IN (SELECT serial_no FROM Product WHERE customer_order_id=@orderid)
SELECT P.serial_no,P.product_name,P.category,P.product_description,P.final_price,P.color,P.vendor_username FROM Product P WHERE customer_order_id=@orderID
go
CREATE PROC makeOrder
@customername varchar(20)
AS
declare @target int
declare @price decimal(10,2)
EXEC calculatepriceOrder @customername,@price OUTPUT
insert into Orders (customer_name,total_amount,order_date) VALUES (@customername,@price,CURRENT_TIMESTAMP)
SELECT @target=MAX(order_no) FROM Orders
execute productsinorder @customername,@target
EXECUTE emptyCart @customername



go
create proc cancelOrder 
@orderid int
AS
DECLARE @point int
declare @price int
declare @credit decimal(10,2)
declare @cash decimal(10,2)
declare @giftcard varchar(20)
declare @date datetime
declare @username varchar(20)

SELECT @giftcard=Gift_Card_code_used,@username=customer_name FROM Orders where order_no=@orderid
SET @point=0
SELECT @price=total_amount,@credit=credit_amount,@cash=cash_amount FROM Orders WHERE order_no=@orderid
SELECT @date=expiry_date FROM Giftcard where code=@giftcard
IF EXISTS(SELECT O.* FROM Orders O WHERE order_no=@orderid AND (order_status='not processed' OR order_status='in process'))
begin
IF ( @giftcard is NOT NULL AND CURRENT_TIMESTAMP<=@date )
BEGIN 
IF(@credit IS NULL)
BEGIN
IF(@cash is null)
SET @point=@price
ELSE
SET @point=@price-@cash
end
ELSE
BEGIN
Set @point=@price-@credit
END
UPDATE Customer SET points=@point+points WHERE username=@username
update Admin_Customer_Giftcard SET remaining_points=remaining_points+@point WHERE code=@giftcard
end
UPDATE Product 
SET customer_username=NULL,customer_order_id=NULL,avaliable=1
WHERE customer_order_id=@orderid

DELETE FROM Orders WHERE order_no=@orderid

end
GO
CREATE PROC returnProduct
@serialno INT,
@orderid INT
AS
declare @productprice decimal(10,2)
declare @orderprice decimal(10,2)
declare @giftcard VARCHAR(10)
declare @date datetime
declare @credit decimal(10,2)
declare @cash decimal(10,2)
DECLARE @point INT
DECLARE @customer varchar(20)
SET @point=0
SELECT @credit=credit_amount,@cash=cash_amount FROM Orders where order_no=@orderid
SELECT @productprice=final_price FROM Product WHERE serial_no=@serialno
SELECT @orderprice=total_amount,@giftcard=Gift_Card_code_used  FROM Orders where order_no=@orderid
SELECT @date=expiry_date FROM Giftcard where code=@giftcard
IF ( @giftcard is NOT NULL AND CURRENT_TIMESTAMP<=@date )
BEGIN 
IF(@credit IS NULL)
BEGIN
IF(@cash is null)
SET @point=@productprice
ELSE
BEGIN
SET @orderprice=@orderprice-@cash
SET @point=@orderprice
END
END
ELSE
BEGIN
SET @orderprice=@orderprice-@credit
SET @point=@orderprice
end
END
SELECT @customer=customer_name FROM Orders where order_no=@orderid
UPDATE Product 
SET customer_order_id=NULL,customer_username=NULL,avaliable=1
WHERE serial_no=@serialno AND @orderid=customer_order_id
update Customer set points=points+@point where username=@customer
update Admin_Customer_Giftcard SET remaining_points=remaining_points+@point WHERE code=@giftcard
update Orders set total_amount=total_amount-@productprice where order_no=@orderid
GO
CREATE PROC ShowproductsIbought
@customername varchar(20)
AS
SELECT P.serial_no,P.product_name,P.category,P.product_description,P.final_price,P.color,P.vendor_username FROM Product P WHERE P.customer_username=@customername

go
CREATE PROC rate 
@serialno INT,
@rate INT,
@customername varchar(20)
AS
UPDATE Product 
SET rate=@rate
WHERE serial_no=@serialno AND customer_username=@customername
go
CREATE PROC SpecifyAmount
@customername varchar(20),
@orderID int,
@cash decimal(10,2),
@credit decimal(10,2)
AS
declare @totalpaid decimal(10,2)
declare @currentpoints INT
declare @totalprice decimal(10,2)
declare @giftcard varchar(10)
SELECT @totalprice=total_amount FROM Orders WHERE @orderID=order_no
SELECT @currentpoints=points FROM Customer WHERE username=@customername
if(@cash IS null)
BEGIN
if(@credit IS null)
BEGIN
UPDATE Customer SET points=@currentpoints-@totalprice where username=@customername
UPDATE Admin_Customer_Giftcard set remaining_points=remaining_points-@totalprice where customer_name=@customername
END
ELSE
BEGIN
SET @totalprice=@totalprice-@credit
update orders set payment_type='credit' where order_no=@orderID
UPDATE Customer SET points=@currentpoints-@totalprice where username=@customername
UPDATE Admin_Customer_Giftcard set remaining_points=remaining_points-@totalprice where customer_name=@customername
End
END
ELSE
BEGIN
SET @totalprice=@totalprice-@cash
update Orders set payment_type='cash' where order_no=@orderID
UPDATE Customer SET points=@currentpoints-@totalprice WHERE username=@customername
UPDATE Admin_Customer_Giftcard set remaining_points=remaining_points-@totalprice WHERE customer_name=@customername
END
if(@totalprice<>0)
SELECT @giftcard=code FROM Admin_Customer_Giftcard WHERE customer_name=@customername
UPDATE Orders 
SET cash_amount=@cash,credit_amount=@credit,Gift_Card_code_used=@giftcard where order_no=@orderID
UPDATE Customer SET points=@currentpoints-@totalprice where username=@customername
go



create proc addcreditcard
@creditcardnumber varchar(20), 
@expirydate date , 
@cvv varchar(4), 
@customername varchar(20)
as
INSERT INTO Credit_Card (number,expiry_date,cvv_code) VALUES(@creditcardnumber,@expirydate,@cvv)
insert into Customer_CreditCard VALUES (@customername,@creditcardnumber)

go
create proc ChooseCreditCard
@creditcard varchar(20),
@orderid int
AS
UPDATE Orders
SET payment_type='credit',creditCard_number= @creditcard FROM Orders where order_no=@orderid

go
create proc viewDeliveryTypes
AS
SELECT * FROM Delivery 
GO
create proc vewDeliveryTypes
AS
SELECT * FROM Delivery 



GO 
CREATE PROC  specifydeliverytype
 @orderID int, 
 @deliveryID int
AS
declare @days int
SELECT @days=time_duration FROM Delivery WHERE id=@deliveryID
UPDATE Orders 
SET delivery_id=@deliveryID ,remaining_days=@days
where order_no=@orderID

go
CREATE PROC trackRemainingDays
 @orderid int,
 @customername varchar(20),
 @days int output
 AS
 DECLARE @date_arrival datetime
 DECLARE @date_of_order datetime
 DECLARE @daysleft int
 SELECT @date_of_order= order_date,@daysleft=remaining_days from Orders WHERE order_no=@orderid
 SET @date_arrival=DATEADD(DAY,@daysleft,@date_of_order)
 set @days=DATEDIFF(day,CURRENT_TIMESTAMP,@date_arrival)
 update Orders SET remaining_days=@days WHERE order_no=@orderid





 go
 CREATE PROC postProduct
 @vendorUsername varchar(20),
 @product_name varchar(20),
 @category varchar(20), 
 @product_description text , 
 @price decimal(10,2), 
 @color varchar(20)
 AS
 IF EXISTS(SELECT vendor.* FROM Vendor WHERE username=@vendorUsername AND activated=1)
 INSERT INTO Product (vendor_username,product_name,category,product_description,price,color,final_price) VALUES(@vendorUsername,@product_name,@category,@product_description,@price,@color,@price)
go

CREATE PROC vendorviewProducts
@vendorUsername varchar(20)
AS
IF EXISTS(SELECT vendor.* FROM Vendor WHERE username=@vendorUsername AND activated=1)
 SELECT P.* FROM Product P WHERE p.vendor_username=@vendorUsername
 GO
CREATE PROC EditProduct
@vendorname varchar(20),
@serialnumber int, 
@product_name varchar(20) ,
@category varchar(20),
@product_description text , 
@price decimal(10,2), 
@color varchar(20)
AS
IF EXISTS(SELECT vendor.* FROM Vendor WHERE username=@vendorname AND activated=1)
UPDATE Product SET product_name=@product_name,category=@category,product_description=@product_description,final_price=@price,color=@color
WHERE vendor_username=@vendorname AND serial_no=@serialnumber


go
Create proc deleteProduct 
@vendorname varchar(20),
@serialnumber INT
AS
IF EXISTS(SELECT vendor.* FROM Vendor WHERE username=@vendorname AND activated=1)
BEGIN 
DELETE FROM Product WHERE vendor_username=@vendorname AND serial_no=@serialnumber AND avaliable=1
DELETE FROM CustomerAddstoCartProduct WHERE serial_no=@serialnumber
END

GO
create proc viewQuestions
@vendorname varchar(20)
AS
SELECt Customer_Question_Product.* FROM Customer_Question_Product INNER JOIN Product P ON Customer_Question_Product.serial_no=p.serial_no WHERE vendor_username=@vendorname


GO
CREATE PROC  answerQuestions 
@vendorname varchar(20), 
@serialno int, 
@customername varchar(20), 
@answer text 
as
 IF EXISTS(SELECT product.* FROM Product WHERE vendor_username=@vendorname AND serial_no=@serialno)
update Customer_Question_Product SET answer=@answer WHERE customer_name=@customername AND serial_no=@serialno

go
create proc addOffer
@offeramount int,
@expiry_date datetime
AS
INSERT INTO offer VALUES(@offeramount,@expiry_date)

GO 
CREATE PROC  checkOfferonProduct
@serial int ,
@activeoffer BIT OUTPUT
AS
IF(EXISTS(SELECT * FROM offerOnProduct WHERE serial_no=@serial))
SET @activeoffer=1
ELSE 
SET @activeoffer=0




go

 
 



 
 go
CREATE PROC checkandremoveExpiredoffer
@offerid int
AS
UPDATE Product SET final_price=price WHERE serial_no IN(SELECT  OP.serial_no  FROM offerOnProduct OP INNER JOIN offer O ON op.offer_id=O.offer_id  WHERE CURRENT_TIMESTAMP>=o.expiry_date and o.offer_id=@offerid)
DELETE FROM offerOnProduct WHERE offer_id IN(SELECT offer_id FROM offer WHERE CURRENT_TIMESTAMP>=expiry_date and offer_id=@offerid)
DELETE FROM offer WHERE CURRENT_TIMESTAMP>=expiry_date AND offer_id=@offerid

go
Create proc applyOffer 
@vendorname varchar(20),
@offerid int,
@serial int
AS
declare @offerprice int
IF(NOT EXISTS(SELECT * FROM offerOnProduct where serial_no=@serial ) AND EXISTS(SELECT * FROM Product WHERE serial_no=@serial AND vendor_username=@vendorname))
BEGIN
SELECT @offerprice=offer_amount FROM offer where offer_id=@offerid
insert into offerOnProduct VALUES(@offerid,@serial)
UPDATE Product SET final_price=price-(@offerprice*0.01*price) WHERE serial_no=@serial
END
ELSE
print('already has an offer')
GO 
create proc activateVendors
@admin_username varchar(20),
@vendor_username varchar(20)
AS
UPDATE Vendor SET activated=1,admin_username=@admin_username WHERE username=@vendor_username

go
create proc inviteDeliveryPerson
@delivery_username varchar(20), 
@delivery_email varchar(50)
AS
INSERT INTO Users (username,email) VALUES(@delivery_username,@delivery_email)
INSERT INTO Delivery_Person VALUES(0,@delivery_username)
go 
create proc reviewOrders
AS
SELECT * from Orders

GO 
CREATE PROC updateOrderStatusInProcess 
@order_no int
AS
UPDATE Orders SET order_status='in process' WHERE order_no=@order_no
go
create proc addDelivery
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
AS
INSert INTO Delivery VALUES (@delivery_type,@time_duration,@fees,@admin_username)

GO
create proc assignOrdertoDelivery
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
INSERT INTO Admin_Delivery_Order (delivery_username,order_no,admin_username) VALUES(@delivery_username,@order_no,@admin_username)
go

create proc createTodaysDeal
@deal_amount int,
@admin_username varchar(20),
@expiry_date datetime
AS
INSERT INTO Todays_Deals VALUES (@deal_amount,@admin_username,@expiry_date)

go
create proc checkTodaysDealOnProduct
@serial_no INT,
@activeDeal Bit OUTPUT
AS
set @activeDeal=0
if(EXISTS(SELECT * FROM Todays_Deals_Product WHERE serial_no=@serial_no))
set @activeDeal=1


go
create proc addTodaysDealOnProduct
@deal_id int, 
@serial_no int
AS
DECLARE @activedeal BIT
DECLARE @dealamount INT
execute checkTodaysDealOnProduct @serial_no,@activedeal OUTPUT
IF(@activedeal=0 and eXISTS(select * from Todays_Deals where deal_id=@deal_id))
BEGIN
INSERT INTO Todays_Deals_Product VALUES(@deal_id,@serial_no)
SELECT @dealamount=deal_amount FROM Todays_Deals WHERE deal_id=@deal_id
UPDATE Product SET final_price= price-(0.01*@dealamount)*price WHERE serial_no=@serial_no
END

go
create proc removeExpiredDeal 
@deal_iD int
AS
declare @time datetime
declare @product INT
SELECT @time=expiry_date FROM Todays_Deals where deal_id=@deal_iD
IF(CURRENT_TIMESTAMP>=@time)
BEGIN
SELECT @product=serial_no FROM Todays_Deals_Product WHERE deal_id=@deal_iD
UPDATE Product SET final_price=price WHERE serial_no=@product
DELETE FROM Todays_Deals_Product WHERE deal_id=@deal_iD
DELETE FROM Todays_Deals WHERE deal_id=@deal_iD
END


go
CREATE PROC createGiftCard
@code varchar(10),
@expiry_date datetime,
@amount int,
@admin_username varchar(20)
AS
INSERT INTO Giftcard VALUES(@code,@expiry_date,@amount,@admin_username)
go
CREATE PROC removeExpiredGiftCard
@code varchar(20)
AS
declare @amount INT
declare @time datetime
declare @customer varchar(20)
SELECT @time=expiry_date,@amount=amount FROM Giftcard WHERE code=@code
SELECT  @customer=customer_name from Admin_Customer_Giftcard WHERE code=@code
IF(@time<=CURRENT_TIMESTAMP)
BEGIN
UPDATE Customer SET points=points-@amount WHERE username=@customer
DELETE FROM Admin_Customer_Giftcard WHERE CODE=@code
DELETE FROM Giftcard WHERE code=@code
END
GO
create proc giveGiftCardtoCustomer
@code varchar(10),
@customer_name varchar(20),
@admin_username varchar(20)
AS
declare @points INT
select @points=amount FROM Giftcard WHERE code=@code
INSERT INTO Admin_Customer_Giftcard VALUES(@code,@customer_name,@admin_username,@points)
UPDATE Customer SET points=points+@points where username=@customer_name



GO
CREATE PROC checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard BIT OUTPUT
AS
IF(EXISTS(SELECT * FROM Admin_Customer_Giftcard WHERE code=@code))
SET @activeGiftCard=1
ELSE
SET @activeGiftCard=0

GO
CREATE PROC acceptAdminInvitation
@delivery_username varchar(20)
as
UPDATE Delivery_Person SET is_activated=1 WHERE username=@delivery_username

go
CREATE PROC deliveryPersonUpdateInfo
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
UPDATE Users SET first_name=@first_name,last_name=@last_name,password=@password,email=@email WHERE username=@username

go
create proc viewmyorders
@deliveryperson varchar(20)
AS
SELECT O.* FROM ORDERs O INNER JOIN Admin_Delivery_Order AD ON O.order_no= AD.order_no WHERE AD.delivery_username=@deliveryperson

go
create proc specifyDeliveryWindow
@delivery_username varchar(20),
@order_no int,
@delivery_window varchar(50)
AS
UPDATE Admin_Delivery_Order SET delivery_window=@delivery_window where order_no=@order_no AND delivery_username=@delivery_username

go
create proc updateOrderStatusOutforDelivery
@order_no int
as
UPDATE Orders SET order_status='Out for delivery' WHERE order_no=@order_no
go

create proc updateOrderStatusDelivered
@order_no int
AS
UPDATE Orders SET order_status='Delivered' WHERE order_no=@order_no

go
create proc showuserorder
@customername varchar(20)
AS
Select order_no,total_amount FROM Orders Where customer_name=@customername


