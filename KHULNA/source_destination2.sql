SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE FUNCTION choose_source(source IN number)
RETURN varchar
IS

source_name varchar(32);

BEGIN

    CASE
        WHEN (source = 1) THEN
            source_name := 'Dhaka';
        WHEN (source = 2) THEN
            source_name := 'Khulna';
        WHEN (source = 3) THEN
            source_name := 'Chittagong';
        ELSE
            source_name := 'Undefined';
    END CASE;

    return source_name;

END;
/


CREATE OR REPLACE FUNCTION choose_destination(destination IN number)
RETURN varchar
IS

destionation_name varchar(32);

BEGIN

    CASE
        WHEN (destination = 1) THEN
            destionation_name := 'Chittagong';
        WHEN (destination = 2) THEN
            destionation_name := 'Khulna';
        WHEN (destination = 3) THEN
            destionation_name := 'Dhaka';
        ELSE
            destionation_name := 'Undefined';
    END CASE;

    return destionation_name;

END;
/

