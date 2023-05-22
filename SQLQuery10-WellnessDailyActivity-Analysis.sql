--- FOR SOME REASONS, THE COLUMNS ARE NOT IN THE RIGHT DATA TYPES SO I WILL BE DOING A LOT OF CLEANING, ADDING AND DROPPING, AND RENAMING COLUMNS

SELECT *
FROM SQLPractice.dbo.DailyActivityMerged

--- FOR ACTIVITY_DATE
ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD ActivityDate Date;

UPDATE SQLPractice.dbo.DailyActivityMerged
SET ActivityDate = CAST(Activity_Date AS Date)

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Activity_Date

--- FOR TOTAL_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD TotalDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET TotalDistance = CAST(Total_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Total_Distance

--- FOR TRACKER_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD TrackerDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET TrackerDistance = CAST(Tracker_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Tracker_Distance

--- FOR LOGGED_ACTIVITIES_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD LoggedActivitiesDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET LoggedActivitiesDistance = CAST(Logged_Activities_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Logged_Activities_Distance

--- FOR VERY_ACTIVE_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD VeryActiveDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET VeryActiveDistance = CAST(Very_Active_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Very_Active_Distance

--- FOR MODERATELY_ACTIVE_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD ModeratelyActiveDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET ModeratelyActiveDistance = CAST(Moderately_Active_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Moderately_Active_Distance

--- FOR LIGHT_ACTIVE_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD LightActiveDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET LightActiveDistance = CAST(Light_Active_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Light_Active_Distance

--- FOR SEDENTARY_ACTIVE_DISTANCE

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD SedentaryActiveDistance Decimal(16, 14)

UPDATE SQLPractice.dbo.DailyActivityMerged
SET SedentaryActiveDistance = CAST(Sedentary_Active_Distance AS Decimal(16, 14))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN Sedentary_Active_Distance

--- FOR THE ID COLUMN

SELECT LEN(ID)
FROM SQLPractice.dbo.DailyActivityMerged

SELECT LEN(CAST(ID AS BIGINT))
FROM SQLPractice.dbo.DailyActivityMerged

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD UserID BIGINT;

UPDATE SQLPractice.dbo.DailyActivityMerged
SET UserID = (CAST(ID AS BIGINT))

ALTER TABLE SQLPractice.dbo.DailyActivityMerged
DROP COLUMN ID

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---                                                                   ANALYSIS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAX TOTAL STEPS
SELECT MAX(Total_Steps) MaxSteps
FROM SQLPractice.dbo.DailyActivityMerged

SELECT MIN(Total_Steps) MinSteps
FROM SQLPractice.dbo.DailyActivityMerged

--- 1. What is the average number of total steps taken by users in the sample? Compare average steps by days of the week and see if there’s a trend or pattern.
---    Compare by date too and see what date has the highest average

-- AVERAGE OF TOTAL STEPS TAKEN

SELECT ROUND(AVG(Total_Steps), 0) AvgSteps_PerDay
FROM SQLPractice.dbo.DailyActivityMerged


--- AVERAGE STEPS BY DAYS OF THE WEEK

SELECT ROUND(AVG(Total_Steps), 0) AvgSteps_PerDay, DATENAME(weekday, ActivityDate) Day_Of_Week
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY DATENAME(weekday, ActivityDate)
ORDER BY ROUND(AVG(Total_Steps), 0) DESC


--- AVERAGE STEPS BY DATE RECORDED

SELECT ROUND(AVG(Total_Steps), 0) AvgSteps_ByDate, ActivityDate
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY ActivityDate
ORDER BY ROUND(AVG(Total_Steps), 0) DESC


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---2. How does the distance total distance tracked by the device compare to the distance logged in by the users?


--- DISTANCE TRACKED BY THE DEVICE

SELECT *
FROM SQLPractice.dbo.DailyActivityMerged
WHERE LoggedActivitiesDistance > 0

SELECT COUNT(DISTINCT UserID)
FROM SQLPractice.dbo.DailyActivityMerged
WHERE LoggedActivitiesDistance > 0


-- DISTANCE LOGGED IN BY USERS

SELECT *
FROM SQLPractice.dbo.DailyActivityMerged
WHERE TrackerDistance > 0

SELECT COUNT(DISTINCT UserID)
FROM SQLPractice.dbo.DailyActivityMerged
WHERE TrackerDistance > 0


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---3. What percentage of users are meeting say at least 1000 steps a day target? Based on their total steps.

SELECT *
FROM SQLPractice.dbo.DailyActivityMerged

SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM SQLPractice.dbo.DailyActivityMerged), 2) AS percentage
FROM SQLPractice.dbo.DailyActivityMerged
WHERE Total_Steps >= 10000


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---4. What is the average amount of time spent in sedentary activities per day by users?
---A. What is the average number of very active minutes, fairly active minutes, lightly active minutes and sedentary minutes for users?

SELECT *
FROM SQLPractice.dbo.DailyActivityMerged


--- AVERAGE TIME(IN MINUTES) SPENT IN SEDENTARY ACTIVITIES BY USERS BY DAY

SELECT DATENAME(weekday, ActivityDate) DayOfWeek, ROUND(AVG(Sedentary_Minutes), 0) AvgSedentaryMinutes
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY DATENAME(weekday, ActivityDate)
ORDER BY ROUND(AVG(Sedentary_Minutes), 0) DESC

--- AVERAGE TIME(IN MINUTES) SPENT IN ALL 4 ACTIVITY LEVELS BY USERS

SELECT ROUND(AVG(Very_Active_Minutes), 0) Avg_VeryActiveMinutes, 
	   ROUND(AVG(Fairly_Active_Minutes), 0) Avg_FairlyActiveMinutes, 
	   ROUND(AVG(LightlyActiveMinutes), 0) Avg_LightlyActiveMinutes,
	   ROUND(AVG(Sedentary_Minutes), 0) AvgSedentaryMinutes
FROM SQLPractice.dbo.DailyActivityMerged

--- AVERAGE TIME(IN MINUTES) SPENT IN ALL 4 ACTIVITY LEVELS BY USERS BY DAY

SELECT DATENAME(weekday, ActivityDate) DayOfWeek,
	   ROUND(AVG(Very_Active_Minutes), 0) Avg_VeryActiveMinutes, 
	   ROUND(AVG(Fairly_Active_Minutes), 0) Avg_FairlyActiveMinutes, 
	   ROUND(AVG(LightlyActiveMinutes), 0) Avg_LightlyActiveMinutes,
	   ROUND(AVG(Sedentary_Minutes), 0) AvgSedentaryMinutes
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY DATENAME(weekday, ActivityDate)
ORDER BY DATENAME(weekday, ActivityDate)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---5. How do users who engage in more very active minutes compare to those who engage in more light active minutes in terms of total steps and calories burned?
---   Are there any correlations between activity levels, total steps and calories burned?


--- THIS QUESTION WAS ANSWERED ON GOOGLE SHEETS AND THE DOCUMENT WILL BE ATTACHED ALONGSIDE THIS IN MY GITHUB







