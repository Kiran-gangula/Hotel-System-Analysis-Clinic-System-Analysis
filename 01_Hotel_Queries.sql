-- Q1 Last booked room
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking
    FROM bookings
    GROUP BY user_id
) x
ON b.user_id = x.user_id 
AND b.booking_date = x.last_booking;

-- Q2 Billing Nov 2021
SELECT bc.booking_id,
SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11
AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

-- Q3 Bills >1000 Oct 2021
SELECT bc.bill_id,
SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10
AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4 Most & Least ordered items
WITH item_stats AS (
  SELECT DATE_FORMAT(bill_date,'%Y-%m') AS month,
         item_id,
         SUM(item_quantity) qty
  FROM booking_commercials
  WHERE YEAR(bill_date)=2021
  GROUP BY month,item_id
),
r AS (
  SELECT *,
  RANK() OVER(PARTITION BY month ORDER BY qty DESC) max_r,
  RANK() OVER(PARTITION BY month ORDER BY qty ASC) min_r
  FROM item_stats
)
SELECT * FROM r WHERE max_r=1 OR min_r=1;

-- Q5 Second highest bill
WITH bills AS (
  SELECT b.user_id,
         DATE_FORMAT(bc.bill_date,'%Y-%m') month,
         SUM(bc.item_quantity*i.item_rate) total
  FROM booking_commercials bc
  JOIN bookings b ON bc.booking_id=b.booking_id
  JOIN items i ON bc.item_id=i.item_id
  WHERE YEAR(bc.bill_date)=2021
  GROUP BY b.user_id,month
),
r AS (
  SELECT *,
  DENSE_RANK() OVER(PARTITION BY month ORDER BY total DESC) rnk
  FROM bills
)
SELECT * FROM r WHERE rnk=2;