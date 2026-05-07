# Nashville Housing Data Cleaning (SQL)

## Overview
This repository contains a T-SQL script that cleans a Nashville housing dataset. The script standardizes dates, fills missing addresses, splits address fields, normalizes values, identifies duplicates, and removes unused columns.

## Files
- `Portfolio_project_2.sql` — data-cleaning script.
- `Nashville Housing Data for Data Cleaning.xlsx` — raw dataset.

## Requirements
- Microsoft SQL Server or another T-SQL compatible environment.
- A database with the table `Project_Portfolio_2.dbo.NashvilleHousing` loaded from the Excel file.

## Usage
1. Import `Nashville Housing Data for Data Cleaning.xlsx` into SQL Server as `Project_Portfolio_2.dbo.NashvilleHousing`.
2. Open and run `Portfolio_project_2.sql` in SQL Server Management Studio or another SQL client.

> The script updates data in place and alters the table schema. Create a backup before running it.

## Cleaning steps performed
- Standardize `SaleDate` and add `Sales_Date_Converted`.
- Populate missing `PropertyAddress` values using matching `ParcelID` rows.
- Split `PropertyAddress` into `Property_Updated_Address` and `Property_Updated_City`.
- Split `OwnerAddress` into `Owner_Updated_Address`, `Owner_Updated_City`, and `Owner_Updated_State`.
- Normalize `SoldAsVacant` values from `Y/N` to `Yes/No`.
- Identify duplicates with a `ROW_NUMBER()` CTE for review.
- Drop unused columns (`OwnerAddress`, `TaxDistrict`, `PropertyAddress`, `SaleDate`).
