# SQL Query Results

**Project:** Big Billion Days – SQL Analysis  
**SQL Compiler:** SQLite Online  
**SQL Dialect:** SQLite

This document records the seed-table validation and the results of queries q01–q13. Query outputs were executed in SQLite Online and recorded from the saved results.

## Seed check

| Table | Expected row count | Recorded row count | Status |
|---|---:|---:|---|
| reps | 4 | 4 | PASS |
| products | 9 | 9 | PASS |
| customers | 24 | 24 | PASS |
| orders | 90 | 90 | PASS |

## q01 — Pending orders

**Rows returned:** 19

| order_id | customer_id | item | amount |
|---:|---:|---|---:|
| 1001 | 10 | Bluetooth Speaker | NULL |
| 1002 | 16 | Smart Watch | 4500 |
| 1004 | 19 | Cotton Kurta | 2800 |
| 1010 | 19 | Wireless Earbuds | NULL |
| 1033 | 18 | Denim Jacket | 2500 |
| 1035 | 5 | Bluetooth Speaker | 2800 |
| 1036 | 22 | Denim Jacket | 5000 |
| 1037 | 3 | Bedsheet Set | 3800 |
| 1042 | 14 | Table Lamp | 1100 |
| 1044 | 10 | Running Shoes | 3600 |
| 1052 | 15 | Smart Watch | 13500 |
| 1057 | 4 | Bluetooth Speaker | 2800 |
| 1058 | 13 | Bedsheet Set | 1900 |
| 1063 | 10 | Air Fryer | 5200 |
| 1064 | 20 | Bluetooth Speaker | NULL |
| 1068 | 23 | Air Fryer | 5200 |
| 1071 | 22 | Air Fryer | 5200 |
| 1075 | 4 | Running Shoes | 3600 |
| 1078 | 3 | Cotton Kurta | 1400 |

## q02 — Orders with missing amounts

**Rows returned:** 3

| order_id | customer_id | item | status |
|---:|---:|---|---|
| 1001 | 10 | Bluetooth Speaker | pending |
| 1010 | 19 | Wireless Earbuds | pending |
| 1064 | 20 | Bluetooth Speaker | pending |

## q03 — Five biggest completed orders

**Rows returned:** 5

| order_id | customer_id | item | amount |
|---:|---:|---|---:|
| 1061 | 16 | Air Fryer | 15600 |
| 1065 | 22 | Air Fryer | 15600 |
| 1069 | 15 | Air Fryer | 15600 |
| 1077 | 3 | Air Fryer | 15600 |
| 1006 | 5 | Smart Watch | 13500 |

## q04 — Target customer segment

**Rows returned:** 8

| customer_id | first_name | last_name | region | age |
|---:|---|---|---|---:|
| 24 | Reena | Kulkarni | West | 25 |
| 8 | Divya | Gupta | West | 26 |
| 17 | Farhan | Shah | North | 27 |
| 1 | aarav | Sharma | North | 28 |
| 16 | Nisha | Mishra | West | 36 |
| 5 | `  Vikram` | `Singh ` | North | 37 |
| 12 | Pooja | Menon | West | 39 |
| 21 | Manoj | Desai | North | 40 |

## q05 — Headline KPIs

**Rows returned:** 1

| total_orders | total_revenue | avg_order_value | min_order_value | max_order_value |
|---:|---:|---:|---:|---:|
| 63 | 346200 | 5495.24 | 1100 | 15600 |

## q06 — Orders by status

**Rows returned:** 3

| status | number_of_orders | total_amount |
|---|---:|---:|
| completed | 63 | 346200 |
| pending | 19 | 64900 |
| disputed | 8 | 73200 |

## q07 — Strong products

**Rows returned:** 4

| item | number_of_orders | revenue |
|---|---:|---:|
| Air Fryer | 9 | 104000 |
| Smart Watch | 9 | 67500 |
| Wireless Earbuds | 11 | 60800 |
| Running Shoes | 8 | 43200 |

## q08 — Customer profile by region

**Rows returned:** 4

| region | number_of_customers | average_age | min_age | max_age |
|---|---:|---:|---:|---:|
| East | 6 | 34 | 29 | 41 |
| North | 6 | 37.5 | 27 | 48 |
| South | 6 | 36.33 | 24 | 52 |
| West | 6 | 28.5 | 22 | 39 |

## q09 — Order-level fact table

**Rows returned:** 90

As the result contains more than 15 rows, the first five rows are shown below. The full enriched dataset is saved in `data/orders_enriched.csv`.

