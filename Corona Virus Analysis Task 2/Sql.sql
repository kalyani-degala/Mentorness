
  -- Q1. Write a code to check NULL values
 SELECT *
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Where Province is null  or
 CountryRegion is null or
 Latitude is null or
 Longitude is null or
 [Date] is null or
 Confirmed is null or
 Deaths is null or
 Recovered is  null

--Q2. If NULL values are present, update them with zeros for all columns. 
UPDATE [dbo].[CoronaVirusDataset]
SET Province = COALESCE(Province, '0'),
    CountryRegion = COALESCE(CountryRegion, '0'),
    Latitude = COALESCE(Latitude, 0),
    Longitude = COALESCE(Longitude, 0),
	[Date] = COALESCE([Date], CONVERT(DATE, '0/00/0000', 101)),
	Confirmed = COALESCE(Confirmed, 0),
	Deaths = COALESCE(Deaths, 0),
	Recovered = COALESCE(Recovered, 0)
Where Province is null  or
 CountryRegion is null or
 Latitude is null or
 Longitude is null or
 [Date] is null or
 Confirmed is null or
 Deaths is null or
 Recovered is  null

-- Q3. check total number of rows
SELECT COUNT(*) as Count 
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]

 -- Q4. Check what is start_date and end_date
 Select top(1) [Date] as StartDate
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Order By [Date] asc

  Select top(1) [Date] as EndDate
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Order By [Date] desc


 -- Q5. Number of month present in dataset

 SELECT COUNT(*) AS Total_Months
 FROM (
 Select MONTH([Date]) AS Months
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group By MONTH([Date])
)  AS CoronaMonths

-- Q6. Find monthly average for confirmed, deaths, recovered
 Select DATEPART(MONTH, [Date]) as Month,
 AVG(Confirmed) as Avg_Confirmed, 
 AVG(deaths) as Avg_deaths,
 AVG(recovered) as Avg_recovered
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 GROUP BY DATEPART(MONTH, [Date])


 -- Q7. Find most frequent value for confirmed, deaths, recovered each month 

SELECT 
    DATEPART(MONTH, [Date]) AS Month,
    MAX(confirmed) AS Most_Frequent_Confirmed,
    MAX(deaths) AS Most_Frequent_Deaths,
    MAX(recovered) AS Most_Frequent_Recovered
FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
GROUP BY DATEPART(MONTH, [Date]);

-- Q8. Find minimum values for confirmed, deaths, recovered per year

 Select DATEPART(YEAR, [Date]) As Year,
 min(Confirmed) as Min_Confirmed, 
 min(deaths) as min_deaths,
 min(recovered) as min_recovered
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group by DATEPART(YEAR, [Date])


 -- Q9. Find maximum values of confirmed, deaths, recovered per year
 Select   DATEPART(YEAR, [Date]) As Year,
 MAX(Confirmed) as Max_Confirmed, 
 MAX(deaths) as Max_deaths,
 MAX(recovered) as Max_recovered
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group by DATEPART(YEAR, [Date])

 -- Q10. The total number of case of confirmed, deaths, recovered each month
 Select   DATEPART(Month, [Date]) As Month,
 SUM(Confirmed) as Total_Confirmed, 
 SUM(deaths) as Total_deaths,
 SUM(recovered) as Total_recovered
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group by DATEPART(MONTH, [Date])
 order by DATEPART(MONTH, [Date])

 -- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    COUNT(*) AS Total_Confirmed_Cases,
    AVG(confirmed) AS Average_Confirmed_Cases,
    VAR(confirmed) AS Variance_Confirmed_Cases,
    STDEV(confirmed) AS Standard_Deviation_Confirmed_Cases
FROM  [CoronaVirus].[dbo].[CoronaVirusDataset];


-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    DATEPART(MONTH, [Date]) AS Month,
    COUNT(*) AS Total_Confirmed_Cases,
    AVG(confirmed) AS Average_Confirmed_Cases,
    VAR(confirmed) AS Variance_Confirmed_Cases,
    STDEV(confirmed) AS Standard_Deviation_Confirmed_Cases,
    SUM(deaths) AS Total_Death_Cases
FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
GROUP BY DATEPART(MONTH, [Date])
Order By DATEPART(MONTH, [Date])


-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )

SELECT 
    COUNT(*) AS Total_Confirmed_Cases,
    AVG(confirmed) AS Average_Confirmed_Cases,
    VAR(confirmed) AS Variance_Confirmed_Cases,
    STDEV(confirmed) AS Standard_Deviation_Confirmed_Cases,
    SUM(recovered) AS Total_Recovered_Cases
FROM [CoronaVirus].[dbo].[CoronaVirusDataset];


-- Q14. Find Country having highest number of the Confirmed case
Select top 1 CountryRegion,
  SUM(Confirmed) as Total_Confirmed
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group by CountryRegion
 Order by Total_Confirmed desc


-- Q15. Find Country having lowest number of the death case
Select top 1 CountryRegion,
  SUM(Deaths) as Total_Deaths
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group by CountryRegion
 Order by Total_Deaths asc


-- Q16. Find top 5 countries having highest recovered case

Select top 5 CountryRegion,
  SUM(Recovered) as Total_Recovered
 FROM [CoronaVirus].[dbo].[CoronaVirusDataset]
 Group by CountryRegion
 Order by Total_Recovered desc