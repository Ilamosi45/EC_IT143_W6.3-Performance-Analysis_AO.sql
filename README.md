# 6.3 Performance Analysis — SQL Server Optimization

This repository contains the deliverables for the **6.3 Performance Analysis** assignment. The objective of this project is to demonstrate the fundamentals of query performance optimization, database indexing structures, execution plan analysis, and real-time database monitoring using SQL Server Profiler.

---

## Deliverables Included

1. **Performance Analysis Script:** `SQL_Performance_Analysis.sql` (Optimized queries and index creation scripts).
2. **Demonstration Video:** A 5-minute practical walkthrough demonstrating performance gains and tools overview.
3. **Repository Commit Verification:** Submitted with the mandatory rubric commit tag: `Adding deliverable W6.4.`

---

## Optimization Scenarios

To prompt SQL Server to generate missing index recommendations, two purposefully unoptimized queries were run against the `AdventureWorks2019` database with the **Actual Execution Plan** enabled.

### Scenario 1: `Person.Person` Table
* **The Issue:** Querying against the `Title` column (an unindexed character field) forced a full **Clustered Index Scan**, consuming unnecessary system resources.
* **The Fix:** Implemented a targeted nonclustered index (`IX_Person_Title`) to isolate the predicate data.
* **The Result:** The performance profile shifted from a heavy scan to a highly efficient **Index Seek**, sharply reducing the query's Estimated Subtree Cost.

### Scenario 2: `Sales.SalesOrderDetail` Table
* **The Issue:** Querying a massive transactional dataset by filtering on `CarrierTrackingNumber` (unindexed) created a major system bottleneck due to processing thousands of records via full scans.
* **The Fix:** Implemented a nonclustered coverage index (`IX_SalesOrderDetail_CarrierTrackingNumber`).
* **The Result:** Converted the query mechanics into a streamlined **Index Seek**, verifying optimization metrics directly inside the execution plan tab.

---

## SQL Server Profiler Quick Reference

As demonstrated in the submission walkthrough, **SQL Server Profiler** acts as a powerful traffic analyzer for database administrators. 

### Core Use Cases:
* **Query Troubleshooting:** Capturing slow runtime threads live to rewrite underlying syntax.
* **Security & Compliance Auditing:** Tracking user access, failed login tokens, and unauthorized schema manipulations.
* **Concurrency Diagnostics:** Pinpointing locking limits, high CPU consumption periods, and structural deadlocks.

### 5-Step Workflow Applied:
1. **Connect:** Launch Profiler and bind directly to the targeted SQL Server instance.
2. **Template Selection:** Instantiate a fresh trace leveraging standard defaults.
3. **Targeted Filtering:** Navigate to `Events Selection -> Column Filters` to strictly isolate `DatabaseName = AdventureWorks2019`, removing system background noise.
4. **Active Capture:** Run the trace engine while running the problematic app scripts.
5. **Post-Analysis:** Pause/Stop the capture stream to analyze columns like `Duration`, `CPU`, and `Reads`.

---

## Reverting Changes (Database Maintenance)
To return your local copy of `AdventureWorks2019` to its default architectural state post-grading, execute the teardown statements included in the cleanup pipeline file:

```sql
DROP INDEX IX_Person_Title ON Person.Person;
DROP INDEX IX_SalesOrderDetail_CarrierTrackingNumber ON Sales.SalesOrderDetail;
```
