# BellaBeat-Wellness

> [Introduction](https://github.com/Afokoghene/BellaBeat-Wellness/#introduction) <br>
> [Problem Statement](https://github.com/Afokoghene/BellaBeat-Wellness/#problem-statement) <br>
> [Skills Demonstrated](https://github.com/Afokoghene/BellaBeat-Wellness/#skills-demonstrated) <br>
> [Data Sourcing](https://github.com/Afokoghene/BellaBeat-Wellness/#data-sourcing) <br>
> [Data Assessment and Transformation](https://github.com/Afokoghene/BellaBeat-Wellness/#data-assessment-and-transformation) <br>
> [Data Analysis](https://github.com/Afokoghene/BellaBeat-Wellness/#data-analysis) <br>
> [Data Visualization](https://github.com/Afokoghene/BellaBeat-Wellness/#data-visualization) <br>
> [Insights and Recommendations](https://github.com/Afokoghene/BellaBeat-Wellness/#insights_and_recommendations) <br>

## Introduction

This analysis is on the dataset that was provided me for the capstone project of my Google Data Analytics course. 
This Kaggle data set contains personal fitness tracker fitbit users. These users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring. It includes information about daily activity, steps, and heart rate that can be used to explore users’ habits.

A lot of people do believe taking long walks, jogging, running or participating in very active physical activities can help burn calories and some other believe it can help them lose weight, we'll find out at the end of this analysis and the popular belief will or will not be be backed by data.

The main task is to determine/explore how these FitBit users do use the company's fitness devices and use insisghts gained give informed decidion on how BellaBeat Wellness can improve its marketing strategy.

## Problem Statement

For this analysis, the following questions were drawn to see get a closer look at how these users go about their day to day activities and also how they use fitness device

1. What is the average number of total steps taken by users in the sample? Compare average steps by days of the week and see if there’s a trend or pattern. Compare by date and see what date has the highest average.
2. How does the distance total distance tracked by the bellabeat product compare to the distance logged in by the users?
3. What percentage of users are meeting say at least 10,000 steps a day? Based on their total steps
4. What is the average amount of time spent in sedentary activities per day by users?
- What is the average number of very active minutes, fairly active minutes, lightly active minutes and sedentary minutes for users?
5. How do users who engage in more very active minutes compare to those who engage in more light active minutes in terms of total steps and calories burned? 
- Are there any correlations between activity levels, total steps and calories burned?

## Skills Demonstrated
- Cleaning, transformation of data to a useable structure and analysis of cleaned data using SQL.

## Data Sourcing
The dataset was obtained from the Google Data Analytics Course as its captsone project. It is sourced to be origially from Kaggle and can be found [here](https://www.kaggle.com/arashnic/fitbit)

## Data Assessment and Transformation
### Assessment
The dataset was first asessed on Google sheets where I made some changes to the column names for easy referencing on Microsoft SQL server as I was going to carry out the analysis on there.
The dataset contains 940 rows and 15 columns, it also containes 15 unique UserID and activities are recorded fror each User for a period of 31 days.

Below are brief explanations of the type of data that each column contains,  for better understanding of the dataset.

1. UserID: This column contains a unique identifier for each user, such as a user ID or serial number.
2. Activity Date: This column contains the date on which the user's physical activity was tracked, logged, or recorded.
3. Total Steps: This column contains the total number of steps taken by the user on the given date, as recorded by the device's step counter.
4. Total Distance: This column contains the total distance traveled by the user on the given date, as estimated by the device's sensors based on the user's steps taken and stride length.
5. Tracker Distance: This column contains the distance traveled by the user on the given date as recorded by the device itself.
6. Logged Activities Distance: This column contains the distance traveled by the user on the given date during manually logged activities.
7. Very Active Distance: This column contains the distance traveled by the user on the given date while engaging in activities that require high levels of physical exertion, such as running or playing sports.
8. Moderately Active Distance: This column contains the distance traveled by the user on the given date while engaging in activities that require moderate levels of physical exertion, such as brisk walking or light cycling.
9. Light Active Distance: This column contains the distance traveled by the user on the given date while engaging in activities that require light physical exertion, such as slow walking or standing.
10. Sedentary Active Distance: This column contains the distance traveled by the user on the given date while engaging in activities that involve very little movement, such as sitting or lying down.
11. Very Active Minutes: This column contains the total number of minutes during which the user engaged in high-intensity physical activity on the given date.
12. Fairly Active Minutes: This column contains the total number of minutes during which the user engaged in moderate-intensity physical activity on the given date.
13. Lightly Active Minutes: This column contains the total number of minutes during which the user engaged in low-intensity physical activity on the given date.
14. Sedentary Minutes: This column contains the total number of minutes during which the user was sedentary, such as sitting or lying down, on the given date.
15. Calories: This column contains the total number of calories burned by the user on the given date, as estimated by the device based on their physical activity levels and other biometric data

### Transformation
After accessing the dataset in Google Sheets, I saved and downloaded it to go open in MS SQL Server for the analysis process properly.
For some reasons not known to me, the data type for the whole datset defaulted to _NVARCHAR_  which was not suitable for the analysis process at all. So I took the following steps to get them in the format needed for the analysis

1. I altered the table and created a new column for Activity Date, Total Distance, Tracker Distance, Logged Activities Distance, Very Active Distance, Moderately Active Distance, Lightly Active Distance, Sedentary Active Distance
2. I then updated the newly created columns and set them to the column I wanted to populate them from but using the _CAST_ function to get them in the fromat needed for each.
3. All columns with the word "Distance" attached were converted to decimals as that is the appropraite data type for distance measured.

Next, I checked the length of the UserID column and noticed there were trailing and leading spaces so I had create a new column or the UserID, update and populate from the old column and at the same time convert to _BIGINT_ datatype and the spacces were automatically trimmed. Below is the query used to achieve that
```sql
ALTER TABLE SQLPractice.dbo.DailyActivityMerged
ADD UserID BIGINT;

UPDATE SQLPractice.dbo.DailyActivityMerged
SET UserID = (CAST(ID AS BIGINT))
```
## Data Analysis
After asseesing and transforming the data to formats that provide ease of usage and analysis, I moved on to analyze the data to answer the questions as stated in the problem statement.

- Maximum Total Daily Steps by users
```sql
SELECT MAX(Total_Steps) MaxSteps
FROM SQLPractice.dbo.DailyActivityMerged
```
| MaxSteps |
|----------|
|   36019  |

- Minimum Total Daily Steps by users
```sql
SELECT MIN(Total_Steps) MinSteps
FROM SQLPractice.dbo.DailyActivityMerged
```
| MinSteps |
|----------|
|    0     |

---

1.  What is the average number of total steps taken by users in the sample? Compare average steps by days of the week and see if there’s a trend or pattern. Compare by date too and see what date has the highest average

- Average of Total Steps Taken Daily by users
```sql
SELECT ROUND(AVG(Total_Steps), 0) AvgSteps_PerDay
FROM SQLPractice.dbo.DailyActivityMerged
```
| AvgSteps_PerDay |
|-----------------|
|      7638       |

- Average steps by days of the week. <br>
The query and table below shows the average of daily steps by users and grouping by the day of the week, that is the average daily steps taken by users for each day of the week for the period recorded in the sample
```sql
SELECT ROUND (AVG (Total_Steps), 0) AvgSteps_PerDay, DATENAME (weekday, ActivityDate) Day_Of_Week
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY DATENAME (weekday, ActivityDate)
ORDER BY ROUND (AVG (Total_Steps), 0) DESC
```
| AvgSteps_PerDay | Day_Of_Week    |
|-----------------|-----------------|
|   8153          |     Saturday    |
|    8125         |       Tuesday   |
|    7781         |       Monday   |
|    7559         |        Wednesday  |
|   7448          |      Friday    |
|   7406          |        Thursday  |
|   6933          |      Sunday    |


- Average steps by date recorded. <br>
The query and table below is set to show the average of total steps taken by users for all the days recorded in the dataset and it is ordered in descending order.
```sql
SELECT ROUND(AVG(Total_Steps), 0) AvgSteps_ByDate, ActivityDate
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY ActivityDate
ORDER BY ROUND(AVG(Total_Steps), 0) DESC
```

| AvgSteps_ByDate   | ActivityDate       |
|------|------------|
| 8731 | 2016-05-05 |
| 8679 | 2016-04-16 |
| 8559 | 2016-05-03 |
| 8348 | 2016-04-23 |
| 8346 | 2016-04-30 |
| 8249 | 2016-05-09 |
| 8244 | 2016-04-21 |
| 8237 | 2016-04-12 |
| 8163 | 2016-04-20 |
| 8079 | 2016-04-27 |
| 8049 | 2016-04-19 |
| 7951 | 2016-05-10 |
| 7933 | 2016-04-25 |
| 7897 | 2016-04-18 |
| 7834 | 2016-04-26 |
| 7744 | 2016-04-14 |
| 7594 | 2016-04-28 |
| 7534 | 2016-04-15 |
| 7520 | 2016-05-11 |
| 7493 | 2016-05-06 |
| 7446 | 2016-04-22 |
| 7394 | 2016-04-24 |
| 7322 | 2016-04-29 |
| 7199 | 2016-04-13 |
| 7151 | 2016-05-07 |
| 7049 | 2016-05-02 |
| 7049 | 2016-05-08 |
| 6896 | 2016-05-01 |
| 6764 | 2016-05-04 |
| 6409 | 2016-04-17 |
| 3482 | 2016-05-12 |

---

2. How does the distance total distance tracked by the device compare to the distance logged in by the users?

- Count of users that manually logged in their activities
```sql
SELECT COUNT(DISTINCT UserID) 
FROM SQLPractice.dbo.DailyActivityMerged
WHERE LoggedActivitiesDistance > 0
```
|  (No column name)   |
|-----------------------------------|
|             4                     |

- Count of users that the tracker did track their distances and activities
```sql
SELECT COUNT(DISTINCT UserID) Count_TrackerDistance
FROM SQLPractice.dbo.DailyActivityMerged
WHERE TrackerDistance > 0
```
|  (No column name)                |
|-----------------------------------|
|             33                     |

From the two tables above, it can be see that only 4 users actually logged in their activities manaually, comparing that to the number od users that the device tracked their distances and activities automatically. It can be said that users do not utilize the logged in activities feature of the device.

---

3. What percentage of users are meeting say at least 1000 steps a day target? Based on their total steps.
```sql
SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM SQLPractice.dbo.DailyActivityMerged), 2) AS percentage
FROM SQLPractice.dbo.DailyActivityMerged
WHERE Total_Steps >= 10000
```
|     Percentage         |
|------------------------|
|         32.23          |

The above query and table shows the percent total of users that meet at least 10,000 daily steps.

---

4. What is the average amount of time spent in sedentary activities per day by users?
   What is the average number of very active minutes, fairly active minutes, lightly active minutes and sedentary minutes for users?

- Average amount of time(in minutes) spent by users on sedentary activities by day of the week

The query and table below shows the amount of time in minutes that users spend on sedentary activities.
```sql
SELECT DATENAME(weekday, ActivityDate) DayOfWeek, ROUND(AVG(Sedentary_Minutes), 0) AvgSedentaryMinutes
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY DATENAME(weekday, ActivityDate)
ORDER BY ROUND(AVG(Sedentary_Minutes), 0) DESC
```
| DayOfWeek       | AvgSedentaryMinutes |
|-----------|-------|
| Monday    | 1028  |
| Tuesday   | 1007  |
| Friday    | 1000  |
| Sunday    | 990   |
| Wednesday | 989   |
| Saturday  | 964   |
| Thursday  | 962   |
















