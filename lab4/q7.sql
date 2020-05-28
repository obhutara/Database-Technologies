DROP VIEW IF EXISTS allFlights;

-- departure_city_name, destination_city_name, departure_time, departure_day, departure_week, 
-- departure_year,  nr_of_free_seats, current_price_per_seat.

CREATE VIEW allFlights AS 
SELECT 
    airport_from.airport_name AS departure_city_name,
    airport_to.airport_name AS destination_city_name,
    weekly_schedule.departure_time AS departure_time,
    weekly_schedule.day_of_week AS departure_day,
    flight.week_no AS departure_week,
    weekly_schedule.schedule_year AS departure_year,
    calculateFreeSeats(flight.flight_no) AS nr_of_free_seats,
    calculatePrice(flight.flight_no) AS current_price_per_seat

FROM flight 
INNER JOIN weekly_schedule ON flight.schedule_Id = weekly_schedule.schedule_id
INNER JOIN route_t ON weekly_schedule.route_id = route_t.route_id
INNER JOIN airport AS airport_from ON route_t.airport_from = airport_from.airport_code
INNER JOIN airport AS airport_to ON route_t.airport_to = airport_to.airport_code