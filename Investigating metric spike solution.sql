use investigating_metric_spike;
select * from users;
select * from email_events;

#1.
SELECT 
    EXTRACT(WEEK FROM occurred_at) AS week_no,
    COUNT(DISTINCT user_id) AS `weekly user engagement`
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY 1; 


#2
select month_no, users_registered, users_registered-lag(users_registered) over() as `growth in terms of users` from(
SELECT 
    EXTRACT(MONTH FROM activated_at) AS month_no,
    COUNT(activated_at) AS users_registered
FROM
    users
WHERE
	activated_at <> ""
GROUP BY 1) as a;


#3



#4
SELECT 
    EXTRACT(WEEK FROM occurred_at) AS week_no,
    device,
    COUNT(*) AS `weekly engagement per device`
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY 1 , 2
ORDER BY 1;


#5
SELECT DISTINCT
    action
FROM
    email_events;
SELECT 
    week_no, 
    action, occur, 
    ROUND(occur * 100 / SUM(occur) over(partition by week_no), 2) as `Percentage`
FROM
    (SELECT 
        EXTRACT(WEEK FROM occurred_at) AS week_no,
            action,
            COUNT(user_id) AS occur
    FROM
        email_events
    GROUP BY 1 , 2
    ORDER BY 1) AS a;