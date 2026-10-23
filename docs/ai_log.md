# Part D — AI Log, Validation, and Human Review

## D1. AI Prompt and SQL Debugging

### Original AI Prompt

**Role:** Act as an experienced SQL analyst reviewing sales data.

**Task:** Write a SQL query to calculate regional revenue using completed orders only.

**Context:** The database uses SQLite and contains three relevant tables:

- `orders`: `order_id`, `customer_id`, `product_id`, `quantity`, `amount`, `status`, `order_date`
- `customers`: `customer_id`, `first_name`, `last_name`, `city`, `region`, `age`, `rep_id`
- `products`: `item`, `category`, `unit_price`

**Constraints:**
- Include only completed orders.
- Calculate revenue by customer region.
- Return only regions whose completed revenue exceeds 80,000.
- Use valid SQLite syntax.
- Do not use stored procedures or unnecessary CTEs.

**Output format:** Return the SQL query with brief comments explaining the filtering and aggregation.

### Defect Review

| Defect | Classification | Correction |
|---|---|---|
| Referenced a table that did not exist in the supplied schema | Schema error | Used the existing `orders` and `customers` tables |
| Referenced invalid or mismatched column names | Schema error | Used `orders.customer_id`, `orders.amount`, `orders.status`, and `customers.region` |
| Placed an aggregate condition in `WHERE` | SQL logic error | Applied `HAVING SUM(o.amount) > 80000` after grouping |
| Included an unsupported claim that revenue increased by 38% | Unsupported inference | Removed the claim and calculated the change from the available monthly figures |

### Corrected SQL

The following query was executed in SQLite Online.

```sql
-- D1: Regional revenue validation
-- Include completed orders only.
-- Show regions with completed revenue greater than 80000.

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

### Actual Execution Result

The query ran successfully and returned these two rows:

| Region | Total Revenue |
|---|---:|
| North | 119300 |
| South | 82500 |

The output matched the expected result. Only regions with completed revenue greater than 80,000 were returned.

### Human-in-the-Loop Protocol

**1. Specification:** I defined the required output as regional revenue from completed orders only, with a threshold greater than 80,000.

**2. Execution:** I ran the corrected query in SQLite Online using the project's schema and seed script.

**3. Inspection:** I checked the returned column names, region names, revenue totals, and descending order.

**4. Verification:** The query returned North with 119,300 and South with 82,500. Both totals exceed the specified threshold.

**5. Decision:** I rejected the defective original query because of its schema and aggregation errors. I accepted the corrected query because it executed successfully and produced the expected two-row result.

### Monthly Revenue Change Check

The available monthly figures for North were:

- September: 53,500
- October: 41,300

The absolute change was:

41,300 − 53,500 = −12,200

The percentage change was:

\[
\frac{41,300-53,500}{53,500}\times100
\approx -22.80\%
\]

North's revenue decreased by approximately 22.80% from September to October. Therefore, a claim that revenue increased by 38% is not supported by these figures.

---

## D2. Spreadsheet Lookup Debugging

### Problem Context

The spreadsheet uses an `orders` worksheet and a `products` worksheet. The product lookup table occupies the range `products!A2:C10`.

The product name is in column G of the orders worksheet, and the unit-price lookup formula is in column O. In this workbook, the first relevant data row is row 3.

A product name containing an unintended leading or trailing space may fail to match the corresponding product name in the lookup table.

### Original Formula

```excel
=XLOOKUP(G3,products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

### Root Cause

The original formula uses the product name exactly as stored in `G3`. If the name contains an extra leading or trailing space that is not present in the lookup table, the lookup may not find a match and may return `UNKNOWN_ITEM`.

### Corrected Formula

```excel
=XLOOKUP(TRIM(G3),products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

`TRIM(G3)` removes leading and trailing spaces and reduces repeated internal spaces to single spaces. This helps the product name match the lookup table.

### Verification and Limitation

I updated the formula in cell `O3` to use `TRIM(G3)` and confirmed that a price was displayed. However, this observation alone does not establish that a deliberately space-padded product name was tested separately.

A complete validation should test a product name with a leading space, confirm that the corrected formula returns its expected unit price, and test an unknown product to confirm that the fallback value `UNKNOWN_ITEM` is displayed.

---

## D3. Skeptical Review of a Business Recommendation

### Recommendation Under Review

The Air Fryer is the highest-revenue product and should receive additional promotional investment.

The available product-revenue results show:

| Product | Revenue | Revenue Classification |
|---|---:|---|
| Air Fryer | 104000 | High |
| Smart Watch | 67500 | High |
| Wireless Earbuds | 60800 | High |

Air Fryer has the highest recorded revenue among these products. However, revenue alone does not prove that additional promotion will be profitable.

### Skeptical Analyst Prompt

**Role:** Act as a skeptical business analyst reviewing a sales recommendation.

**Task:** Evaluate whether the Air Fryer should receive additional promotional investment.

**Context:** The SQL analysis reports Air Fryer revenue of 104,000, Smart Watch revenue of 67,500, and Wireless Earbuds revenue of 60,800.

**Constraints:** Do not assume that high revenue automatically means high profit, high demand growth, or high promotional effectiveness. Identify three assumptions and specify evidence needed to test each one.

**Output format:** Provide a table with each assumption, why it matters, and the data check required.

### Three Assumptions and Evidence Checks

| Assumption | Why It Matters | Data Check Required |
|---|---|---|
| Higher revenue means higher profit | Revenue does not account for product costs, discounts, or promotional expenses | Compare product-level gross profit and margin, including relevant costs |
| Air Fryer demand will continue | Historical revenue alone does not establish future demand | Compare monthly Air Fryer revenue and units sold over the available period |
| Additional promotion will increase sales profitably | Promotion may not generate enough additional sales to cover its cost | Compare campaign spending, sales before and after promotion, and incremental profit |

### Decision

Air Fryer is the highest-revenue product in the current results, with recorded revenue of 104,000. This supports considering it for further analysis, but it does not prove that it is the most profitable product or that increased advertising will produce the best return.

Before approving additional promotional spending, I would review product margins, monthly sales trends, and campaign performance. The recommendation should remain provisional until those checks are completed.

---

## Final Validation Summary

- The corrected D1 SQL query was executed successfully in SQLite Online.
- The D1 output matched the expected North and South revenue results.
- The D2 lookup formula was updated to use `TRIM(G3)`, and a price was displayed.
- A separate test using an intentionally space-padded product name and an unknown product remains necessary for complete D2 verification.
- The Air Fryer recommendation was reviewed critically, with three assumptions and corresponding evidence checks documented.
- All findings should be interpreted within the limits of the available dataset.