| order_id | order_month | first_name | last_name | region | rep_name | item | quantity | amount | status |
|---:|---|---|---|---|---|---|---:|---:|---|
| 1001 | 2026-09 | MEERA | `  Patil` | South | Kavya Nair | Bluetooth Speaker | 2 | NULL | pending |
| 1002 | 2026-09 | Nisha | Mishra | West | Neha Kulkarni | Smart Watch | 1 | 4500 | pending |
| 1003 | 2026-09 | Lakshmi | Kapoor | South | Kavya Nair | Air Fryer | 2 | 10400 | disputed |
| 1004 | 2026-09 | Gaurav | Yadav | East | Sanjay Roy | Cotton Kurta | 2 | 2800 | pending |
| 1005 | 2026-09 | Tanvi | Thakur | South | Kavya Nair | Table Lamp | 1 | 1100 | completed |

## q10 — Customers who never ordered

**Rows returned:** 4

| customer_id | first_name | last_name | region |
|---:|---|---|---|
| 6 | Ananya | Reddy | South |
| 11 | Imran | Joshi | East |
| 17 | Farhan | Shah | North |
| 24 | Reena | Kulkarni | West |

## q11 — Region and month report

**Rows returned:** 12

| region | order_month | number_of_orders | number_of_customers | total_revenue | average_revenue |
|---|---|---:|---:|---:|---:|
| East | 2026-09 | 2 | 2 | 6400 | 3200.00 |
| East | 2026-10 | 4 | 3 | 12200 | 3050.00 |
| East | 2026-11 | 6 | 5 | 50900 | 8483.33 |
| North | 2026-09 | 8 | 2 | 53500 | 6687.50 |
| North | 2026-10 | 6 | 4 | 41300 | 6883.33 |
| North | 2026-11 | 5 | 4 | 24500 | 4900.00 |
| South | 2026-09 | 5 | 3 | 19800 | 3960.00 |
| South | 2026-10 | 5 | 4 | 19000 | 3800.00 |
| South | 2026-11 | 7 | 4 | 43700 | 6242.86 |
| West | 2026-09 | 4 | 3 | 18600 | 4650.00 |
| West | 2026-10 | 5 | 4 | 20600 | 4120.00 |
| West | 2026-11 | 6 | 3 | 35700 | 5950.00 |

## q12 — Product contribution tiers

**Rows returned:** 9

| item | total_revenue | contribution_tier |
|---|---:|---|
| Air Fryer | 104000 | High |
| Smart Watch | 67500 | High |
| Wireless Earbuds | 60800 | High |
| Running Shoes | 43200 | Medium |
| Denim Jacket | 17500 | Medium |
| Cotton Kurta | 16800 | Medium |
| Bluetooth Speaker | 14000 | Low |
| Bedsheet Set | 11400 | Low |
| Table Lamp | 11000 | Low |

## q13 — Rep performance against target

**Rows returned:** 12

| rep_name | order_month | monthly_target | revenue | performance_tier |
|---|---|---:|---:|---|
| Arjun Mehta | 2026-09 | 40000 | 53500 | Above Target |
| Arjun Mehta | 2026-10 | 40000 | 41300 | On Target |
| Arjun Mehta | 2026-11 | 40000 | 24500 | Below Target |
| Kavya Nair | 2026-09 | 20000 | 19800 | Below Target |
| Kavya Nair | 2026-10 | 20000 | 19000 | Below Target |
| Kavya Nair | 2026-11 | 20000 | 43700 | Above Target |
| Neha Kulkarni | 2026-09 | 20000 | 18600 | Below Target |
| Neha Kulkarni | 2026-10 | 20000 | 20600 | On Target |
| Neha Kulkarni | 2026-11 | 20000 | 35700 | Above Target |
| Sanjay Roy | 2026-09 | 12000 | 6400 | Below Target |
| Sanjay Roy | 2026-10 | 12000 | 12200 | On Target |
| Sanjay Roy | 2026-11 | 12000 | 50900 | Above Target |

## Validation summary

- Seed-table counts: 4 reps, 9 products, 24 customers, and 90 orders.
- Completed orders: 63.
- Total amount for completed orders: 346200.
- Average completed order value: 5495.24.
- Minimum completed order value: 1100.
- Maximum completed order value: 15600.
- Enriched order-level records: 90.
- Orders with missing amounts: 3 (1001, 1010, and 1064).
- The completed-order revenue KPI agrees with the recorded completed-order amount total of 346200.
