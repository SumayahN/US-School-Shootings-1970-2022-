--1. Total Incidences over the years.
SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT],[Year]
FROM INCIDENT
GROUP BY [Year]

--Creating incident count table and view
DROP TABLE IF EXISTS #INCIDENT_COUNT
CREATE TABLE #INCIDENT_COUNT
([INCIDENT COUNT] INT,
[Year] nvarchar(4))

INSERT INTO #INCIDENT_COUNT
SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT],[Year]
FROM INCIDENT
GROUP BY [Year]

CREATE VIEW INCIDENT_COUNT AS
SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT],[Year]
FROM INCIDENT
GROUP BY [Year]

--2. Total Incidences per school level
SELECT [incident_ID], [School_Level], [Year]
FROM INCIDENT
WHERE [School_Level] = 'Elementary' OR [School_Level] = 'High'
OR [School_Level] = 'K-12' OR [School_Level] = 'Middle'
OR [School_Level] = 'K-8' OR [School_Level] = 'Junior High'

--Creating incidences per school level table and view
DROP TABLE IF EXISTS #SCHOOLCOUNT
CREATE TABLE #SCHOOLCOUNT
([INCIDENT COUNT] nvarchar(255),
[School Level] nvarchar(255),
[Year] nvarchar (4))

INSERT INTO #SCHOOLCOUNT
SELECT [incident_ID], [School_Level], [Year]
FROM INCIDENT
WHERE [School_Level] = 'Elementary' OR [School_Level] = 'High'
OR [School_Level] = 'K-12' OR [School_Level] = 'Middle'
OR [School_Level] = 'K-8' OR [School_Level] = 'Junior High'

CREATE VIEW [SCHOOL LEVEL COUNT] AS
SELECT [incident_ID], [School_Level], [Year]
FROM INCIDENT
WHERE [School_Level] = 'Elementary' OR [School_Level] = 'High'
OR [School_Level] = 'K-12' OR [School_Level] = 'Middle'
OR [School_Level] = 'K-8' OR [School_Level] = 'Junior High'

SELECT *
FROM [SCHOOL LEVEL COUNT]

--3. Percentage of total incides per State
Select incident_ID, State, MAX(total_incidences) as HighestIncidentCount,  Max((total_incidences/Population))*100 as PercentIncidentCount
From INCIDENT
Group by state
order by PercentPopulationInfected desc


 --4. Most common attacking period
 SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT],[Time_Period]
 FROM INCIDENT
 WHERE [Time_Period] IS NOT NULL AND [Time_Period] NOT LIKE '%ND' AND [Time_Period] NOT LIKE '%null'
 AND [Time_Period] NOT LIKE '%Unknown'
 GROUP BY [Time_Period]

 --Creating time period count table and view
DROP TABLE IF EXISTS #TIMEPERIOD_COUNT
CREATE TABLE #TIMEPERIOD_COUNT
([INCIDENT COUNT] INT,
[Time_Period] nvarchar(255))

INSERT INTO #TIMEPERIOD_COUNT
 SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT],[Time_Period]
 FROM INCIDENT
 WHERE [Time_Period] IS NOT NULL AND [Time_Period] NOT LIKE '%ND' AND [Time_Period] NOT LIKE '%null'
 AND [Time_Period] NOT LIKE '%Unknown'
 GROUP BY [Time_Period]

CREATE VIEW TIMEPERIOD_COUNT AS
 SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT],[Time_Period]
 FROM INCIDENT
 WHERE [Time_Period] IS NOT NULL AND [Time_Period] NOT LIKE '%ND' AND [Time_Period] NOT LIKE '%null'
 AND [Time_Period] NOT LIKE '%Unknown'
 GROUP BY [Time_Period]
 SELECT * FROM TIMEPERIOD_COUNT

--5. Causes of the shootings/Shooter motives
SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT], [Situation]
FROM INCIDENT
WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
GROUP BY [Situation]

SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT], COUNT(DISTINCT[incident_ID]) AS [newINCIDENT COUNT],[Situation]
FROM INCIDENT as i
join VICTIM as v
on i.
WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
GROUP BY [Situation]

--creating causes of shooting table
DROP TABLE IF EXISTS #SITUATION_COUNT
CREATE TABLE #SITUATION_COUNT
([INCIDENT COUNT] INT,
[Situation] nvarchar(255))

INSERT INTO #SITUATION_COUNT
SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT], [Situation]
FROM INCIDENT
WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
GROUP BY [Situation]

CREATE VIEW SITUATION_COUNT AS
SELECT COUNT(DISTINCT[incident_ID]) AS [INCIDENT COUNT], [Situation]
FROM INCIDENT
WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
GROUP BY [Situation]

SELECT *
from SITUATION_COUNT

