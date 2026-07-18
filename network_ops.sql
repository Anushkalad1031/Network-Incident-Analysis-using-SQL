/*
=========================================================
Project Name : Network Incident Analysis using SQL
Database     : MySQL
Author       : Anushka Lad

Description:
This project demonstrates SQL analysis on enterprise
network incident data using a star schema. It includes
table creation, joins, aggregations, date analysis,
and business KPI reporting.
=========================================================
*/



/*=========================================
    CREATE DATABASE
=========================================*/

CREATE DATABASE network_ops;
USE network_ops;

/*=========================================
    CREATE TABLES
=========================================*/
CREATE TABLE dim_location (
    location_id   INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL,
    region        VARCHAR(50)  NOT NULL
);
CREATE TABLE dim_severity (
    severity_id   INT AUTO_INCREMENT PRIMARY KEY,
    severity_name VARCHAR(20) NOT NULL,
    severity_rank INT NOT NULL
);
CREATE TABLE dim_device (
    device_id     INT AUTO_INCREMENT PRIMARY KEY,
    device_name   VARCHAR(50) NOT NULL,
    device_type   VARCHAR(30) NOT NULL,
    vendor        VARCHAR(30) NOT NULL,
    location_id   INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id)
);
CREATE TABLE fact_incidents (
    incident_id         INT AUTO_INCREMENT PRIMARY KEY,
    device_id           INT NOT NULL,
    severity_id         INT NOT NULL,
    root_cause          VARCHAR(50) NOT NULL,
    opened_at            DATETIME NOT NULL,
    resolved_at          DATETIME NULL,
    resolution_minutes  INT NULL,
    FOREIGN KEY (device_id) REFERENCES dim_device(device_id),
    FOREIGN KEY (severity_id) REFERENCES dim_severity(severity_id)
);

/*=========================================
    VERIFY DATA
=========================================*/

SHOW TABLES;
SELECT COUNT(*) FROM dim_location;
SELECT COUNT(*) FROM dim_severity;
SELECT COUNT(*) FROM dim_device;
select count(*) from fact_incidents;

/*=========================================
    BASIC ANALYSIS
=========================================*/

/*============= Total Incidents =============*/
SELECT COUNT(*) AS Total_Incidents
FROM fact_incidents;

/*============= Total Devices =================*/
SELECT COUNT(*) AS Total_Devices
FROM dim_device;

/*============= Critical Incidents ==============*/
SELECT COUNT(*) AS Critical_Incidents
FROM fact_incidents f
JOIN dim_severity s
ON f.severity_id=s.severity_id
WHERE s.severity_name='Critical';

/*=============== Vendor Wise Devices ===============*/
SELECT vendor,
COUNT(*) AS Devices
FROM dim_device
GROUP BY vendor
ORDER BY Devices DESC;

/*============== Top 10 Devices with Highest Incidents ===============*/
SELECT
d.device_name,
COUNT(*) AS Total_Incidents
FROM fact_incidents f
JOIN dim_device d
ON f.device_id=d.device_id
GROUP BY d.device_name
ORDER BY Total_Incidents DESC
LIMIT 10;

/*============ Location with Maximum Incidents =============*/

SELECT l.location_name,
COUNT(*) AS Total_Incidents
FROM fact_incidents f
JOIN dim_device d
ON f.device_id=d.device_id
JOIN dim_location l
ON d.location_id=l.location_id
GROUP BY l.location_name
ORDER BY Total_Incidents DESC;

/*============== Top Root Causes =============*/
SELECT
root_cause,
COUNT(*) AS Total
FROM fact_incidents
GROUP BY root_cause
ORDER BY Total DESC;

/*================= SLA Breach (>240 Minutes) ================*/
SELECT
COUNT(*) AS SLA_Breached
FROM fact_incidents
WHERE resolution_minutes>240;

/* ================== slowest resolve event ====================*/
SELECT *
FROM fact_incidents
ORDER BY resolution_minutes DESC
LIMIT 1;

/* ============== Number of incidents every month =================*/
SELECT MONTHNAME(opened_at) AS Month,
COUNT(*) AS Total_Incidents
FROM fact_incidents
GROUP BY MONTH(opened_at), MONTHNAME(opened_at)
ORDER BY MONTH(opened_at);

/* =========== select peak hour time =================*/
SELECT HOUR(opened_at) Hour,
       COUNT(*) Incidents
FROM fact_incidents
GROUP BY Hour
ORDER BY Incidents DESC;

/*=========== Devices Having More Than 10 Incidents ============*/
SELECT device_name,
       COUNT(*) AS Total
FROM fact_incidents f
JOIN dim_device d
ON f.device_id = d.device_id
GROUP BY device_name
HAVING COUNT(*) > 10;

/*============= Rank Devices by Number of Incidents =============*/

SELECT
    d.device_name,
    COUNT(*) AS Total_Incidents,
    DENSE_RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS Device_Rank
FROM fact_incidents f
JOIN dim_device d
    ON f.device_id = d.device_id
GROUP BY d.device_name;
