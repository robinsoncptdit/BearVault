# CSA Step-by-Step Implementation Guide

This guide outlines the process to create the Power BI environment, integrate Copilot, and load data from both CSV files and the Ministry Platform API.

---

## 1. Prerequisites
1. **Microsoft Power BI** (Desktop or Service) installed and set up with organizational credentials.
2. **Microsoft 365 Copilot** availability and licenses.
3. **Ministry Platform API Credentials** (if using the live data approach).
4. **Sample/Production CSV Files** (if using the CSV approach).

---

## 2. Environment Setup in Microsoft Power BI

1. **Install Power BI Desktop (if not already installed)**
   - Go to your organization’s Power BI licensing page or [powerbi.microsoft.com](https://powerbi.microsoft.com/).
   - Download and install Power BI Desktop.

2. **Open Power BI Desktop**
   - Launch the Power BI Desktop application.
   - Sign in using your organizational (Office 365/Azure AD) credentials.

3. **Create a New Power BI File**
   - Click **File** > **New**.
   - Save your file as, for example, `CSA_Dashboard`.

---

## 3. Data Loading Options

### 3.1 Load via CSV File Uploads

1. **Prepare the CSV files** for pledges and donations.
   - Ensure columns have clear headers (e.g., `Donor_ID`, `Donation_Amount`, `Donation_Date`, `Pledge_Amount`, etc.).
   - Place the CSV files in a secure location (SharePoint, local drive, or network drive).

2. **Import CSV Data into Power BI**
   - In Power BI Desktop, click **Get Data** > **Text/CSV**.
   - Select your CSV file and click **Load**.
   - Repeat for all CSV files (e.g., `Pledges_2025.csv`, `Donations_2025.csv`).

3. **Combine or Transform the Data (Power Query)**
   - After importing, the **Power Query Editor** opens.
   - Perform any necessary data cleaning (remove duplicates, rename columns, filter rows, etc.).
   - Ensure you have a **unique key** (e.g., `Donor_ID`, `Pledge_ID`) for establishing relationships.

4. **Close & Apply**
   - Once transformations are complete, click **Close & Apply**.
   - Power BI will import the cleaned datasets and create data tables for you.

5. **Set Data Refresh Schedule (If Needed)**
   - If your CSV files are updated regularly, consider publishing to the Power BI Service and scheduling refreshes under **Settings** > **Datasets**.

---

### 3.2 Load Data via Ministry Platform API

1. **Obtain API Credentials**
   - Request API key or OAuth credentials from the Ministry Platform admin.
   - Note the base URL for the Ministry Platform API (e.g., `https://api.ministryplatform.com/`).

2. **Set Up the Data Connection in Power BI**
   - In Power BI Desktop, click **Get Data** > **Web**.
   - In the **From Web** dialog, enter the Ministry Platform API endpoint (e.g., `https://api.ministryplatform.com/v1/pledges`).
   - If needed, select **Advanced** to configure additional parameters or queries.

3. **Authentication**
   - Choose **Basic** or **OAuth2** authentication (depending on Ministry Platform’s setup).
   - Provide the required credentials (client ID, client secret, or API key).

4. **Invoke the API and Transform Data**
   - Review the returned JSON structure in **Power Query**.
   - Expand records/columns to get fields like Donor, Pledge Date, Pledge Amount, Payment Date, Payment Amount, etc.
   - Rename columns and filter as needed.

5. **Create Queries for Different Endpoints (if necessary)**
   - If you have multiple endpoints (e.g., pledges, donations, donors, parishes), repeat the above steps for each.
   - Use **Merge Queries** or **Append Queries** in Power Query to join or combine data tables appropriately.

6. **Close & Apply**
   - Click **Close & Apply** to finalize your data model.
   - Ensure relationships between tables (Donor_ID, Pledge_ID, etc.) are correctly established.

7. **Schedule Refresh**
   - In the Power BI Service, set up a refresh schedule to pull fresh data from the API on a regular cadence (e.g., daily, weekly).

---

## 4. Data Modeling and Relationship Setup

1. **Open Model View**
   - In Power BI Desktop, navigate to the **Model** view (the diagram icon on the left sidebar).

2. **Define Relationships**
   - Connect **Donor_ID** in the Pledges table to **Donor_ID** in the Donors table.
   - Connect **Pledge_ID** in the Pledges table to **Pledge_ID** in the Payments/Donations table.

3. **Adjust Cardinalities**
   - Ensure the relationships reflect one-to-many or many-to-one as appropriate (e.g., one donor to many pledges).

4. **Create Calculated Columns/Measures (if necessary)**
   - For instance, `Total Pledged = SUM(Pledges[Pledge_Amount])`.
   - `Fulfillment Rate = DIVIDE(SUM(Donations[Donation_Amount]), SUM(Pledges[Pledge_Amount]))`.

---

## 5. Building the Dashboard for the Director of Development

1. **Design Key Visuals**
   - Select visuals such as **Bar Charts**, **Line Charts**, **KPI Cards**, and **Tables** to represent metrics:
     - **KPI Cards** for total donors, total pledged, total donated, average donation, etc.
     - **Bar Charts** for top parishes by donation or pledge amount.
     - **Line Chart** for monthly or weekly donation trends.

2. **Set Up Filters**
   - Include Slicers for date range, parish, or donor segments.
   - Allow easy click-based interaction for the Director of Development.

3. **Add Titles and Labels**
   - Make sure each visual and page is clearly labeled for clarity.

---

## 6. Copilot Integration

1. **Enable Copilot in Power BI**
   - Ensure your organizational tenant has Copilot access enabled.
   - In Power BI Service or Microsoft 365 admin center, verify that Copilot is turned on for the relevant users.

2. **Grant Permissions to the Dataset**
   - The Director of Development must have the right level of permission in Power BI (Contributor or higher to view and query data).

3. **Test Natural Language Queries**
   - Use the **Copilot** interface to test queries like:
     - “Show me total pledges for the current year.”
     - “Which parish has the highest donation amount so far?”

4. **Train Director of Development**
   - Provide a quick reference on formulating queries or adding filters via Copilot.
   - Emphasize best practices for specifying date ranges or terms.

---

## 7. Publishing & Sharing the Dashboard

1. **Publish to Power BI Service**
   - From Power BI Desktop, click **Publish**.
   - Select or create a workspace (e.g., “Development Department Reports”).

2. **Set Up Access for the Director of Development**
   - In the Power BI Service, navigate to the workspace.
   - Click **Share** and add the Director of Development with appropriate permissions.

3. **Embed or Distribute Reports**
   - Optional: Provide a link or embed in a Microsoft Teams channel or SharePoint site.

---

## 8. Ongoing Maintenance & Future Enhancements

1. **Data Refresh Monitoring**
   - Regularly check scheduled data refresh logs for errors.
   - Address any API issues or CSV update issues promptly.

2. **Enhance Dashboards**
   - As the Director of Development’s needs evolve, add or modify visuals and metrics.

3. **Additional Security Layers**
   - If you need to restrict certain parishes to certain viewers, configure row-level security (RLS).

---

## 9. Summary

1. **Easy Initial Setup**  
   - CSV uploads are straightforward for smaller or one-time data loads.  
   - Ministry Platform API provides real-time, dynamic reporting.

2. **Director of Development Focus**  
   - Intuitive visuals and the ability to ask data questions via Copilot.

3. **Reusable for Similar Projects**  
   - The same steps can be replicated for other campaigns, appeals, or data sets.

4. **Scalable and Secure**  
   - Power BI’s robust security model and scheduling capabilities ensure reliability.  
   - Copilot integration reduces IT dependency by allowing natural language queries.
#CSA