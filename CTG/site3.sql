clear screen;

DROP TABLE Train;
DROP TABLE Ticket;
DROP TABLE TicketBooked;
DROP TABLE Station;
DROP TABLE Passenger;
DROP TABLE seller;


CREATE TABLE Train(
		Train_id number,
		Train_Name varchar2(20),
 		Source  varchar2(20),
 		Destination  varchar2(20),
 		Arrival_Time varchar2(20),
 		Departure_Time varchar2(20), 
 		Availability_Of_Seat number,
		Seat_Left number,
		Train_no number,
		StID number); 
/*

insert into Train values(1,'Suborno_Express','Dhaka','Khulna','04:00pm','09:00am',300,280,701702,1);
insert into Train values(2,'Godhuli_Express','Dhaka','Khulna','02:00pm','08:00am',300,290,703704,1);
insert into Train values(3,'Ekota_Express','Dhaka','Khulna','04:00pm','08:30am',300,300,705706,1);

insert into Train values(4,'Kapotaksha_Express','Khulna','Dhaka','11:30am','07:00am',300,280,715716,2);
insert into Train values(5,'Jayantika_Express','Khulna','Dhaka','02:20pm','04:00am',300,290,717718,2);
insert into Train values(6,'Paharika_Express','Khulna','Dhaka','04:00am','01:00am',300,300,719720,2);
*/

insert into Train values(1,'ARB_Express','Ctg','Dhaka','04:00pm','09:00am',300,280,701712,1);
insert into Train values(2,'Shizan_Express','Ctg','Khulna','02:00pm','08:00am',300,290,703714,1);
insert into Train values(3,'ARB_Express_2','Ctg','Dhaka','04:00pm','09:00am',300,280,711712,1);
insert into Train values(4,'Shizan_Express_2','Ctg','Khulna','02:00pm','08:00am',300,290,713714,1);




-- Tcap decrement hobe jokhon seller ticket bikri korbe, 0 hoye gele not available

CREATE TABLE Ticket(TID number, TCap number , Train_no number); 

insert into Ticket values(1,280,801702);
insert into Ticket values(2,290,803704);
insert into Ticket values(3,280,811712);
insert into Ticket values(4,290,813714);


CREATE TABLE TicketBooked(TBid number, TAmount number, Train_no number, PID number);

insert into TicketBooked values(1,5,801702,301);
/*
insert into TicketBooked values(1,5,701702,1);
insert into TicketBooked values(2,10,707708,2);
*/

CREATE TABLE Station(StID number, Station_Name varchar2(20)); 
insert into Station values(3,'Stastion 3');

-- seller passenger add korbe
CREATE TABLE Passenger(PID number, Pname varchar2(20), Gender varchar2(10), Age number , nid varchar2(11), Passenger_Password varchar2(32), StID number, Passenger_active_status number);

insert into Passenger values(301,'Passenger 11','Male', 23, '81234567', '123456',3,0);
insert into Passenger values(302,'Passenger 12','Female', 25, '81234568', '126456',3,0);

/*
insert into Passenger values(3,'Passenger 3','Male', 22, '81234569', '123476',1,0);
insert into Passenger values(4,'Passenger 4','Female', 21, '81234561', '123456',1,0);
insert into Passenger values(5,'Passenger 5','Male', 20, '81234562', '123406',2,0);
insert into Passenger values(6,'Passenger 6','Female', 21, '81234563', '133456',2,0);
insert into Passenger values(7,'Passenger 7','Male', 22, '81234564', '120426',2,0);
insert into Passenger values(8,'Passenger 8','Female', 24, '81234565', '123116',2,0);
*/
CREATE TABLE seller (SID number ,Seller_name varchar2(20),  StID number, Seller_Password varchar2(32), Seller_active_status number);

insert into seller values(1,'Seller 11',3, '789', 0);
insert into seller values(2,'Seller 12',3, '789', 0);
insert into seller values(3,'Seller 13',3, '100956', 0);
insert into seller values(4,'Seller 14',3, '134156', 0);


SELECT * FROM Train;

SELECT * FROM Ticket;

SELECT * FROM TicketBooked;

SELECT * FROM Station;

SELECT * FROM Passenger;

SELECT * FROM seller;

commit;