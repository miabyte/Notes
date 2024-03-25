-- Bikes Last Used

SELECT bike_number, MAX(end_time)
FROM dc_bikeshare_q1_2012
GROUP BY bike_number
ORDER BY MAX(end_time) DESC

-- Admin Department Employees Beginning in April or Later

SELECT COUNT(*) AS Admin
FROM worker
WHERE DEPARTMENT='Admin' AND joining_date >='2014-04-01'

-- Number of Workers by Department Starting in April or Later

SELECT department, COUNT(worker_id) as num_workers
FROM worker
WHERE (joining_date)>='2014-04-01'
GROUP BY department
ORDER BY num_workers DESC

-- Number Of Bathrooms And Bedrooms

SELECT city, property_type, AVG(bathrooms), AVG(bedrooms)
FROM airbnb_search_details
GROUP BY property_type, city

-- Customer Details

SELECT first_name, last_name, city, NVL(order_details,' ')
FROM customers
LEFT JOIN orders
ON [customers.id](http://customers.id/) = orders.cust_id
ORDER BY first_name, order_details

-- Reviews of Hotel Arena

SELECT hotel_name, reviewer_score, COUNT(*)
FROM hotel_reviews
WHERE hotel_name = 'Hotel Arena'
GROUP BY hotel_name, reviewer_score
ORDER BY reviewer_score

-- Count the number of movies that Abigail Breslin nominated for oscar

SELECT COUNT(*)
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin'

-- Unique Users Per Client Per Month

SELECT client_id,
TO_CHAR(TO_DATE(time_id,'YYYY-MM-DD'), 'MM'),
COUNT(DISTINCT user_id)
FROM fact_events
GROUP BY client_id, TO_CHAR(TO_DATE(time_id,'YYYY-MM-DD'), 'MM')
ORDER BY client_id

-- Count the number of user events performed by MacBookPro users

SELECT event_name, COUNT(*) AS event_count
FROM playbook_events
WHERE device = 'macbook pro'
GROUP BY event_name
ORDER BY event_count DESC

-- Order Details

SELECT customers.first_name, order_date, order_details, total_order_cost
FROM orders
JOIN customers ON [customers.id](http://customers.id/) = orders.cust_id
WHERE customers.first_name IN ('Jill','Eva')
ORDER BY cust_id

-- Find the most profitable company in the financial sector of the entire world along with its continent

SELECT company, continent
FROM forbes_global_2010_2014
WHERE sector = 'Financials'
ORDER BY profits DESC
FETCH first ROWS ONLY

-- Average Salaries

SELECT department, first_name, salary, AVG(salary) OVER (PARTITION BY department)
FROM employee

-- Find libraries who haven't provided the email address in circulation year 2016 but their notice preference definition is set to email

SELECT DISTINCT home_library_code
FROM library_usage
WHERE
notice_preference_definition = 'email' AND
provided_email_address = 0 AND
circulation_active_year= 2016

-- Churro Activity Date

SELECT activity_date, pe_description
FROM los_angeles_restaurant_health_inspections
WHERE facility_name = 'STREET CHURROS' AND score <95

-- Find the base pay for Police Captains

SELECT employeename, basepay
FROM sf_public_salaries
WHERE jobtitle LIKE '%CAPTAIN%POLICE%'

-- Salaries Differences

SELECT ABS((SELECT MAX(salary)
FROM db_employee e
WHERE e.department_id = 1)-(SELECT MAX(SALARY) from db_employee e
WHERE e.department_id = 4)) salary_difference
FROM dual

-- Find how many times each artist appeared on the Spotify ranking list

SELECT artist, COUNT(*) as n_occurences
FROM spotify_worldwide_daily_song_ranking
GROUP BY artist
ORDER BY n_occurences DESC

-- Lyft Driver Wages

SELECT "index", start_date,
CASE WHEN end_date IS NULL
THEN ' '
ELSE end_date
END AS end_date, yearly_salary
FROM lyft_drivers
WHERE yearly_salary NOT BETWEEN 30000 AND 70000

-- Finding Updated Records

SELECT id, first_name, last_name, department_id, MAX(salary)
FROM ms_employee_salary
GROUP BY id, first_name, last_name, department_id
ORDER BY id ASC

-- Popularity of Hack

SELECT e.location, AVG(s.popularity) AS avg_popularity
FROM facebook_employees e
JOIN facebook_hack_survey s ON [e.id](http://e.id/) = s.employee_id
GROUP BY e.location

-- Number of Shipments Per Month

SELECT DISTINCT TO_CHAR(TO_DATE(shipment_date, 'YYYY-MM-DD'), 'YYYY-MM') AS year_month,
COUNT(*) AS count
FROM amazon_shipment
GROUP BY TO_CHAR(TO_DATE(shipment_date, 'YYYY-MM-DD'), 'YYYY-MM')

-- Most Lucrative Products

SELECT product_id, SUM(cost_in_dollars * units_sold) as revenue
FROM online_orders
GROUP BY product_id
ORDER BY revenue DESC
FETCH FIRST 5 ROWS ONLY

-- Find all posts which were reacted to with a heart

SELECT *
FROM facebook_posts
WHERE post_id IN (
SELECT post_id
FROM facebook_reactions
WHERE reaction = 'heart'
)