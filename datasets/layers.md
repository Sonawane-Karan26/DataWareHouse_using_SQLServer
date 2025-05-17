## 🔄 How the Data Flows Through the Layers

This project implements a multi-layered **Medallion Architecture** to manage and transform data efficiently from raw input to actionable insights:

- 🔹 **Bronze Layer**: Raw ERP and CRM data from CSV files is ingested into SQL Server tables **without any transformation**, preserving the original structure for traceability and debugging.
- ⚙️ **Silver Layer**: The data is then **cleaned, standardized, and normalized**. This layer resolves data quality issues, harmonizes schemas, and creates intermediate tables ready for integration and analysis.
- 🟡 **Gold Layer**: Business-ready **views and star schema models** are created by joining and enriching the silver layer tables. This layer includes fact and dimension tables, aggregations, and business logic tailored for reporting.

Each layer builds upon the previous one, ensuring data quality, consistency, and usability for **analytics and decision-making**. The transformation pipeline is visualized in the included architecture diagrams and modeled using SQL scripts within the project.





![Layers](datasets/Layers.PNG)

![Layers working](datasets/Layers_working.PNG)

![Data Flow](datasets/data_flow.PNG)

![Data Integration](datasets/data_integration.PNG)
