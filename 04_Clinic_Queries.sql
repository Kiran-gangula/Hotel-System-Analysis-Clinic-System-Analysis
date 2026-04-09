-- Q1 Revenue per channel
SELECT sales_channel,
SUM(amount) total_revenue
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY sales_channel;

-- Q2 Top 10 customers
SELECT uid,
SUM(amount) total_spent
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Q3 Monthly profit
WITH rev AS (
  SELECT DATE_FORMAT(datetime,'%Y-%m') month,
         SUM(amount) revenue
  FROM clinic_sales
  WHERE YEAR(datetime)=2021
  GROUP BY month
),
exp AS (
  SELECT DATE_FORMAT(datetime,'%Y-%m') month,
         SUM(amount) expense
  FROM expenses
  WHERE YEAR(datetime)=2021
  GROUP BY month
)
SELECT r.month,
       r.revenue,
       e.expense,
       (r.revenue-e.expense) profit,
       CASE WHEN (r.revenue-e.expense)>0 THEN 'Profitable'
            ELSE 'Not Profitable' END status
FROM rev r
JOIN exp e ON r.month=e.month;

-- Q4 Most profitable clinic per city
WITH p AS (
  SELECT c.city, cs.cid,
         SUM(cs.amount)-COALESCE(SUM(e.amount),0) profit
  FROM clinics c
  JOIN clinic_sales cs ON c.cid=cs.cid
  LEFT JOIN expenses e ON c.cid=e.cid
  WHERE DATE_FORMAT(cs.datetime,'%Y-%m')='2021-10'
  GROUP BY c.city,cs.cid
),
r AS (
  SELECT *,
  RANK() OVER(PARTITION BY city ORDER BY profit DESC) rnk
  FROM p
)
SELECT * FROM r WHERE rnk=1;

-- Q5 Second least profitable clinic per state
WITH p AS (
  SELECT c.state, cs.cid,
         SUM(cs.amount)-COALESCE(SUM(e.amount),0) profit
  FROM clinics c
  JOIN clinic_sales cs ON c.cid=cs.cid
  LEFT JOIN expenses e ON c.cid=e.cid
  WHERE DATE_FORMAT(cs.datetime,'%Y-%m')='2021-10'
  GROUP BY c.state,cs.cid
),
r AS (
  SELECT *,
  RANK() OVER(PARTITION BY state ORDER BY profit ASC) rnk
  FROM p
)
SELECT * FROM r WHERE rnk=2;