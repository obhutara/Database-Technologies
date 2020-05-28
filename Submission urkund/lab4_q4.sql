DROP FUNCTION IF EXISTS calculateFreeSeats;
DROP FUNCTION IF EXISTS calculatePrice;


DELIMITER //
CREATE FUNCTION calculateFreeSeats ( flight_number INT )
RETURNS INT
BEGIN
    RETURN 40 - (SELECT booked_seats FROM flight WHERE flight_no = flight_number);
END; //

DELIMITER ;


DELIMITER //
CREATE FUNCTION calculatePrice ( flight_number INT )
RETURNS FLOAT
BEGIN

    DECLARE booked_seats int;
    DECLARE weekday_factor float;
    DECLARE route_price float;
    DECLARE profitfactor float;

    -- We get the year, weekday
    SELECT  flight.booked_seats, route_t.route_price, year_pricing.profitfactor, day_week.weekday_factor INTO booked_seats, route_price, profitfactor, weekday_factor
    FROM flight 
    INNER JOIN weekly_schedule ON flight.schedule_id = weekly_schedule.schedule_id
    INNER JOIN route_t ON weekly_schedule.route_id = route_t.route_id
    INNER JOIN year_pricing ON year_pricing.year_no = weekly_schedule.schedule_year
    INNER JOIN day_week ON weekly_schedule.day_of_week = day_week.day_of_week
    
    WHERE flight.flight_no = flight_number;

    RETURN route_price * weekday_factor * ((booked_seats + 1)/40) * profitfactor;
END; //

DELIMITER ;

-- Might need to make a composite key on day_week as there can be prices for different years of the same weekday, e.g. Monday 2011 and Monday 2012
/*INNER JOIN day_week ON weekly_schedule.day_of_week = day_week.day_of_week AND weekly_schedule.schedule_year = year_no*/