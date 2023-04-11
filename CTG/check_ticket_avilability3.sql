SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT S char PROMPT "Ticket number to check || 1 for Dhaka || 2 for Khulna || 3 for Chittagong: ";

CREATE OR REPLACE PROCEDURE check_ticket_avilablity(station_status IN number)
IS
    seat_noo number := &S;
    passenger_active_status number := 0;
    
BEGIN
    FOR R IN (SELECT * FROM Passenger WHERE Passenger_active_status=1) LOOP
        passenger_active_status := 1;
    END LOOP;

    IF (passenger_active_status = 1) THEN
        IF(station_status=1)THEN
            FOR R IN (SELECT Train.* FROM Train@site1 INNER JOIN Passenger@site1 ON Passenger.StID=Train.StID WHERE Passenger.Passenger_active_status=1 AND Train.Seat_Left>seat_noo) LOOP
                DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination || ' Seat Left: ' || R.Seat_Left);
            END LOOP;
        ELSIF(station_status=2)THEN
            FOR R IN (SELECT Train.* FROM Train@site2 INNER JOIN Passenger@site2 ON Passenger.StID=Train.StID WHERE Passenger.Passenger_active_status=1 AND Train.Seat_Left>seat_noo) LOOP
                DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination || ' Seat Left: ' || R.Seat_Left);
            END LOOP;
        ELSIF(station_status=3)THEN
            FOR R IN (SELECT Train.* FROM Train INNER JOIN Passenger ON Passenger.StID=Train.StID WHERE Passenger.Passenger_active_status=1 AND Train.Seat_Left>seat_noo) LOOP
                DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination || ' Seat Left: ' || R.Seat_Left);
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('You must select a valid station');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('You must login first');    
    END IF;
END;
/
