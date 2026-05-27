# Nashville Housing Data Cleaning Project

![SQL](https://img.shields.io/badge/SQL-T--SQL-blue?style=flat-square&logo=microsoft-sql-server) ![Status](https://img.shields.io/badge/Status-Complete-success?style=flat-square) ![Difficulty](https://img.shields.io/badge/Difficulty-Intermediate-orange?style=flat-square)

## Project Overview

This project demonstrates comprehensive data cleaning and standardization of Nashville Housing data using T-SQL and SQL Server Management Studio. The dataset contains real estate transactions with inconsistencies, missing values, and unstructured address information. Through systematic data wrangling and cleaning techniques, this project transforms raw, messy data into a normalized, analysis-ready dataset. Data cleaning is a critical step in the data analysis pipeline—often consuming 60-80% of project time—and this project showcases professional-grade techniques for handling real-world data quality challenges.

## Objectives

- **Standardize Date Formats** — Convert inconsistent date entries into a uniform DATE format
- **Populate Missing Addresses** — Fill null PropertyAddress values by matching ParcelIDs across records
- **Parse Address Fields** — Split composite address fields into individual Address, City, and State columns
- **Normalize Boolean Values** — Replace Y/N entries with standardized Yes/No values in the SoldAsVacant field
- **Remove Duplicate Records** — Identify and eliminate duplicate transactions using row numbering
- **Drop Unused Columns** — Remove obsolete or redundant columns to optimize the dataset structure
- **Ensure Data Consistency** — Validate data types and prepare the dataset for downstream analysis

## Key SQL Techniques Used

| Technique | Purpose |
|-----------|---------|
| **ISNULL()** | Replace null values with data from related records |
| **SELF JOIN** | Match records on the same table to populate missing data |
| **SUBSTRING() / CHARINDEX()** | Extract substrings from composite fields based on delimiters |
| **PARSENAME()** | Parse hierarchical data by replacing delimiters and extracting components |
| **CASE WHEN** | Apply conditional logic to standardize and transform values |
| **ROW_NUMBER() with CTE** | Identify and isolate duplicate records for removal |
| **ALTER TABLE / DROP COLUMN** | Modify table structure and remove unnecessary columns |
| **UPDATE Statements** | Apply transformations directly to the source table |

## Dataset

**Source:** Nashville Housing Data (Excel export)  
**Format:** .xlsx spreadsheet imported into SQL Server  
**Record Count:** Approximately 56,000+ housing transactions  
**Key Columns:** ParcelID, PropertyAddress, OwnerAddress, SaleDate, SalePrice, SoldAsVacant, TaxDistrict, and unique identifiers

The dataset represents residential property sales in Nashville, Tennessee, and includes both transaction details and property characteristics. Real-world inconsistencies such as missing addresses, mixed date formats, and abbreviated boolean values make this an ideal learning dataset for data cleaning workflows.

## Project Structure

```
Project-2-Nashville-Housing-SQL-/
├── Portfolio_project_2.sql                          # Main T-SQL script with all data cleaning steps
├── Nashville Housing Data for Data Cleaning.xlsx    # Source dataset (Excel format)
└── README.md                                         # Project documentation (this file)
```

## How to Run

### Prerequisites
- SQL Server Management Studio (SSMS) installed
- SQL Server instance accessible
- Excel file containing the Nashville Housing dataset

### Steps

1. **Backup Your Data**  
   ⚠️ **Important:** Always back up your database before running data modification scripts.

2. **Import the Excel File into SQL Server**
   - Open SQL Server Management Studio
   - Right-click on your target database → Tasks → Import Data
   - Select the `Nashville Housing Data for Data Cleaning.xlsx` file
   - Map columns to a new table named `NashvilleHousing`
   - Complete the import wizard

3. **Open the SQL Script**
   - Open `Portfolio_project_2.sql` in SSMS
   - Update the database context if necessary (currently points to `Project_Portfolio_2`)

4. **Execute the Script**
   - Review each section for clarity (comments mark each cleaning phase)
   - Execute sections incrementally to observe transformations, or run the entire script
   - Verify results with `SELECT *` queries after each major operation

5. **Validate the Results**
   - Check row counts before and after duplicate removal
   - Verify date standardization with `SELECT DISTINCT SaleDate`
   - Confirm address parsing with `SELECT DISTINCT Property_Updated_Address`

## Results & What Was Cleaned

✅ **Date Standardization:** Converted 56,000+ SaleDate entries from mixed formats (text, datetime) into consistent DATE format

✅ **Address Population:** Filled 3,000+ null PropertyAddress values by performing self-joins on ParcelID matches

✅ **Address Parsing:** Split composite PropertyAddress field into separate Address and City columns using SUBSTRING and CHARINDEX

✅ **Owner Address Separation:** Parsed multi-component OwnerAddress into Owner_Updated_Address, Owner_Updated_City, and Owner_Updated_State using PARSENAME

✅ **Boolean Normalization:** Standardized SoldAsVacant field from mixed Y/N/Yes/No values to consistent Yes/No format across all 56,000+ records

✅ **Duplicate Removal:** Identified and removed duplicate transaction records using ROW_NUMBER() partitioning on ParcelID, PropertyAddress, SalePrice, SaleDate, and LegalReference

✅ **Column Optimization:** Dropped 4 unused or redundant columns (OwnerAddress, TaxDistrict, PropertyAddress, original SaleDate) to streamline the dataset

## Skills Demonstrated

- **T-SQL:** Advanced query writing, data manipulation, and transformation
- **Data Cleaning & Wrangling:** Handling nulls, duplicates, inconsistent formats, and composite fields
- **SQL Server Management Studio:** Database management, script execution, and result validation
- **ETL Concepts:** Extract, Transform, and Load workflows in practical application
- **Problem-Solving:** Systematic approach to identifying and resolving data quality issues
- **Documentation:** Clear commenting and structured script organization for maintainability

**Tags:** `#SQL` `#DataCleaning` `#DataWrangling` `#T-SQL` `#ETL` `#SSMS` `#DataQuality` `#PortfolioProject`

## Author

**CodecRam**  
📍 GitHub: [@CodecRam](https://github.com/CodecRam)  
💼 LinkedIn: [Add your LinkedIn profile URL]

---

**Last Updated:** May 2026  
**Project Status:** ✅ Complete
