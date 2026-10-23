# Big Billion Days – SQL Sales Analysis

## 1. Project Overview

This project analyzes Big Billion Days sales data using SQL, spreadsheet cleaning, data validation, and dashboard planning. The objective is to identify sales trends, evaluate product performance, understand regional revenue, and compare sales representatives' performance against their targets.

## 2. Tools Used

- **SQL Compiler:** SQLite Online
- **SQL Dialect:** SQLite
- **Spreadsheet Tool:** Microsoft Excel
- **Dashboard Tool:** Tableau Public (dashboard specification prepared; interactive dashboard not published)

## 3. Key Findings

1. **Completed orders:** 63 completed orders generated total recorded revenue of 346,200.
2. **Missing amounts:** Three orders have missing amount values and require validation before their financial values can be used.
3. **Product performance:** Air Fryer generated the highest completed-order revenue at 104,000, followed by Smart Watch at 67,500 and Wireless Earbuds at 60,800.

These findings are based on the SQL query outputs and completed-order analysis.

## 4. Project Structure and File Index

### Part A – SQL Analysis
- `sql/00_schema_and_seed.sql` — Creates and populates the database tables.
- `sql/q01.sql` to `sql/q13.sql` — Contains the 13 analytical SQL queries.
- `results/query_results.md` — Records query outputs, row counts, and seed checks.

### Part B – Spreadsheet Cleaning and Validation
- `data/orders_enriched.csv` — Order-level data enriched with customer, representative, and product information.
- `data/orders_clean.csv` — Cleaned dataset containing completed orders.
- `docs/spreadsheet_notes.md` — Documents formulas, cleaning steps, validation, pivot tables, and reconciliation.

### Part C – Dashboard Specification
- `docs/dashboard_spec.md` — Documents the planned KPIs, charts, data tables, insights, and recommendations. The specification is prepared in this repository; an interactive Tableau Public dashboard has not been published.

### Part D – AI Output Verification
- `sql/d1_corrected.sql` — Corrected SQL for the D1 validation task.
- `docs/ai_log.md` — Documents AI prompts, identified defects, corrections, verification, and human review.

## 5. Important Results

- Completed orders: **63**
- Total recorded revenue from completed orders: **346,200**
- Enriched order records: **90**
- Orders with missing amounts: **3**

## 6. Assumptions and Data Handling

- Revenue calculations use the recorded order amounts for completed orders.
- Orders with missing amounts are flagged for validation and are not assigned invented values.
- Product contribution tiers and sales representative performance are classified using the thresholds defined in the relevant SQL queries.
- Spreadsheet cleaning standardizes customer names and enriches orders using product lookup data.
- SQL results and spreadsheet totals should be reconciled before drawing final business conclusions.

## 7. Query Results

See `results/query_results.md` for the recorded outputs of queries q01–q13 and the seed-data validation.

## 8. Submission

This repository contains the project files for Parts A–D. The repository is maintained on the `main` branch.

