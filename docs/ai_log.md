# AI Assistance and Verification Log

## 1. Purpose

AI assistance was used to draft SQL queries, identify potential defects, correct spreadsheet lookup formulas, and review dashboard recommendations. AI-generated outputs were treated as drafts and checked against the project schema, source data, assignment requirements, and actual query results.

## 2. Part A — SQL Query Assistance

### Prompt Used for q13

**Role:** Act as a SQL analyst and reviewer.

**Task:** Write a SQL query to evaluate each sales representative's monthly performance against their monthly target.

**Context:** Use the SQLite tables `orders`, `customers`, and `reps`. The `orders` table contains `customer_id`, `order_month`, `status`, and `amount`. The `customers` table contains `customer_id`, `rep_id`, and `region`. The `reps` table contains `rep_id`, `rep_name`, and `monthly_target`.

**Constraints:**
- Include completed orders only.
- Group results by representative and month.
- Compare monthly completed-order revenue with the representative's monthly target.
- Classify performance as `Above Target`, `On Target`, or `Below Target`.
- Use SQLite-compatible syntax.
- Do not use common table expressions (`WITH`) or stored procedures.

**Format:** Return raw SQL with brief inline comments.

### Verification

The q13 query was executed in SQLite Online. Its output contained 12 representative-month combinations: four representatives across September, October, and November 2026. The revenue totals and performance labels were reviewed against the completed-order data.

## 3. Part D1 — Defect Analysis and Correction

The original SQL analysis was reviewed for schema errors, incorrect aggregate filtering, and unsupported statistical claims.

| Defect | Classification | Correction |
|---|---|---|
| Reference to a table that does not exist in the provided schema | Invalid table reference | Use the actual tables in the project schema. |
| Reference to columns that do not exist | Invalid column reference | Use the actual column names, including `customer_id`, `region`, `status`, and `amount`. |
| Aggregate condition placed in `WHERE` | SQL logic/syntax error | Apply aggregate filters with `HAVING` after grouping. |
| Claim of a 38% increase without supporting data | Unsupported statistic | Recalculate the percentage change using the actual monthly revenue values. |

### Corrected D1 SQL

The corrected query in `sql/d1_corrected.sql` calculates completed-order revenue by region and returns regions whose total exceeds 80,000.

```sql
SELECT
    c.region,
    SUM(o.amount) AS total_revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE LOWER(TRIM(o.status)) = 'completed'
GROUP BY c.region
HAVING SUM(o.amount) > 80000
ORDER BY total_revenue DESC;
```

### Actual Verification Results

The corrected query was executed successfully in SQLite Online using the project database.

The query returned exactly two rows:

| Region | Total revenue |
|---|---:|
| North | 119300 |
| South | 82500 |

Both values matched the expected results. The query correctly filtered completed orders, grouped the records by region, applied the revenue threshold, and sorted the results in descending order.

### Human-in-the-Loop Verification Protocol

**1. Specification:** Confirm that the query answers the regional revenue question, uses the correct schema, includes completed orders only, and applies the threshold of 80,000.

**2. Execution:** Run the corrected SQL in SQLite Online using the project's schema and seeded data.

**3. Inspection:** Review the returned region names, revenue values, sorting, and threshold condition.

**4. Verification:** Compare the actual query output with the expected results and recalculate the monthly percentage change using the source figures.

**5. Decision:** Reject the defective original query where it contains invalid references, incorrect aggregate filtering, or unsupported statistics. Accept the corrected query after its execution produces the expected results.

### Monthly Revenue Change Check

North region recorded revenue of 53,500 in September and 41,300 in October.

Percentage change:

\[
\frac{41,300-53,500}{53,500}\times100
\approx -22.8\%
\]

The result indicates a decrease of approximately 22.8%, not an increase of 38%. This demonstrates why numerical claims must be checked against the underlying data.

## 4. Part D2 — Spreadsheet Lookup Defect

### Problem

A product lookup may fail when the lookup key contains an unwanted leading space. For example, cell G2 contains `" Smart Watch"`, while the product table contains `"Smart Watch"`.

### Original Formula

```excel
=XLOOKUP(G2,products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

### Corrected Formula

```excel
=XLOOKUP(TRIM(G2),products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

### Explanation

`TRIM(G2)` removes leading and trailing spaces before the lookup is performed. This helps the cleaned product name match the product table. The fallback text `UNKNOWN_ITEM` identifies a product name that cannot be matched.

### Verification Procedure

1. Test the formula with the product name `" Smart Watch"`.
2. Confirm that the lookup returns the matching product price.
3. Test the formula with a genuinely unknown product name.
4. Confirm that the formula returns `UNKNOWN_ITEM` when no match exists.

The formula is designed to correct the leading-space issue. The test outcomes should only be reported as completed after the formulas have been checked in the spreadsheet.

## 5. Part C — Skeptical Review of a Dashboard Recommendation

### Recommendation Under Review

Prioritize Air Fryer promotions because Air Fryer generated the highest completed-order revenue.

### Skeptical Analyst Prompt

Act as a skeptical business analyst. Review the recommendation to prioritize Air Fryer promotions using the available sales data. Identify unstated assumptions, distinguish revenue from profit, and propose data checks that would support or reject the recommendation. Do not assume that the highest revenue automatically means the highest profitability.

### Three Assumptions and Required Checks

**Assumption 1: High revenue means high profit.**

- **Check:** Obtain product cost and promotional expense data.
- **Evidence:** Calculate gross profit and profit margin for Air Fryer compared with other products.
- **Decision:** Do not claim Air Fryer is the most profitable product until the relevant cost and margin figures are available.

**Assumption 2: The recorded sales pattern will continue.**

- **Check:** Compare Air Fryer sales across September, October, and November.
- **Evidence:** Review monthly revenue and quantity sold.
- **Decision:** Treat the recommendation as provisional if demand varies significantly by month.

**Assumption 3: Promotions will increase sales without reducing overall returns.**

- **Check:** Compare promotion and non-promotion periods using units sold, revenue, discounts, and profit.
- **Evidence:** Calculate incremental revenue and profit associated with promotions.
- **Decision:** Recommend a promotion only when the measured benefit supports its cost.

### Conclusion

The available data shows that Air Fryer generated 104,000 in completed-order revenue, the highest among the products listed in query q12. However, revenue alone cannot establish profitability or prove that a promotion will be successful. The recommendation should be tested using product costs, margins, and promotion-performance data.

## 6. Final Review

AI-generated SQL queries and spreadsheet formulas are drafts, not automatically trusted answers. The corrected D1 query was executed and its output matched the expected regional revenue results. Other formulas and recommendations require the appropriate data checks before their results can be considered verified.

Human review, source-data comparison, and reproducible query execution are essential for producing reliable analytical results.
