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

1. **UserID**: This column contains a unique identifier for each user, such as a user ID or serial number.
2. **Activity Date**: This column contains the date on which the user's physical activity was tracked, logged, or recorded.
3. **Total Steps**: This column contains the total number of steps taken by the user on the given date, as recorded by the device's step counter.
4. **Total Distance**: This column contains the total distance traveled by the user on the given date, as estimated by the device's sensors based on the user's steps taken and stride length.
5. **Tracker Distance**: This column contains the distance traveled by the user on the given date as recorded by the device itself.
6. **Logged Activities Distance**: This column contains the distance traveled by the user on the given date during manually logged activities.
7. **Very Active Distance**: This column contains the distance traveled by the user on the given date while engaging in activities that require high levels of physical exertion, such as running or playing sports.
8. **Moderately Active Distance**: This column contains the distance traveled by the user on the given date while engaging in activities that require moderate levels of physical exertion, such as brisk walking or light cycling.
9. **Light Active Distance**: This column contains the distance traveled by the user on the given date while engaging in activities that require light physical exertion, such as slow walking or standing.
10. **Sedentary Active Distance**: This column contains the distance traveled by the user on the given date while engaging in activities that involve very little movement, such as sitting or lying down.
11. **Very Active Minutes**: This column contains the total number of minutes during which the user engaged in high-intensity physical activity on the given date.
12. **Fairly Active Minutes**: This column contains the total number of minutes during which the user engaged in moderate-intensity physical activity on the given date.
13. **Lightly Active Minutes**: This column contains the total number of minutes during which the user engaged in low-intensity physical activity on the given date.
14. **Sedentary Minutes**: This column contains the total number of minutes during which the user was sedentary, such as sitting or lying down, on the given date.
15. **Calories**: This column contains the total number of calories burned by the user on the given date, as estimated by the device based on their physical activity levels and other biometric data

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


- Average amount of time(in minutes) of all users across all activity levels

The query and table below shows the average  time spent by all users on all the activity levels
```sql
SELECT ROUND(AVG(Very_Active_Minutes), 0) Avg_VeryActiveMinutes, 
	   ROUND(AVG(Fairly_Active_Minutes), 0) Avg_FairlyActiveMinutes, 
	   ROUND(AVG(LightlyActiveMinutes), 0) Avg_LightlyActiveMinutes,
	   ROUND(AVG(Sedentary_Minutes), 0) AvgSedentaryMinutes
FROM SQLPractice.dbo.DailyActivityMerged
```
|Avg_VeryActiveMinutes | Avg_FairlyActiveMinutes  | Avg_LightlyActiveMinutes | Avg_SedentaryMinutes |
|----------------------|--------------------------|--------------------------|----------------------|
|           21         |           14             |	        193            |	       991         |

- Average amount of time(in minutes) of all users across all activity levels by day of the week

The query and table below shows the average  time spent by all users on all the activity levels by days of the week
```sql
SELECT DATENAME (weekday, ActivityDate) DayOfWeek,
	   ROUND (AVG (Very_Active_Minutes), 0) Avg_VeryActiveMinutes, 
	   ROUND (AVG (Fairly_Active_Minutes), 0) Avg_FairlyActiveMinutes, 
	   ROUND (AVG (LightlyActiveMinutes), 0) Avg_LightlyActiveMinutes,
	   ROUND (AVG (Sedentary_Minutes), 0) Avg_SedentaryMinutes
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY DATENAME (weekday, ActivityDate)
ORDER BY DATENAME (weekday, ActivityDate)
```
|  DayOfWeek  | Avg_VeryActiveMinutes | Avg_FairlyActiveMinutes  | Avg_LightlyActiveMinutes | Avg_SedentaryMinutes |
|-------------|-----------------------|--------------------------|--------------------------|----------------------|
|   Wednesday | 21 | 13 | 190 | 989 |
| Saturday  | 22 | 15 | 207 | 964 |
| Monday    | 23 | 14 | 192 | 1028 |
| Sunday    | 20 | 15 | 174 | 990 |
| Friday    | 20 | 12 | 204 | 1000 |
| Thursday  | 19 | 12 | 185 | 962 |
| Tuesday   | 23 | 14 | 197 | 1007 |

---

5. How do users who engage in more very active minutes compare to those who engage in more light active minutes in terms of total steps and calories burned? 
- Are there any correlations between activity levels, total steps and calories burned?

- To answer this question that has to do with correlation, I did the calculation for correlation coefficient using Google sheets and the worksheet is attached to this repository. Below I will explain a bit of it and also explain the answer
First of all, I calculated the average of each required column(Very Active Minutes, Lightly Active Minutes, Sedentary Minutes) for each user and came to have 33 rows only as there are only 33 users in the dataset which was perfect to carry out the correlation calculation. Below is the query and the table output of it.

