# AI Assistance and Verification Log

## 1. Purpose

AI assistance was used to draft SQL queries, identify possible defects, correct spreadsheet lookup formulas, and review dashboard recommendations. All outputs must be checked against the project schema, source data, and assignment requirements before acceptance.

## 2. Part A — SQL Query Assistance

### Prompt Used for q13

**Role:** Act as a SQL analyst and reviewer.

**Task:** Write a SQL query to evaluate each sales representative's monthly performance against their monthly target.

**Context:** Use the SQLite database tables `orders`, `customers`, and `reps`. The `orders` table contains order details, including `customer_id`, `order_month`, `status`, and `amount`. The `customers` table contains `customer_id`, `rep_id`, and `region`. The `reps` table contains `rep_id`, `rep_name`, and `monthly_target`.

**Constraints:**
- Include completed orders only.
- Group results by representative and month.
- Compare monthly completed-order revenue with the representative's monthly target.
- Classify performance as `Above Target`, `On Target`, or `Below Target`.
- Use SQLite-compatible syntax.
- Do not use common table expressions (`WITH`) or stored procedures.

**Format:** Return raw SQL with brief inline comments.

### Verification

The q13 query was executed in SQLite Online. Its output contained 12 representative-month combinations: four representatives across September, October, and November 2026. The revenue totals and performance labels were compared with the completed-order data.

## 3. Part D1 — Defect Analysis and Correction

| Defect | Classification | Correction |
|---|---|---|
| Query references a table that does not exist in the provided schema. | Invalid table reference | Use the actual tables in the project schema. |
| Query references columns that do not exist. | Invalid column reference | Replace them with the actual column names, such as `customer_id`, `region`, `status`, and `amount`. |
| An aggregate condition is placed in `WHERE`. | SQL logic/syntax error | Apply aggregate filters with `HAVING` after grouping. |
| The original analysis claims a 38% increase without supporting data. | Unsupported statistic | Recalculate the change using the actual monthly revenue figures. |

### Corrected D1 SQL

The corrected query in `sql/d1_corrected.sql` groups completed-order revenue by region and keeps regions whose revenue exceeds 80,000.

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

### Expected Verification Output

| Region | Total revenue |
|---|---:|
| North | 119300 |
| South | 82500 |

These values must be confirmed by running the corrected query against the project's actual database before final submission.

### Human-in-the-Loop Verification Protocol

**1. Specification:** Check that the query answers the regional revenue question, uses the actual schema, includes completed orders only, and applies the 80,000 threshold.

**2. Execution:** Run the corrected SQL using SQLite Online with the project's schema and seeded data.

**3. Inspection:** Check the returned region names, revenue values, sorting, and whether every returned region satisfies the threshold.

**4. Verification:** Compare the output against the source data and the expected values shown above. Recalculate any claimed percentage change from the relevant monthly revenue figures.

**5. Decision:** Reject the original query if it contains invalid references, incorrect aggregate filtering, or unsupported statistics. Accept the corrected query only after its output matches the executed database results.

### Monthly Revenue Change Check

For North region, September revenue was 53,500 and October revenue was 41,300.

Percentage change:

\[
\frac{41,300-53,500}{53,500}\times100
\approx -22.8\%
\]

Therefore, the figures indicate a decrease of approximately 22.8%, not an increase of 38%.

## 4. Part D2 — Spreadsheet Lookup Defect

### Problem

A product lookup may fail when the lookup key contains an unwanted leading space. For example, the product name in cell G2 is `" Smart Watch"`, while the product table contains `"Smart Watch"`.

### Original Formula

```excel
=XLOOKUP(G2,products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

### Corrected Formula

```excel
=XLOOKUP(TRIM(G2),products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

### Explanation

`TRIM(G2)` removes leading and trailing spaces before the lookup is performed. This allows the cleaned product name to match the product table. The fallback text `UNKNOWN_ITEM` remains useful for detecting genuinely missing product names.

### Verification Steps

1. Test the formula with the value `" Smart Watch"`.
2. Confirm that the lookup returns the matching product price.
3. Test a genuinely unknown product name.
4. Confirm that the formula returns `UNKNOWN_ITEM` for the unknown key.

## 5. Part C — Skeptical Review of a Dashboard Recommendation

### Recommendation Under Review

Prioritize Air Fryer promotions because it generated the highest completed-order revenue.

### Skeptical Analyst Prompt

Act as a skeptical business analyst. Review the recommendation to prioritize Air Fryer promotions using the available sales data. Identify unstated assumptions, distinguish revenue from profit, and propose data checks that would support or reject the recommendation. Do not assume that the highest revenue automatically means the highest profitability.

### Three Assumptions and Required Checks

**Assumption 1: High revenue means high profit.**

- **Check:** Obtain product cost and promotional expense data.
- **Evidence:** Calculate gross profit and profit margin for Air Fryer compared with other products.
- **Decision:** Do not claim that Air Fryer is the most profitable product until these figures are available.

**Assumption 2: The recorded sales pattern will continue.**

- **Check:** Compare Air Fryer sales across September, October, and November.
- **Evidence:** Review monthly revenue and quantity sold.
- **Decision:** Treat the recommendation as provisional if demand varies significantly by month.

**Assumption 3: Promotions will increase sales without reducing overall returns.**

- **Check:** Compare promotion and non-promotion periods using units sold, revenue, discounts, and profit.
- **Evidence:** Calculate incremental revenue and profit associated with promotions.
- **Decision:** Recommend a promotion only when the measured benefit supports its cost.

### Conclusion

The available data shows that Air Fryer generated 104,000 in completed-order revenue, the highest among the listed products. However, revenue alone cannot establish profitability or prove that a promotion will be successful. The recommendation should be tested using cost, margin, and promotion-performance data.

## 6. Final Review

AI-generated SQL and spreadsheet formulas are drafts, not automatically trusted answers. Final acceptance requires execution, comparison with source data, verification of calculated values, and human review. Unsupported claims must be removed or clearly identified as unverified.
