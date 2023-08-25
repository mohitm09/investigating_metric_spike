use jobdata;

select * from job_data;

#1
SELECT 
    ds,
    ROUND((COUNT(job_id) * 3600) / SUM(time_spent)) AS `number of jobs reviewed per hour per day`
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds;


#2
SELECT 
    COUNT(job_id) / SUM(time_spent) AS `7 day rolling average of throughput`
FROM
    job_data;
    
SELECT 
	ds,
    COUNT(job_id) / SUM(time_spent) AS `Daily rolling average of throughput`
FROM
    job_data
GROUP BY
	ds;
    

#3
SELECT 
    language,
    COUNT(language)/total*100 as `percentage share of language`
FROM
    (SELECT 
        job_id, actor_id, language, COUNT(language) over() AS total
    FROM
        job_data) AS a
GROUP BY language;


#4
SELECT 
    job_id, COUNT(job_id) AS duplicates
FROM
    job_data
GROUP BY job_id
HAVING COUNT(job_id) > 1;