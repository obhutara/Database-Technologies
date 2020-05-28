DROP PROCEDURE IF EXISTS addYear;
DROP PROCEDURE IF EXISTS addDay;
DROP PROCEDURE IF EXISTS addDestination;
DROP PROCEDURE IF EXISTS addRoute;
DROP PROCEDURE IF EXISTS addFlight;

DELIMITER //
 
CREATE PROCEDURE addYear(IN year_no int, IN profitfactor float)
BEGIN
    INSERT INTO year_pricing(year_no, profitfactor) VALUES (year_no,  profitfactor);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addDay(IN year_no int, IN day_of_week varchar(10),IN weekday_factor float)
BEGIN
    INSERT INTO day_week(year_no, weekday_factor,day_of_week) VALUES (year_no,  weekday_factor,day_of_week);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addDestination(IN airport_code varchar(3), IN airport_name varchar(30),IN country varchar(30))
BEGIN
    INSERT INTO airport(airport_code, airport_name,country) VALUES (airport_code, airport_name,country);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE addRoute(IN airport_from varchar(3), IN airport_to varchar(3), IN route_year int, IN route_price float)
BEGIN
    INSERT INTO route_t(airport_from, airport_to,route_year,route_price) VALUES (airport_from, airport_to,route_year,route_price);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE addFlight(IN DestinationFrom varchar(3), IN DestinationTO varchar(3), IN schedule_year int, day_of_week varchar(20), IN departure_time time)
BEGIN
    DECLARE Prev_ID INT;
    DECLARE current_routeID INT;
    DECLARE current_week INT DEFAULT 1;

    SELECT route_id INTO current_routeID 
	FROM route_t
	WHERE route_year=schedule_year AND DestinationTO=airport_to AND DestinationFrom=airport_from;

    INSERT INTO weekly_schedule(route_id, schedule_year, departure_time, day_of_week) VALUES (current_routeID, schedule_year,departure_time,day_of_week);
    
    SET Prev_ID = LAST_INSERT_ID(); 
	WHILE current_week <= 52 DO
        INSERT INTO flight(week_no, schedule_id) VALUES (current_week, Prev_ID);
	    SET current_week = current_week + 1;
	END WHILE;

END //
DELIMITER ;