--6. shooter weapons(aligning shooters with corresponding weapons used in the shootings)
  SELECT s.[incidentid] AS [Incident ID]
  ,CASE WHEN [age] <18 THEN 'MINOR'
  WHEN [age] BETWEEN 18 AND 25 THEN '18-25'
  WHEN [age] BETWEEN 25 AND 30 THEN '25-30'
  WHEN [age] > 30 THEN 'Over 30'
  END AS [Age Grouping]
  ,[gender] AS [Gender]
  ,[schoolaffiliation] AS [School Affiliation]
  ,[weapontype] AS [Weapon Type]
  FROM SHOOTER AS s
  JOIN WEAPON AS w
  ON s.[incidentid] = w.[incidentid]

  --Creating Shooter table
  DROP TABLE IF EXISTS #SHOOTER_TABLE
 CREATE TABLE #SHOOTER_TABLE
([INCIDENT COUNT] INT,
[Age Grouping] nvarchar(25),
[School Affiliation] nvarchar(255),
[Gender] nvarchar(25),
[Weapon Type] nvarchar(255))

INSERT INTO #SHOOTER_TABLE
SELECT s.[incidentid] AS [Incident ID]
  ,CASE WHEN [age] <18 THEN 'MINOR'
  WHEN [age] BETWEEN 18 AND 25 THEN '18-25'
  WHEN [age] BETWEEN 25 AND 30 THEN '25-30'
  WHEN [age] > 30 THEN 'Over 30'
  END AS [Age Grouping]
  ,[gender] AS [Gender]
  ,[schoolaffiliation] AS [School Affiliation]
  ,[weapontype] AS [Weapon Type]
  FROM SHOOTER AS s
  JOIN WEAPON AS w
  ON s.[incidentid] = w.[incidentid]

  CREATE VIEW SHOOTER_TABLE AS
  SELECT s.[incidentid] AS [Incident ID]
  ,CASE WHEN [age] <18 THEN 'MINOR'
  WHEN [age] BETWEEN 18 AND 25 THEN '18-25'
  WHEN [age] BETWEEN 25 AND 30 THEN '25-30'
  WHEN [age] > 30 THEN 'Over 30'
  END AS [Age Grouping]
  ,[gender] AS [Gender]
  ,[schoolaffiliation] AS [School Affiliation]
  ,[weapontype] AS [Weapon Type]
  FROM SHOOTER AS s
  JOIN WEAPON AS w
  ON s.[incidentid] = w.[incidentid]
   
   --Shooters' Demographics
  --SHOOTER GENDER
  SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT_COUNT] 
  ,[Gender]
  FROM SHOOTER_TABLE
  WHERE [Gender] IS NOT NULL AND [Gender] NOT LIKE '%null'AND [Gender] NOT LIKE '%ple'
  GROUP BY [Gender]
  
  --creating shooter_gender table
  DROP TABLE IF EXISTS #SHOOTER_GENDER
  CREATE TABLE #SHOOTER_GENDER
([INCIDENT COUNT] INT,
[Gender] nvarchar(25)) 

INSERT INTO #SHOOTER_GENDER 
SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT_COUNT] 
  ,[Gender]
  FROM SHOOTER_TABLE
  WHERE [Gender] IS NOT NULL AND [Gender] NOT LIKE '%null'AND [Gender] NOT LIKE '%ple'
  GROUP BY [Gender]
  
  CREATE VIEW SHOOTER_GENDER AS
  SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT_COUNT] 
  ,[Gender]
  FROM SHOOTER_TABLE
  WHERE [Gender] IS NOT NULL AND [Gender] NOT LIKE '%null'AND [Gender] NOT LIKE '%ple'
  GROUP BY [Gender]
 
  --shooter affiliation
 SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT_COUNT] 
 ,[School Affiliation]
 FROM SHOOTER_TABLE
 WHERE [School Affiliation] IS NOT NULL AND [School Affiliation] NOT LIKE '%null'
 GROUP BY [School Affiliation]

 --creating shooter affliation
 DROP TABLE IF EXISTS #SHOOTER_AFF
 CREATE TABLE #SHOOTER_AFF
([INCIDENT COUNT] INT,
[School Affiliation] nvarchar(25)) 

INSERT INTO #SHOOTER_AFF 
SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT_COUNT] 
 ,[School Affiliation]
 FROM SHOOTER_TABLE
 WHERE [School Affiliation] IS NOT NULL AND [School Affiliation] NOT LIKE '%null'
 GROUP BY [School Affiliation]

