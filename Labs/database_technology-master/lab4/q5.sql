DROP TRIGGER IF EXISTS assignTicketNumber;

DROP PROCEDURE IF EXISTS bookPassenger;

DELIMITER //
CREATE TRIGGER assignTicketNumber
AFTER INSERT ON booking 
FOR EACH ROW
BEGIN

    DECLARE numberOfPassengers int DEFAULT 0;
    DECLARE CTR int DEFAULT 0;
    DECLARE flightNumber int DEFAULT 0;

    SELECT COUNT(passport_id) 
    INTO numberOfPassengers 
    FROM reservation_passenger 
    WHERE NEW.reservation_no = reservation_no;

    WHILE CTR < numberOfPassengers DO
        CALL bookPassenger(NEW.reservation_no, NEW.booking_no);
        SET CTR = CTR + 1;
    END WHILE;

    -- We want to update the amount of booked seats for the flight which can differ from the amount of reserved seats for a booking. 
    -- A flight could have a reservation with 10 reserved seats but then only have one person payed for.
    SELECT flight_no INTO flightNumber FROM reservation WHERE reservation_no = NEW.reservation_no; 
    UPDATE flight SET booked_seats = booked_seats + numberOfPassengers WHERE flightNumber = flight_no;

END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE bookPassenger (reservation_nr int, booking_nr int)
BEGIN

    DECLARE passportNumber int DEFAULT 0;

    -- We need to move a single passenger from the reservation-passenger list to the booking-passenger list in order to assign a unique ticket number.
    SELECT passport_id INTO passportNumber
    FROM reservation_passenger 
    WHERE reservation_nr = reservation_no
    LIMIT 1;

    -- If no more passengers exist for this booking it means that all of them have already been moved to booking and assigned a ticket number.
    IF passportNumber = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'All passangers for this booking have already been given a ticket number';
    END IF;

    -- We delete the passenger from reservation_passenger and add them to booking_passenger
    DELETE FROM reservation_passenger 
    WHERE passport_id = passportNumber;

    INSERT INTO booking_passenger VALUES (booking_nr, passportNumber, rand()*(100000 - 100) + 100);

END //
DELIMITER ;

