-- Cleaning The Data 

Select *
From Project_Portfolio_2.dbo.NashvilleHousing


--Standardize Date Format 

Select SaleDate, Sales_Date_Converted , CONVERT(date, SaleDate)
From Project_Portfolio_2.dbo.NashvilleHousing

Update NashvilleHousing
set SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing 
Add Sales_Date_Converted Date;

Update NashvilleHousing
set Sales_Date_Converted = CONVERT(Date, SaleDate)
 

 -- Populate Property Address Data 

 Select *
 From Project_Portfolio_2.dbo.NashvilleHousing
-- Where PropertyAddress is null
order by ParcelID

Select A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress, B.PropertyAddress)
From Project_Portfolio_2.dbo.NashvilleHousing A
Join Project_Portfolio_2.dbo.NashvilleHousing B
	on A.ParcelID = B.ParcelID
	And A.[UniqueID ] <> B.[UniqueID ]
where A.PropertyAddress is null

Update A
Set PropertyAddress = B.PropertyAddress
From Project_Portfolio_2.dbo.NashvilleHousing A
Join Project_Portfolio_2.dbo.NashvilleHousing B
	on A.ParcelID = B.ParcelID
	And A.[UniqueID ] <> B.[UniqueID ]
where A.PropertyAddress is null

--One more way to do it as it is done in the upper para
--Update A
--Set PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
--From Project_Portfolio_2.dbo.NashvilleHousing A
--Join Project_Portfolio_2.dbo.NashvilleHousing B
--	on A.ParcelID = B.ParcelID
--	And A.[UniqueID ] <> B.[UniqueID ]
--where A.PropertyAddress is null



--Breaking out Address into Individual columns (Address, City, State)

Select PropertyAddress
From Project_Portfolio_2.dbo.NashvilleHousing
--Where PorpertyAddress is null
--order by ParcelID


Select 
SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address
from Project_Portfolio_2.dbo.NashvilleHousing

Alter TABLE NashvilleHousing 
Add Property_Updated_Address Nvarchar(255);

Update NashvilleHousing 
Set Property_Updated_Address =  SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1)

Alter TABLE NashvilleHousing 
Add Property_Updated_City Nvarchar(255);

Update NashvilleHousing 
Set Property_Updated_City =  SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))

Select * 
From Project_Portfolio_2.dbo.NashvilleHousing


--Doing similar to substring but by using parsename

select 
PARSENAME(Replace(OwnerAddress, ',', '.'  ), 3)  ,
PARSENAME(Replace(OwnerAddress, ',', '.'  ), 2)  ,
PARSENAME(Replace(OwnerAddress, ',', '.'  ), 1) 


From Project_Portfolio_2.dbo.NashvilleHousing

Alter TABLE NashvilleHousing 
Add Owner_Updated_Address Nvarchar(255);

Update NashvilleHousing 
Set Owner_Updated_Address =  PARSENAME(Replace(OwnerAddress, ',', '.'  ), 3)

Alter TABLE NashvilleHousing 
Add Owner_Updated_City Nvarchar(255);

Update NashvilleHousing 
Set Owner_Updated_City =  PARSENAME(Replace(OwnerAddress, ',', '.'  ), 2)

Alter TABLE NashvilleHousing 
Add Owner_Updated_State Nvarchar(255);

Update NashvilleHousing 
Set Owner_Updated_State =  PARSENAME(Replace(OwnerAddress, ',', '.'  ), 1)

Select * 
From Project_Portfolio_2.dbo.NashvilleHousing



-- Change Y and N to Yes and No in "Sold as Vacant" field

select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Project_Portfolio_2.dbo.NashvilleHousing
group by SoldAsVacant
order by 2

Select SoldAsVacant 
,Case when SoldAsVacant = 'Y' THEN 'Yes'
	  When SoldAsVacant = 'N' THEN 'No'
	  Else SoldAsVacant
	  End
From Project_Portfolio_2.dbo.NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = 
	  Case when SoldAsVacant = 'Y' THEN 'Yes'
	  When SoldAsVacant = 'N' THEN 'No'
	  Else SoldAsVacant
	  End


-- Remove Duplicates 

with RowNumCTE as(

Select *,
	Row_number() over(
	partition by ParcelID,
				 PropertyAddress, 
				 SalePrice, 
				 SaleDate,
				 LegalReference 
				 Order by 
					UniqueID
					) row_num


 From Project_Portfolio_2.dbo.NashvilleHousing
 --order by ParcelID
 )

-- Delete 
Select *
From RowNumCTE
Where row_num > 1 
order by PropertyAddress
 

-- Delete Unused Columns 

Select * 
From Project_Portfolio_2.dbo.NashvilleHousing

Alter table Project_Portfolio_2.dbo.NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress

Alter table Project_Portfolio_2.dbo.NashvilleHousing
drop column SaleDate

