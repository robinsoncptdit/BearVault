# CSA v2 Technical Architecture for CSA Data Analytics Platform

From: Chief Technology Officer (CFO)
## System Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │    │                 │
│ Ministry        │───▶│ n8n Automation  │───▶│ Supabase        │◀───│ OpenAI API      │
│ Platform API    │    │ Workflows       │    │ Database        │    │ Integration     │
│                 │    │                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
                                                      │                        │
                                                      ▼                        ▼
                                              ┌─────────────────┐    ┌─────────────────┐
                                              │                 │    │                 │
                                              │ Analytics       │    │ Natural         │
                                              │ Dashboards      │    │ Language        │
                                              │ & Reports       │    │ Query Interface │
                                              │                 │    │                 │
                                              └─────────────────┘    └─────────────────┘
```

## Component Details

### 1. Ministry Platform API Integration

- **Authentication Method**: OAuth 2.0 with service account credentials
- **API Access Pattern**: RESTful endpoints for each data entity (Contacts, Donors, Donations, etc.)
- **Data Extraction Strategy**: 
  - Initial full extraction for historical data
  - Incremental delta extractions based on modified timestamps
  - Scheduled polling for new/updated records

### 2. n8n Automation Workflows

- **Core Workflows**:
  - Data extraction workflow (scheduled daily)
  - Data transformation workflow (normalize and enrich data)
  - Data loading workflow (insert/update to Supabase)
  - Error handling and notification workflow
  - Weekly reconciliation and validation workflow

- **Workflow Architecture**:
  ```
  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
  │                 │    │                 │    │                 │    │                 │
  │ Trigger         │───▶│ Extract Data    │───▶│ Transform &     │───▶│ Load to         │
  │ (Schedule/Event)│    │ from MP API     │    │ Normalize       │    │ Supabase        │
  │                 │    │                 │    │                 │    │                 │
  └─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
                                                                               │
  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐           │
  │                 │    │                 │    │                 │           │
  │ Send            │◀───│ Log Results     │◀───│ Validate        │◀──────────┘
  │ Notifications   │    │ & Metrics       │    │ Data Quality    │
  │                 │    │                 │    │                 │
  └─────────────────┘    └─────────────────┘    └─────────────────┘
  ```

### 3. Supabase Database Structure

- **Core Tables**:
  - `donors` (normalized donor information)
  - `donations` (individual transactions)
  - `pledges` (commitment records)
  - `congregations` (parish data)
  - `programs` (CSA initiatives)
  - `campaigns` (annual campaign metadata)
  - `donation_distributions` (program allocations)

- **Derived Tables**:
  - `donor_metrics` (pre-calculated donor KPIs)
  - `congregation_performance` (parish-level metrics)
  - `campaign_metrics` (campaign performance indicators)
  - `yoy_comparisons` (year-over-year analysis)

- **Vector Storage**:
  - `embeddings.donor_narratives` (vector embeddings of donor information)
  - `embeddings.program_descriptions` (vector embeddings of program details)
  - `embeddings.metric_definitions` (embeddings of KPI definitions for NL queries)

### 4. OpenAI Integration

- **Integration Pattern**: 
  - REST API calls from application layer
  - Vector similarity search in Supabase for context retrieval
  - Prompt engineering with context injection

- **Query Flow**:
  ```
  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
  │                 │    │                 │    │                 │    │                 │
  │ Natural         │───▶│ Context         │───▶│ OpenAI API      │───▶│ Response        │
  │ Language Query  │    │ Retrieval       │    │ Processing      │    │ Formatting      │
  │                 │    │                 │    │                 │    │                 │
  └─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
  ```

## Implementation Workflow

### Phase 1: Foundation (Weeks 1-3)
1. Set up Supabase project and define schema
2. Configure Ministry Platform API access
3. Develop core n8n extraction workflows
4. Implement basic data validation

### Phase 2: Data Pipeline (Weeks 4-6)
1. Develop transformation logic in n8n
2. Implement incremental data synchronization
3. Create derived metrics tables
4. Set up monitoring and error handling

### Phase 3: Analytics & AI (Weeks 7-10)
1. Generate vector embeddings for relevant data
2. Develop OpenAI integration layer
3. Create natural language query interface
4. Implement dashboard and reporting views

### Phase 4: Optimization & Handoff (Weeks 11-12)
1. Performance tuning and optimization
2. Documentation and knowledge transfer
3. User training for Director of Development team
4. Establish ongoing maintenance procedures

## Technical Considerations

1. **Security**:
   - Implement row-level security in Supabase
   - Use environment variables for API credentials
   - Encrypt sensitive data in transit and at rest

2. **Scalability**:
   - Design for growing data volume over multiple campaigns
   - Implement efficient indexing strategies
   - Use connection pooling for API calls

3. **Reliability**:
   - Implement retry logic for API failures
   - Create comprehensive logging
   - Develop automated monitoring alerts

4. **Performance**:
   - Use materialized views for frequent queries
   - Implement caching strategies
   - Optimize vector search parameters

Would you like me to elaborate on any specific aspect of this technical architecture? I can provide more detailed recommendations for any component of the system.
#csav2/techstack