```sql
SELECT DISTINCT UserID,
	   ROUND(AVG(Very_Active_Minutes), 0) Avg_VeryActiveMinutes, 
	   ROUND(AVG(LightlyActiveMinutes), 0) Avg_LightlyActiveMinutes,
	   ROUND(AVG(Sedentary_Minutes), 0) Avg_SedentaryMinutes,
	   ROUND(AVG(Total_Steps), 0) Avg_TotalSteps,
	   ROUND(AVG(Calories), 0) Avg_Calories
FROM SQLPractice.dbo.DailyActivityMerged
GROUP BY UserID
ORDER BY UserID
```
| |    UserID       | Avg_VeryActiveMinutes | Avg_LightlyActiveMinutes  | Avg_SedentaryMinutes | Avg_TotalSteps |  AvgCalories  |
|-|-----------------|-----------------------|---------------------------|----------------------|----------------|---------------|
|1| 1503960366  | 39 | 220 | 848  | 12117 | 1816 |
|2| 1624580081 | 9  | 153 | 1258 | 5744  | 1483 |
|3| 1644430081 | 10 | 178 | 1162 | 7283  | 2811 |
|4| 1844505072 | 0  | 115 | 1207 | 2580  | 1573 |
|5| 1927972279 | 1  | 39  | 1317 | 916   | 2173 |
|6| 2022484408 | 36 | 257 | 1113 | 11371 | 2510 |
|7| 2026352035 | 0  | 257 | 689  | 5567  | 1541 |
|8| 2320127002 | 1  | 198 | 1220 | 4717  | 1724 |
|9| 2347167796 | 14 | 253 | 687  | 9520  | 2043 |
|10| 2873212765 | 14 | 308 | 1097 | 7556  | 1917 |
|11| 3372868164 | 9  | 328 | 1078 | 6862  | 1933 |
|12| 3977333714 | 19 | 175 | 708  | 10985 | 1514 |
|13| 4020332650 | 5  | 77  | 1237 | 2267  | 2386 |
|14| 4057192912 | 1  | 103 | 1217 | 3838  | 1974 |
|15| 4319703577 | 4  | 229 | 736  | 7269  | 2038 |
|16| 4388161847 | 23 | 229 | 837  | 10814 | 3094 |
|17| 4445114986 | 7  | 209 | 830  | 4797  | 2186 |
|18| 4558609924 | 10 | 285 | 1094 | 7685  | 2033 |
|19| 4702921684 | 5  | 237 | 766  | 8572  | 2966 |
|20| 5553957443 | 23 | 206 | 668  | 8613  | 1876 |
|21| 5577150313 | 87 | 148 | 754  | 8304  | 3360 |
|22| 6117666160 | 2  | 288 | 796  | 7047  | 2261 |
|23| 6290855005 | 3  | 227 | 1193 | 5650  | 2600 |
|24| 6775888955 | 11 | 40  | 1299 | 2520  | 2132 |
|25| 6962181067 | 23 | 246 | 662  | 9795  | 1982 |
|26| 7007744171 | 31 | 281 | 1055 | 11323 | 2544 |
|27| 7086361926 | 43 | 144 | 850  | 9372  | 2566 |
|28| 8053475328 | 85 | 151 | 1148 | 14763 | 2946 |
|29| 8253242879 | 21 | 117 | 1287 | 6482  | 1788 |
|30| 8378563200 | 59 | 156 | 716  | 8718  | 3437 |
|31| 8583815059 | 10 | 138 | 1267 | 7199  | 2732 |
|32| 8792009665 | 1  | 92  | 1060 | 1854  | 1962 |
|33| 8877689391 | 66 | 235 | 1113 | 16040 | 3420 |


Now to determine whether there are any correlations between activity levels, total steps, and calories burned, we calculate the correlation coefficients between each of these variables using the Pearson Correlation Coefficient Formula and this was done on Google Sheets.

The three activity levels were paired to Total Steps and Calories for the correlation between the two variables to be calculated
The Pearson Correlation Coefficient forula was applied using Google sheets(this can be found in the spreadsheet attached to this repository).

The result for the correlation coefficient of all the selected three activity levels against total steps and calories are as follows:

1. **Very Active Minutes against Calories Burned**: The correlation coefficient was 0.63. This indicates a moderately strong positive correlation. It means that as the minutes spent on very active physical activities increase, there is a tendency for calories burned to increase as well. It suggests that there is a relatively strong linear relationship between the two variables(amount of time spent on very active physical activities and the amount of calories burned), with a positive slope. 
2. **Very Active Minutes against Total Steps**: The correlation coefficient was 0.70. This correlation coefficient indicates a fairly strong positive correlation. This implies that that as the minutes spent on very active physical activities increase, there is a tendency for the total steps taken to also increase. The value of 0.70 suggests a relatively stronger positive relationship between these two variables compared to the correlation between minutes spent and calories burned.
3. **Lightly Active Minutes against Calories Burned**: The correlation coefficient was -0.005. This correlation coefficient is very close to zero. It suggests an extremely weak or no linear relationship between the variables(amount of time spent on activities that requires the user to be very active and amount of calories burned). The value being close to zero indicates that the two variables are essentially independent of each other.
4. **Lightly Active Minutes against Total Steps**: The correlation coefficient was 0.51. It indicates a moderate positive correlation. It suggests that there is a moderate linear relationship between the amount of time spent on activities that require the user to be very active and total steps of users.
5. **Sedentary Minutes against Calories Burneds**: The correlation coefficient is -0.077. This indicates a weak negative correlation between the minutes spent on sedentary activity and the calories burned. A negative correlation means that as the minutes of sedentary activity increase, the calories burned tend to decrease slightly. However, the coefficient value of -0.077 suggests that the relationship is weak, implying that the impact of sedentary activity on calories is not very strong.
6. **Sedentary Minutes against Total Steps** The correlation coefficient is -0.39. This shows a moderate negative correlation between the minutes spent on sedentary activity and the total steps taken. A negative correlation implies that as the minutes of sedentary activity increase, the total steps taken tend to decrease. The coefficient value of -0.39 indicates a relatively stronger correlation compared to the previous case, suggesting that sedentary activity has a somewhat more noticeable impact on the total steps taken.

