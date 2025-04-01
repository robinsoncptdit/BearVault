# CSA Project Requirements Document (PRD) v1

CSA Project Requirements Document (PRD)

## 1. Overview
The Catholic Diocese of Pensacola-Tallahassee (the Diocese) wants to track and analyze annual pledge campaign data (the “Catholic Sharing Appeal” or CSA) more efficiently. The data is maintained in Ministry Platform and also stored in CSV files for pledges and donations. The Director of Development needs an easy-to-use dashboard with the ability to ask questions about donor data using natural language.

## 2. Objectives
1. Provide a system that integrates data from either CSV files or the Ministry Platform API directly into Microsoft Power BI.
2. Enable the Director of Development to:
   - View real-time metrics such as donor counts, pledge amounts, and donations.
   - Identify top-performing parishes and lagging parishes.
   - Ask questions about the data using Copilot and receive insights.
3. Require minimal IT intervention once the system is in production.

## 3. Stakeholders
- **Director of Development (Primary User):** Needs real-time dashboards and the ability to query data easily.
- **IT/Technology Team (Project Owners):** Responsible for creating the data environment, integrating with Power BI, and enabling Copilot features.

## 4. Scope and Key Features
1. **Data Import/Integration:**
   - **Option A:** Manual import of CSV files into Power BI.
   - **Option B:** Live/API connection to Ministry Platform data using REST API endpoints.
2. **Data Transformations & Modeling:**
   - Creation of relevant data models (pledges, donors, parishes, payments, etc.).
   - Ensuring data cleanliness, consistent naming conventions, and robust data relationships.
3. **Reporting & Dashboards:**
   - Interactive dashboards in Power BI for the Director of Development.
   - Key performance indicators (KPIs) such as:
     - Number of Donors
     - Total Pledge Amount
     - Actual Donations to Date
     - Pledge Fulfillment Rate
     - Parish Performance Comparisons
4. **Copilot Integration:**
   - Allow the Director of Development to use natural language queries to surface insights and ask data-related questions.
   - Provide easy instructions or “help text” on how to formulate queries or filters.
5. **Security & Access:**
   - Ensure data is only visible to authorized stakeholders.
   - Consider row-level security if needed (e.g., restricting parish-specific data if relevant).
6. **Maintenance & Scalability:**
   - The system should be straightforward to replicate for other campaigns or initiatives.
   - Future expansions to additional metrics or analyses should be easily integrated.

## 5. Success Criteria
- **Director of Development** can run Power BI dashboards independently and glean insights with minimal assistance from IT.
- **Copilot** responds reliably and accurately to common queries about CSA performance metrics.
- **Data Updates** from CSVs or direct API calls remain consistent and reliable.
- **Security** is preserved, and the system is scalable for other similar projects.

## 6. Timeline
1. **Project Setup** (1-2 weeks):
   - Confirm data sources (CSV files or Ministry Platform API).
   - Create proof-of-concept in Power BI.
2. **Data Modeling & ETL** (2-3 weeks):
   - Define data relationships and transformations.
   - Test and validate sample data sets.
3. **Dashboard & Copilot Configuration** (1-2 weeks):
   - Build initial dashboards.
   - Configure Copilot for natural language queries.
4. **User Acceptance Testing & Training** (1 week):
   - Director of Development reviews and tests dashboards.
   - Provide training on dashboard usage and Copilot queries.
5. **Go-Live & Support** (ongoing):
   - Maintenance and updates as needed.

## 7. Assumptions & Dependencies
- The Diocese already has appropriate licensing for Microsoft Power BI and access to Microsoft Copilot features.
- Ministry Platform’s REST API is accessible with valid credentials.
- CSV files contain the needed data and are updated regularly if using the manual approach.
- Director of Development has the necessary user access privileges within Power BI.

## 8. Risks & Mitigations
1. **API Downtime**: Mitigate by scheduling fallback CSV imports if the Ministry Platform API is unavailable.
2. **Data Accuracy**: Ensure thorough testing and data validation steps before going live.
3. **Change Management**: Provide quick-reference guides and training materials for the Director of Development to reduce confusion with new tools.

## 9. Next Steps
- **Review & Approve PRD** by IT/Technology Team and the Director of Development.
- **Proceed to Implementation** following the step-by-step instructions in the accompanying guide.
#CSA