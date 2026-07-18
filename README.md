# Network-Incident-Analysis-using-SQL
Enterprise Network Incident Analysis using MySQL and SQL
# 📊 Network Incident Analysis using SQL

## 📌 Project Overview

This project demonstrates SQL analysis on enterprise network incident data using a **Star Schema** database design. The objective is to analyze network incidents, identify trends, and generate meaningful business insights using SQL.

The project includes database creation, table relationships, and analytical queries covering aggregations, joins, filtering, grouping, date analysis, and window functions.

---

## 🛠️ Technologies Used

- MySQL
- MySQL Workbench
- SQL

---

## 📂 Database Schema

The project consists of one fact table and three dimension tables.

### Fact Table
- **fact_incidents**
  - incident_id
  - device_id
  - severity_id
  - root_cause
  - opened_at
  - resolved_at
  - resolution_minutes

### Dimension Tables

#### dim_device
- device_id
- device_name
- device_type
- vendor
- location_id

#### dim_location
- location_id
- location_name
- region

#### dim_severity
- severity_id
- severity_name
- severity_rank

---

## ⭐ Database Design

This project follows a **Star Schema**:

```
                   dim_location
                        |
                        |
                   dim_device
                        |
                        |
fact_incidents ----- dim_severity
```

---

## 📈 Business Questions Solved

The project answers the following business questions:

- Total number of incidents
- Total number of devices
- Number of critical incidents
- Vendor-wise device distribution
- Top 10 devices with the highest incidents
- Location with the maximum incidents
- Most common root causes
- Number of SLA breaches
- Slowest resolved incident
- Monthly incident trend
- Peak incident hour
- Devices with more than 10 incidents
- Device ranking using DENSE_RANK()

---

## 📚 SQL Concepts Used

- Database Creation
- Table Creation
- Primary Keys
- Foreign Keys
- INNER JOIN
- Aggregate Functions
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- Date Functions
- Window Functions (DENSE_RANK)

---

## 📁 Project Structure

```
Network-Incident-Analysis/
│
├── README.md
├── network_ops.sql
├── fact_incidents.csv
├── dim_device.csv
├── dim_location.csv
└── dim_severity.csv
```

---

## 🚀 How to Run the Project

1. Clone this repository.
2. Open MySQL Workbench.
3. Run the `network_ops.sql` script.
4. Import the CSV files into their respective tables.
5. Execute the analysis queries.

---

## 📌 Sample Analysis

Some of the insights generated include:

- Identifying the devices generating the highest number of incidents.
- Finding locations with the most network issues.
- Analyzing monthly incident trends.
- Detecting peak hours for incident creation.
- Monitoring SLA breaches.
- Ranking devices based on incident frequency.

---

## 🎯 Future Enhancements

- Build an interactive Power BI dashboard.
- Add advanced SQL queries using CTEs and Subqueries.
- Create stored procedures and views.
- Automate reporting.

---

## 👩‍💻 Author
Anushka Lad

