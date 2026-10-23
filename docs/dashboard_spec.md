# Big Billion Days — Dashboard Specification

## 1. Objective

The dashboard analyzes completed-order sales to compare regional performance, product category contribution, monthly trends, and sales representative performance. It is designed to support data-driven decisions about sales planning and product promotions.

## 2. Data Source and Filters

**Data source:** `data/orders_clean.csv`

**Dataset:** 63 completed orders.

**Primary filter:** Product category.

Additional recommended filters are region, order month, and sales representative.

All revenue figures must use the same completed-order dataset and the recorded amount field. Missing values must not be replaced with invented amounts.

## 3. Data Dictionary

The cleaned dataset contains 13 columns.

| Field | Type | Role |
|---|---|---|
| order_id | Dimension | Order identifier |
| order_month | Dimension | Month of order |
| clean_first_name | Dimension | Standardized first name |
| clean_last_name | Dimension | Standardized last name |
| region | Dimension | Sales region |
| rep_name | Dimension | Sales representative |
| item | Dimension | Product name |
| category | Dimension | Product category |
| unit_price | Measure | Product unit price |
| quantity | Measure | Units ordered |
| amount | Measure | Recorded order amount |
| revenue_calc | Measure | Calculated revenue |
| status | Dimension | Order status |

There are eight dimensions and five measures in this field list. The dashboard should use the fields required for each worksheet and distinguish recorded amount from calculated revenue.

## 4. KPI Cards

### KPI 1: Completed Orders

**Value:** 63

Counts orders with completed status in the cleaned dataset.

### KPI 2: Total Recorded Revenue

**Value:** 346,200

Represents the total recorded amount for completed orders.

The KPI must reconcile with SQL query q05 and the spreadsheet total.

## 5. Dashboard Worksheets

### Worksheet 1: Revenue by Region

- **Chart type:** Bar chart
- **Dimension:** Region
- **Measure:** Sum of amount
- **Purpose:** Compare completed-order revenue across regions.
- **Sorting:** Descending revenue.
- **Interaction:** Selecting a region filters the other dashboard views.

### Worksheet 2: Monthly Revenue by Category

- **Chart type:** Line chart
- **Horizontal axis:** Order month
- **Vertical axis:** Sum of amount
- **Color:** Product category
- **Purpose:** Compare category revenue trends across months.
- **Interaction:** The category filter controls the displayed lines.

### Worksheet 3: Region and Category Revenue Table

- **Chart type:** Text table or highlight table
- **Rows:** Region
- **Columns:** Product category
- **Values:** Sum of amount
- **Purpose:** Identify combinations of region and category with stronger or weaker revenue.

### Worksheet 4: Sales Representative Performance

- **Chart type:** Bar chart
- **Dimension:** Sales representative
- **Measure:** Sum of amount
- **Purpose:** Compare recorded completed-order revenue by representative.
- **Sorting:** Descending revenue.
- **Caution:** Revenue is not the same as profit or target achievement.

## 6. Required Data Tables

### Regional Revenue

Use a grouped table with `region` and `SUM(amount)`. Populate the final values from the executed SQL results or the completed-order spreadsheet.

### Monthly Revenue by Category

Use `order_month`, `category`, and `SUM(amount)`. Ensure months are sorted chronologically, not alphabetically.

### Region × Category

Create a cross-tab with regions as rows, categories as columns, and recorded revenue as values. Include row and column totals if supported.

### Representative Revenue

Use `rep_name` and `SUM(amount)`, sorted from highest to lowest.

The actual figures should be copied from validated data rather than estimated.

## 7. Layout and Design

- Place the dashboard title at the top.
- Place the two KPI cards directly beneath the title.
- Put the regional revenue bar chart and monthly category line chart in the main area.
- Place the region-category table and representative performance chart below them.
- Place filters in a consistent sidebar or along the top.
- Use clear labels, consistent currency formatting, readable axis titles, and accessible color contrast.
- Keep the layout professional, uncluttered, and suitable for presentation.

## 8. Insights to Investigate

1. **Product contribution:** Air Fryer recorded 104,000 in completed-order revenue, the highest among the products listed in query q12.
2. **Regional performance:** Compare regional revenue totals to identify which regions contribute most to completed-order revenue.
3. **Representative performance:** Compare monthly revenue with each representative's target before concluding that performance is above or below target.

Regional and monthly claims should be supported by the corresponding query outputs.

## 9. Recommendations

### Recommendation 1: Review Air Fryer inventory

Air Fryer generated 104,000 in completed-order revenue. Review inventory availability and product costs before planning additional promotions.

**Success metric:** Track monthly units sold, stock availability, and gross profit.

### Recommendation 2: Investigate regional revenue differences

Use the regional bar chart and region-category table to identify low-revenue combinations and investigate possible causes.

**Success metric:** Track changes in recorded completed-order revenue by region in subsequent reporting periods.

### Recommendation 3: Review sales representative targets monthly

Compare each representative's monthly completed-order revenue with their target before deciding on training or sales support.

**Success metric:** Track the number of representatives meeting their monthly targets and their revenue changes over time.

These recommendations are provisional. The available dataset does not include all information needed to prove profitability or determine why a region or representative performs differently.

## 10. Reconciliation and Validation

Before publishing the dashboard, confirm that:

- Completed-order count is 63.
- Total recorded completed-order revenue is 346,200.
- The dashboard uses the same filters and amount field as SQL query q05.
- Regional, monthly, category, and representative totals are derived from the same cleaned dataset.
- Missing amounts are handled consistently.
- Month labels are sorted chronologically.
- Category filters update all relevant worksheets.
- The dashboard totals reconcile with the spreadsheet and SQL results.

## 11. Dashboard Status

This document specifies the proposed dashboard structure and calculations. An interactive Tableau Public dashboard should only be described as completed after it has actually been built and published.