---

## Insights

1. The average total daily steps for users is 7638 which is below the recommended 10,000 steps per day. 10,000 steps is the recommended number of daily steps as it equals approximately 5 miles. At least 10,000 steps daily(5 miles) is said to help reduce certain health conditions such as high blood pressure and heart diseases.
2. Average number of steps by day of the week: On average, the trend goes as follows: Saturday, Tuesday, Monday, Wednesday, Friday, Thursday and Sunday(this is in descending order).
Based on the data, it shows that users are more active during weekdays than on weekends. Saturday recorded the highest number of steps and this can mainly be because it is the main day during the weekend and is a work free day for the majority of people. The lowest number of steps were recorded on Sunday, which is traditionally a day of rest for many people. This could explain the lower number of steps taken on this day compared to other weekdays.
The second highest number of steps was recorded for Tuesday and also generally, it shows that weekdays had the highest number of steps taken compared to weekends. Possible explanation is that people tend to have more structured routines during weekdays, such as going to work or school, which may involve walking or commuting. On the other hand, weekends may be associated with more leisure time and less structured activities, which may result in less physical activity overall. It's also possible that the users in the from this sample are more likely to be working adults who are more active during weekdays and less active during weekends
3. From the analysis, it was seen that the distance logged in by the users doesn't come anywhere close to the total distance tracked by the device as it shows from the data that only four(4) users made use of that feature and the four(4) users did not use the feature consistently. This therefore means that users do not utilize the feature for manually logging in their activities.
4. According to the data, the percentage of users that meet the daily goal of at least 10,000 steps is approximately 32.23%
This can be improved to at least 50% first and then to 70%. Incentives such as discounts, coupons, or premium features for users who consistently reach or cross the daily goal of 10,000 steps. This can motivate users to stay engaged and committed to their fitness journey.
5. I noticed that users spend the highest time on sedentary activities on Mondays and Tuesdays with an average of 1028 and 1007 minutes respectively which is understandable as those are the first two days of the work week and some users may be working class adults and engage in less activities on those days during work hours. Weekdays have the highest amount of sedentary minutes and this can also be associated with the fact that users may be working and sitting at their work desks all day, else the high amount of minutes spent on sedentary activities for those days.

---

## Recommendations 
1. **Personalized Messages/Reminders:** The product/device should be utilized to send personalized messages and recommendations to users. These messages should remind users to take a walk, incorporating their daily step count and encouraging them to reach the 10,000 daily steps goal. By providing tailored reminders, users are more likely to stay motivated and actively engage in physical activity.
2. **Challenges and Milestones:** Interactive challenges can be created and organized within the device or app. Users who achieve the recommended 10,000 steps can be rewarded with badges or congratulatory messages, acknowledging their accomplishment. Additionally, a leaderboard that showcases users' positions based on the previous day's step count can also be implemented. By presenting this information, users are motivated to improve their performance and climb higher on the leaderboard.
3. **Sedentary Activity Alert:** Pop-up messages or alert system that triggers when a user's sedentary active minutes approach or exceed their average sedentary activity from the previous week, can be implemented. This alert should be personalized for each user, taking into account factors such as age, health status, and fitness goals. By prompting users to move or go for a walk, the system encourages them to break sedentary habits and engage in physical activity regularly.
4. **Educating Users:** Users should be educated about the benefits of manually logging activities or distances that may not be automatically tracked or recorded by the device. The importance of manually logging in activities to provide a more accurate representation of their overall fitness level should be emphasized, particularly when they are away from the device. By raising awareness of this feature and its advantages, users can make more informed decisions about tracking their activities.
5. **Feature Reminders and User Engagement:** A campaign to remind all users, through push notifications, emails, or in-app messages, about the activity logging feature and its usefulness should be initiated. How this feature contributes to their overall fitness journey should be highlighted. Additionally, target users who have not utilized the feature within a specific time frame to encourage their participation. Feedback should be requested from users who do not use the feature and incorporate their suggestions for improvement. This approach ensures continuous user engagement and maximizes the adoption of the activity logging feature.

---

If you really did read all through to this spot, **THANK YOU** so much. And if you just scrolled through, thanks a lot too fro taking your time to check this out. To connect with me, follow me on [Twitter](https://twitter.com/__afoke?t=_YX2DAel3R3aWZGDvSEZ9w&s=09), LinkedIn will be coming soon.
