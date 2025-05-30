# 🚀 DataForge - Building a Modern SQL Data Warehouse

Welcome to the **DataForge** data warehouse project!  
This repository showcases an end-to-end data warehousing and analytics solution — from raw data ingestion to generating business intelligence. It's designed as a hands-on demonstration of data engineering and analytics practices aligned with real-world standards.

---

## 🏗️ Modern Data Architecture

The solution follows the **Medallion Architecture** comprising three layers: Bronze, Silver, and Gold.

- **Bronze Layer**: Raw, unprocessed data is directly imported from source systems (CSV files) into a SQL Server database.
- **Silver Layer**: Applies cleansing, formatting, and standardization steps to prepare data for analytics.
- **Gold Layer**: Transforms curated data into a business-friendly star schema ready for insightful reporting and analysis.

---

## 📖 Project Highlights

![Data Layers](https://github.com/Sonawane-Karan26/DataWareHouse_using_SQLServer/blob/main/docs/data_architecture.png)

![Data Layers](https://github.com/Sonawane-Karan26/DataWareHouse_using_SQLServer/blob/main/datasets/Data_flow.png)

![Data Layers](https://github.com/Sonawane-Karan26/DataWareHouse_using_SQLServer/blob/main/datasets/Data_integration.png)

Here’s what this project covers:

- **Data Design**: Implementing a multi-layered data warehouse using Medallion Architecture.
- **ETL Workflows**: Building robust extract-transform-load pipelines from raw files to structured tables.
- **Data Modeling**: Crafting efficient star schemas with dimension and fact tables tailored for analytical use.
- **Insights & Visualization**: Leveraging SQL to generate meaningful insights for key business questions.

---

## 🛠️ Tools & Technologies

- **Datasets**: Source data provided in CSV format.
- **SQL Server Express**: Lightweight database engine for development.
- **SQL Server Management Studio (SSMS)**: GUI for writing and executing SQL queries.
- **GitHub**: Version control and collaboration through Git repositories.
- **Draw.io**: Visual documentation for data flow, architecture, and schema designs.

---

## 🚧 Project Requirements

### 🔧 Data Engineering Goals

**Objective**: Build a modern data warehouse using SQL Server to unify ERP and CRM data into a cohesive model for analytical use.

**Specifications**:
- **Data Ingestion**: Import data from two source systems (ERP & CRM).
- **Data Cleaning**: Resolve inconsistencies and ensure quality before analysis.
- **Data Integration**: Merge datasets into a comprehensive, analysis-ready model.
- **Scope**: Focus on current data (no historical tracking needed).
- **Documentation**: Clearly document the data model for both technical and non-technical stakeholders.

---

### 📊 Data Analysis Goals

**Objective**: Generate impactful SQL-based reports to answer critical business questions such as:

- How do customers behave across touchpoints?
- Which products drive performance?
- What sales patterns are emerging?

These insights help inform strategy and optimize decision-making.

---

## 📂 Project Structure
```bash
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│  ├── Data_flow.png                    # How the data flows through the layers
│  ├── Data_integration.png             # How the data is integrated through each layer
│  ├── layers.png                       # Describes the layers
│  ├── layers_working.png               # Shows all different techniquies and methods of ETL
│  ├── layers.md                        # How the data flows through the layers
│
├── docs/                               # Project documentation and architecture details
│   ├── data_architecture.png           # Shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_model.drawio               # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── .gitignore                          # Files and directories to be ignored by Git
```


## ☕ Let’s Connect

Thanks for exploring this project!  
Feel free to connect, collaborate, or ask questions — I’d love to hear your thoughts and ideas!

