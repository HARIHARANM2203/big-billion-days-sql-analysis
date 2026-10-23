# Spreadsheet Cleaning and Validation Notes

## 1. Objective

The purpose of this spreadsheet analysis is to clean the Big Billion Days order data, enrich it with product information, validate missing amounts, and reconcile the completed-order results with the SQL analysis.

## 2. Workbook Structure

The workbook uses two main data sheets:

- `orders`: Contains the original 90 order records and additional calculated columns.
- `products`: Contains the product lookup table, including product names, categories, and unit prices.

The product lookup range is `products!A1:C10`, including the header row and nine products.

The enriched order data contains 90 records, while the cleaned completed-order dataset contains 63 records.

## 3. Data Cleaning

Customer names were standardized by removing unnecessary spaces and applying consistent capitalization.

Example formulas:

```excel
=PROPER(TRIM(C3))
```

```excel
=PROPER(TRIM(D3))
```

The formulas remove leading and trailing spaces and standardize the capitalization of first and last names.

The cleaned name columns were filled down for all order records.

## 4. Product Lookup and Enrichment

Product information was retrieved from the `products` sheet.

### Category lookup

```excel
=VLOOKUP(G3,products!$A$2:$C$10,2,FALSE)
```

This formula finds the matching product and returns its category.

### Unit-price lookup

```excel
=XLOOKUP(TRIM(G3),products!$A$2:$A$10,products!$C$2:$C$10,"UNKNOWN_ITEM")
```

This formula retrieves the unit price and returns `UNKNOWN_ITEM` if no matching product is found. `TRIM` removes unwanted spaces from the lookup key.

### Calculated revenue

```excel
=O3*H3
```

This multiplies the unit price by the quantity. The calculated value should be compared with the recorded order amount, rather than automatically replacing the original amount.

## 5. Missing Amount Validation

Three orders have missing recorded amounts:

- Order 1001
- Order 1010
- Order 1064

These missing amounts should not be replaced with invented values. They should be checked against the original transaction records or other reliable source data.

The missing-value check can be performed using a blank filter on the amount column or an appropriate `COUNTBLANK` formula.

## 6. Cleaning and Filtering Steps

1. Open the `orders` sheet.
2. Confirm that the original 90 order records are present.
3. Apply the name-cleaning formulas and product lookup formulas.
4. Fill the formulas down through the data rows.
5. Check for missing lookup results and unexpected values.
6. Filter the `status` column to show only `completed`.
7. Sort the amount column in descending order when reviewing the largest recorded completed orders.
8. Copy the completed-order records into the cleaned output sheet.
9. Export the cleaned data to `data/orders_clean.csv`.

The cleaned CSV should contain exactly 13 columns and 63 completed-order data rows, excluding the header.

## 7. Numeric Data Types

The following fields should be stored and checked as numeric values:

- Quantity
- Unit price
- Recorded amount
- Calculated revenue

Order identifiers should remain identifiers rather than being used in arithmetic calculations. Dates and month labels should be consistent. In the cleaned CSV, the month field should be stored as text in `YYYY-MM` format.

Before performing calculations, check for numbers stored as text, blank cells, and inconsistent formatting.

## 8. Duplicate and Outlier Checks

Check for duplicate order IDs because each order ID should identify one order record.

Large or unusual order amounts should be reviewed against the original data. A high value is not automatically an error; it should be validated using the product, quantity, and transaction information.

No values should be deleted or changed solely because they appear unusual.

## 9. Pivot Table Setup

### Pivot Table 1: Regional Revenue

- **Source:** Completed-order records
- **Rows:** Region
- **Values:** Sum of recorded amount
- **Purpose:** Compare recorded completed-order revenue across regions.

The grand total should reconcile with the completed-order revenue total of 346,200.

### Pivot Table 2: Product Category Revenue

- **Source:** Completed-order records with product category information
- **Rows:** Category
- **Values:** Sum of recorded amount
- **Purpose:** Compare revenue across product categories.

The grand total should be compared with the completed-order total. If the pivot table uses recorded amounts, missing amounts must remain missing rather than being silently replaced.

Record the actual category totals and grand total from the completed workbook before submission.

## 10. Aggregate Calculations and SQL Reconciliation

The completed-order data should be checked using:

- `COUNT` to count completed orders.
- `SUM` to calculate recorded revenue.
- `AVERAGE` to calculate average recorded order amount.

The SQL headline result is:

| Metric                                       | SQL result |
| -------------------------------------------- | ---------: |
| Completed orders                             |         63 |
| Total recorded revenue                       |     346200 |
| Missing recorded amounts in the full dataset |          3 |

The completed-order count and recorded revenue should match the spreadsheet calculations when the same rows and amount-handling rules are used.

Do not assume that a formula-generated revenue total and the recorded amount total are equal without checking them.

## 11. Data Quality Decision

The dataset is suitable for descriptive analysis after checking customer-name consistency, product lookups, data types, and duplicate order IDs.

However, the three missing amounts require investigation before they can be treated as confirmed financial values. Calculated revenue can be used as a validation aid, but it should not be confused with the recorded transaction amount.

## 12. Final Validation Checklist

- [ ] Confirm 90 original order records.
- [ ] Confirm nine products in the lookup table.
- [ ] Confirm formulas are filled down.
- [ ] Check missing amounts for orders 1001, 1010, and 1064.
- [ ] Check for `UNKNOWN_ITEM` lookup results.
- [ ] Check duplicate order IDs and unusual amounts.
- [ ] Confirm 63 completed-order records.
- [ ] Confirm the cleaned CSV has 13 columns and 63 data rows.
- [ ] Record actual regional and category pivot totals.
- [ ] Reconcile spreadsheet totals with SQL query q05.

