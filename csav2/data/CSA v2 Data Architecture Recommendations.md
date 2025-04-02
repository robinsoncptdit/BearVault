# CSA v2 Data Architecture Recommendations
From: RoleBot Chief Data Officer (CDO)
## Recommended Data Architecture
1. Data Extraction & Storage Strategy
Core Tables in Supabase:
* donors - Normalized donor information
* donations - Individual gift transactions
* pledges - Pledge commitments and status
* congregations - Parish information
* programs - CSA program details
* campaigns - Annual campaign metadata
* donation_distributions - How donations are allocated to programs

⠀Derived/Aggregated Tables:
* donor_summary - Pre-calculated donor metrics (lifetime value, giving history)
* congregation_performance - Aggregated metrics by parish
* campaign_performance - Daily/weekly snapshots of campaign progress
* year_over_year_comparisons - Pre-calculated YOY metrics

⠀2. Data Synchronization Pattern
I recommend implementing:
* Full initial load - Complete extraction of historical data
* Incremental daily updates - Capture new/changed records only
* Weekly reconciliation - Verify data integrity between MP and Supabase

⠀3. Optimizing for Vector Search & Natural Language Queries
To support the OpenAI integration:
* Create denormalized views that combine related data for context
* Implement embeddings for key narrative fields (donor notes, program descriptions)
* Store pre-calculated metrics as vector-searchable entities
* Maintain a metadata table describing data relationships for context

⠀4. Performance Considerations
* Implement materialized views for frequently accessed metrics
* Create time-series tables for historical trend analysis
* Use Supabase's Row Level Security for appropriate access controls
* Implement efficient indexing on frequently queried fields

⠀5. n8n Workflow Recommendations
* Schedule daily incremental data pulls from MP API
* Implement transformation logic to normalize and enrich data
* Create data validation steps to ensure consistency
* Log all data movement operations for auditing

⠀Implementation Phases
1 Foundation Phase:
	* Establish core table structure in Supabase
	* Implement basic extraction workflows
	* Create initial data validation rules
2 Enhancement Phase:
	* Add derived metrics tables
	* Implement vector embeddings for NL queries
	* Create materialized views for performance
3 Optimization Phase:
	* Fine-tune indexing strategy
	* Implement caching for frequent queries
	* Optimize API call patterns

#csav2/data