# CSA v2 Data Analytics: ETL Workflow Documentation

From: Business Process Analyst
## Ministry Platform to Supabase ETL Process

This document outlines the detailed step-by-step workflow for extracting data from Ministry Platform, transforming it appropriately, and loading it into Supabase using n8n automation.

### 1. Initial Data Extraction Workflow

**Trigger: Manual (one-time setup)**

1. **Authentication Setup**
   - Action: HTTP Request node to obtain OAuth token from Ministry Platform
   - Parameters: Client ID, Client Secret, Grant Type
   - Output: Store authentication token in n8n credentials

2. **Full Historical Data Extraction**
   - Action: HTTP Request nodes (one per data entity)
   - Parameters: 
     - Endpoint: `/api/contacts`, `/api/donors`, `/api/donations`, etc.
     - Method: GET
     - Headers: Authorization with token
     - Query Parameters: Include pagination settings (page size: 1000)
   - Condition: Check for HTTP 200 response
     - If Success: Continue to next step
     - If Failure: Trigger error notification workflow

3. **Pagination Handling**
   - Action: Loop nodes for each entity
   - Parameters: Continue while "has_more" flag is true
   - Action within Loop: HTTP Request for next page
   - Condition: Check for complete data extraction
     - If Complete: Continue to transformation
     - If Incomplete: Log error and retry

4. **Data Validation (Pre-transformation)**
   - Action: Function node
   - Logic: Verify required fields exist and format is as expected
   - Condition: Check validation results
     - If Valid: Continue to transformation
     - If Invalid: Log specific validation errors and halt process

### 2. Daily Incremental Update Workflow

**Trigger: Schedule (Daily at 2:00 AM)**

1. **Authentication Renewal**
   - Action: HTTP Request node to refresh OAuth token
   - Condition: Check token validity
     - If Valid: Continue
     - If Invalid: Retry authentication (max 3 attempts)

2. **Last Execution Timestamp Retrieval**
   - Action: Supabase node to query `etl_log` table
   - Parameters: Get most recent successful run timestamp
   - Output: Store timestamp as variable for incremental query

3. **Incremental Data Extraction**
   - Action: HTTP Request nodes (one per entity)
   - Parameters:
     - Endpoints: Same as initial extraction
     - Query Parameters: Add filter for `modified_date > [last_timestamp]`
   - Condition: Check for data returned
     - If Data Found: Continue to transformation
     - If No Data: Skip to logging step (no updates needed)

### 3. Data Transformation Workflow

**Triggered by: Completion of Extraction step**

1. **Data Normalization**
   - Action: Function node for each entity
   - Logic:
     - Standardize field names (camelCase to snake_case)
     - Format dates to ISO 8601
     - Handle null values appropriately
   - Output: Normalized data objects

2. **Relationship Mapping**
   - Action: Function node
   - Logic:
     - Create foreign key relationships
     - Ensure referential integrity
     - Map Ministry Platform IDs to Supabase IDs
   - Output: Relationship-mapped data objects

3. **Derived Field Calculation**
   - Action: Function node
   - Logic:
     - Calculate additional fields (e.g., pledge fulfillment percentage)
     - Generate unique identifiers if needed
     - Prepare data for vector embeddings
   - Output: Enriched data objects

4. **Data Transformation Validation**
   - Action: Function node
   - Logic: Verify transformed data meets Supabase schema requirements
   - Condition: Check validation results
     - If Valid: Continue to loading
     - If Invalid: Log transformation errors and halt process

### 4. Data Loading Workflow

**Triggered by: Completion of Transformation step**

1. **Upsert Preparation**
   - Action: Function node
   - Logic:
     - Split data into insert/update operations
     - Prepare batch operations for efficiency
   - Output: Batched operations for Supabase

2. **Primary Tables Loading**
   - Action: Supabase nodes (one per primary table)
   - Operation: Upsert (insert or update based on primary key)
   - Order: Load in proper sequence to maintain referential integrity
     1. Congregations
     2. Campaigns
     3. Programs
     4. Donors
     5. Pledges
     6. Donations
     7. Donation Distributions
   - Condition after each table:
     - If Success: Continue to next table
     - If Failure: Log specific error and halt process

3. **Derived Tables Update**
   - Action: Supabase nodes with SQL queries
   - Operation: Refresh materialized views and derived tables
   - SQL Examples:
     - `REFRESH MATERIALIZED VIEW donor_metrics;`
     - `REFRESH MATERIALIZED VIEW congregation_performance;`
   - Condition: Check for successful refresh
     - If Success: Continue
     - If Failure: Log error but continue process

4. **Vector Embedding Generation**
   - Action: OpenAI API node
   - Operation: Generate embeddings for text fields
   - Parameters:
     - Model: text-embedding-ada-002
     - Input: Relevant text fields from transformed data
   - Action: Supabase node
   - Operation: Store embeddings in vector columns

### 5. Verification and Logging Workflow

**Triggered by: Completion of Loading step**

1. **Data Reconciliation Check**
   - Action: Function node with SQL queries
   - Logic:
     - Compare record counts between source and destination
     - Verify key metrics match expected values
   - Condition: Check reconciliation results
     - If Matched: Mark as successful
     - If Mismatched: Flag for review

2. **Process Logging**
   - Action: Supabase node
   - Operation: Insert into `etl_log` table
   - Data:
     - Timestamp
     - Process type (initial/incremental)
     - Status (success/failure)
     - Record counts
     - Error messages (if any)
     - Duration

3. **Notification**
   - Action: Email/Slack node
   - Condition: Based on process outcome
     - If Success: Send summary report
     - If Failure: Send detailed error report
   - Recipients: Development team and system administrators

### 6. Weekly Maintenance Workflow

**Trigger: Schedule (Weekly on Sunday at 1:00 AM)**

1. **Full Reconciliation**
   - Action: Function node with SQL queries
   - Logic: Comprehensive comparison between MP and Supabase
   - Output: Discrepancy report

2. **Index Optimization**
   - Action: Supabase node with SQL
   - Operation: VACUUM and ANALYZE operations
   - Logic: Optimize database performance

3. **Maintenance Log**
   - Action: Supabase node
   - Operation: Insert maintenance record
   - Data: Timestamp, actions performed, performance metrics

## Error Handling Protocols

1. **Extraction Errors**
   - Retry Logic: 3 attempts with exponential backoff
   - Fallback: Log specific API error and send alert

2. **Transformation Errors**
   - Recovery: Isolate problematic records
   - Logging: Store original and attempted transformation
   - Notification: Include sample of problematic data

3. **Loading Errors**
   - Transaction Management: Roll back on critical errors
   - Partial Success Handling: Log successfully loaded entities

## Monitoring and Alerting

1. **Process Duration Monitoring**
   - Threshold: Alert if process exceeds 120% of average duration
   - Action: Send performance degradation alert

2. **Data Volume Monitoring**
   - Threshold: Alert on significant deviations in record counts
   - Action: Send potential data integrity alert

3. **Error Rate Monitoring**
   - Threshold: Alert if error rate exceeds 5% of processed records
   - Action: Send data quality alert

Would you like me to elaborate on any specific part of this ETL workflow or provide additional details on any of the steps outlined?
#csav2/techstack