CREATE VIEW SHOOTER_AFF AS
SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT_COUNT] 
 ,[School Affiliation]
 FROM SHOOTER_TABLE
 WHERE [School Affiliation] IS NOT NULL AND [School Affiliation] NOT LIKE '%null'
 GROUP BY [School Affiliation] 

 --Number of victims per situation/shooter motives
 SELECT COUNT(DISTINCT[incidentid]) AS [INCIDENT COUNT], [situation] AS [Situation]
 FROM VICTIM AS v
 INNER JOIN INCIDENT AS I
 ON v.[incidentid] = I.[Incident_ID]
 WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
 GROUP BY [situation]

 --Creating victims per situation
 DROP TABLE IF EXISTS #VICTIM_SITUATION
 CREATE TABLE #VICTIM_SITUATION
([INCIDENT COUNT] INT,
[Situation] nvarchar(255))

INSERT INTO #VICTIM_SITUATION
 SELECT COUNT(DISTINCT[incidentid]) AS [INCIDENT COUNT], [situation] AS [Situation]
 FROM VICTIM AS v
 INNER JOIN INCIDENT AS I
 ON v.[incidentid] = I.[Incident_ID]
 WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
 GROUP BY [situation]

 CREATE VIEW VICTIM_SITUATION AS
  SELECT COUNT(DISTINCT[incidentid]) AS [INCIDENT COUNT], [situation] AS [Situation]
 FROM VICTIM AS v
 INNER JOIN INCIDENT AS I
 ON v.[incidentid] = I.[Incident_ID]
 WHERE [Situation] IS NOT NULL AND [Situation] NOT LIKE '%null'
 GROUP BY [situation]

 SELECT *
 FROM VICTIM_SITUATION


 --VICTIM'S table
  SELECT [incidentid] AS [Incident ID]
  ,[injury] AS [Injury]
  ,[gender] AS [Gender]
  ,[race] AS [Race]
  ,CASE WHEN [age] <18 THEN 'MINOR'
  WHEN [age] BETWEEN 18 AND 25 THEN '18-25'
  WHEN [age] BETWEEN 25 AND 30 THEN '25-30'
  WHEN [age] > 30 THEN 'Over 30'
  END AS [Age Grouping]
  ,[schoolaffiliation] AS [School Affiliation]
  FROM [US School Shootings].[dbo].[VICTIM]

  --Creating Victim table
 DROP TABLE IF EXISTS #VICTIM_TABLE
 CREATE TABLE #VICTIM_TABLE
([Incident ID] nvarchar(255),
[Injury] nvarchar(255),
[Gender] nvarchar(255),
[Race] nvarchar(255),
[Age Grouping] nvarchar(255),
[School Affiliation] nvarchar(255))
  
  INSERT INTO #VICTIM_TABLE
  SELECT [incidentid] AS [Incident ID]
  ,[injury] AS [Injury]
  ,[gender] AS [Gender]
  ,[race] AS [Race]
  ,CASE WHEN [age] <18 THEN 'MINOR'
  WHEN [age] BETWEEN 18 AND 25 THEN '18-25'
  WHEN [age] BETWEEN 25 AND 30 THEN '25-30'
  WHEN [age] > 30 THEN 'Over 30'
  END AS [Age Grouping]
  ,[schoolaffiliation] AS [School Affiliation]
  FROM [US School Shootings].[dbo].[VICTIM]

  CREATE VIEW VICTIM_TABLE AS
 SELECT [incidentid] AS [Incident ID]
  ,[injury] AS [Injury]
  ,[gender] AS [Gender]
  ,[race] AS [Race]
  ,CASE WHEN [age] <18 THEN 'MINOR'
  WHEN [age] BETWEEN 18 AND 25 THEN '18-25'
  WHEN [age] BETWEEN 25 AND 30 THEN '25-30'
  WHEN [age] > 30 THEN 'Over 30'
  END AS [Age Grouping]
  ,[schoolaffiliation] AS [School Affiliation]
  FROM [US School Shootings].[dbo].[VICTIM]

  SELECT *
  FROM VICTIM_TABLE

  SELECT COUNT(DISTINCT[Incident ID]) AS [INCIDENT COUNT], [Age Grouping]
  FROM VICTIM_TABLE
  WHERE [Age Grouping] IS NOT NULL
  GROUP BY [Age Grouping]

  --victims vs shooter motives
  select s.Situation, s.[INCIDENT COUNT] as [ShooterMotiveCount], v.[INCIDENT COUNT] AS [VictimsPerMotive]
  from SITUATION_COUNT as s
  join VICTIM_SITUATION as v
  on s.Situation = v.Situation

--
 With Vic (State, City, Date, year, Incident_ID,RollingVictimIncidents)
as
(
Select State, City, Date, year, incident_id
, SUM(CONVERT(int,Incident_ID)) OVER (Partition by a.State Order by a.state, a.Date) as RollingVictimIncidents
From INCIDENT AS a
Join VICTIM AS v
	On a.Incident_ID = v.incidentid
where a.state is not null 
)

	  

