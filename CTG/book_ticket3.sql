SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE TRIGGER UpdateTicket 
AFTER UPDATE 
ON Ticket
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Value of Ticket has been updated');
END;
/

CREATE OR REPLACE TRIGGER UpdateTrain
AFTER UPDATE 
ON Train
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Value of Train has been updated');
END;
/

ACCEPT B number PROMPT "No of Seat to Book: ";
ACCEPT Q number PROMPT "Choose Source || 1 for Dhaka || 2 for Khulna || 3 for Chittagong: ";
ACCEPT N number PROMPT "Choose Destination || 1 for Chittagong || 2 for Khulna || 3 for Dhaka: ";

CREATE OR REPLACE PROCEDURE book_ticket
IS

    seat_noo number;
    Sourcee varchar(20);
    Source_noo number;
    Destinationn varchar(20);
    Destination_noo number;

    seller_login_status number := 0;
    previous_passenger number := 0;
    p_id number;
    s_id number;
    st_id number;
    ticket_booked_id number := 1;
    ticket_update_id number := 1;
    passenger_insert_id number := 1;
    max_ticket_cap number := 0;
    least_seat number := 9999;
    current_train_no number;
    final_train_no number;
    train_noo number := 0;
    train_name varchar(20);

    Pnamee varchar(32);
    Genderr varchar(20);
    Agee number;
    nidd varchar(11);
    Passenger_Passwordd varchar(32);
    hold_passenger_info number := 0;

BEGIN

    hold_passenger_info := passenger_logins(Pnamee,Genderr,Agee,nidd,Passenger_Passwordd);

    IF(hold_passenger_info = 1)THEN

    seat_noo := &B;
    Source_noo := &Q;
    Destination_noo := &N;

    FOR R IN (SELECT Seller_active_status FROM seller WHERE Seller_active_status=1) LOOP
        seller_login_status := 1;
    END LOOP;

    IF (seller_login_status = 1) THEN

        Sourcee := choose_source(Source_noo);
        Destinationn := choose_destination(Destination_noo);

        FOR R IN (SELECT * FROM Passenger WHERE Pname=Pnamee AND Gender=Genderr AND Age=Agee AND nid=nidd) LOOP
            previous_passenger := 1;
        END LOOP;
        
        SELECT StID INTO st_id FROM seller WHERE Seller_active_status=1;

        IF (Sourcee = 'Undefined' OR Destinationn = 'Undefined') THEN
            DBMS_OUTPUT.PUT_LINE('Must select proper source and destination');
        ELSIF(Sourcee = Destinationn) THEN
            DBMS_OUTPUT.PUT_LINE('Sourcee cannpt be same as destination');
        ELSE

                FOR R IN (SELECT * FROM Passenger WHERE Pname=Pnamee AND Gender=Genderr AND Age=Agee AND nid=nidd) LOOP
                    p_id := R.PID;
                END LOOP;

                SELECT max(TBid) into ticket_booked_id FROM TicketBooked;
                ticket_booked_id := ticket_booked_id + 1;


                IF (least_seat = 9999) THEN
                    DBMS_OUTPUT.PUT_LINE('Not enough seat left in any train');
                ELSE
                    IF (Sourcee = 'Dhaka') THEN

                        FOR J IN (SELECT * FROM Train@site1 WHERE Source=Sourcee AND Destination=Destinationn) LOOP
                            max_ticket_cap := J.Seat_Left;
                            current_train_no := J.Train_no;
                            IF ((max_ticket_cap<least_seat) AND (max_ticket_cap>seat_noo)) THEN
                                least_seat := max_ticket_cap;
                                final_train_no := current_train_no;
                                train_name := J.Train_Name;
                            END IF;
                        END LOOP;

                        INSERT into TicketBooked@site1 values(ticket_booked_id,seat_noo,final_train_no,p_id);
                        
                        UPDATE Ticket@site1 SET TCap=(Tcap-seat_noo) WHERE Train_no=final_train_no;

                        UPDATE Train@site1 SET Seat_Left=(Seat_Left-seat_noo) WHERE Train_no=final_train_no;

                        DBMS_OUTPUT.PUT_LINE(Pnamee || ' Your seat has been booked on Train ' || train_name);

                    ELSIF (Sourcee = 'Khulna') THEN

                        FOR J IN (SELECT * FROM Train@site2 WHERE Source=Sourcee AND Destination=Destinationn) LOOP
                            max_ticket_cap := J.Seat_Left;
                            current_train_no := J.Train_no;
                            IF ((max_ticket_cap<least_seat) AND (max_ticket_cap>seat_noo)) THEN
                                least_seat := max_ticket_cap;
                                final_train_no := current_train_no;
                                train_name := J.Train_Name;
                            END IF;
                        END LOOP;

                        INSERT into TicketBooked@site2 values(ticket_booked_id,seat_noo,final_train_no,p_id);
                        
                        UPDATE Ticket@site2 SET TCap=(Tcap-seat_noo) WHERE Train_no=final_train_no;

                        UPDATE Train@site2 SET Seat_Left=(Seat_Left-seat_noo) WHERE Train_no=final_train_no;

                        DBMS_OUTPUT.PUT_LINE(Pnamee || ' Your seat has been booked on Train ' || train_name);

                    ELSIF (Sourcee = 'Chittagong') THEN

                        FOR J IN (SELECT * FROM Train WHERE Source=Sourcee AND Destination=Destinationn) LOOP
                            max_ticket_cap := J.Seat_Left;
                            current_train_no := J.Train_no;
                            IF ((max_ticket_cap<least_seat) AND (max_ticket_cap>seat_noo)) THEN
                                least_seat := max_ticket_cap;
                                final_train_no := current_train_no;
                                train_name := J.Train_Name;
                            END IF;
                        END LOOP;

                        INSERT into TicketBooked values(ticket_booked_id,seat_noo,final_train_no,p_id);
                        
                        UPDATE Ticket SET TCap=(Tcap-seat_noo) WHERE Train_no=final_train_no;

                        UPDATE Train SET Seat_Left=(Seat_Left-seat_noo) WHERE Train_no=final_train_no;

                        DBMS_OUTPUT.PUT_LINE(Pnamee || ' Your seat has been booked on Train ' || train_name);

                    END IF;
                END IF;
        END IF;

        
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('You do not have permission to conduct this operation');
    END IF;

    ELSE
        DBMS_OUTPUT.PUT_LINE('You must login first to book a ticket');
    END IF;

END;
/