-- Total episodes
SELECT COUNT(DISTINCT [Ep# No#]) AS total_episodes
FROM [Shark tank project]..data;

-- Pitches
SELECT COUNT(DISTINCT [Brand]) AS total_pitches
FROM [Shark tank project]..data;

-- Pitches converted
SELECT CAST(SUM(CASE WHEN [Amount Invested lakhs] > 0 THEN 1 ELSE 0 END) AS FLOAT) / CAST(COUNT(*) AS FLOAT) AS conversion_rate
FROM [Shark tank project]..data;

-- Total male and female contestants
SELECT SUM(male) AS total_male, SUM(female) AS total_female
FROM [Shark tank project]..data;

-- Gender ratio
SELECT SUM(female) / SUM(male) AS gender_ratio
FROM [Shark tank project]..data;

-- Total invested amount
SELECT SUM([Amount Invested lakhs]) AS total_invested_amount
FROM [Shark tank project]..data;

-- Average equity taken (%)
SELECT AVG([Equity Taken %]) AS avg_equity_taken
FROM [Shark tank project]..data
WHERE [Equity Taken %] > 0;

-- Highest deal amount
SELECT MAX([Amount Invested lakhs]) AS highest_deal_amount
FROM [Shark tank project]..data;

-- Highest equity taken (%)
SELECT MAX([Equity Taken %]) AS highest_equity_taken
FROM [Shark tank project]..data;

-- Startups with at least one woman
SELECT SUM(CASE WHEN female > 0 THEN 1 ELSE 0 END) AS startups_with_women
FROM [Shark tank project]..data;

-- Pitches converted with at least one woman
SELECT SUM(CASE WHEN female > 0 AND deal != 'No Deal' THEN 1 ELSE 0 END) AS pitches_with_women
FROM [Shark tank project]..data;

-- Average team members
SELECT AVG([Team members]) AS avg_team_members
FROM [Shark tank project]..data;

-- Average amount invested per deal
SELECT AVG([Amount Invested lakhs]) AS avg_amount_invested_per_deal
FROM [Shark tank project]..data
WHERE deal != 'No Deal';

-- Average age group of contestants
SELECT AVG([avg age]) AS avg_age, COUNT(*) AS cnt
FROM [Shark tank project]..data
GROUP BY [avg age]
ORDER BY cnt DESC;

-- Location group of contestants
SELECT location, COUNT(location) AS cnt
FROM [Shark tank project]..data
GROUP BY location
ORDER BY cnt DESC;

-- Sector group of contestants
SELECT sector, COUNT(sector) AS cnt
FROM [Shark tank project]..data
GROUP BY sector
ORDER BY cnt DESC;

-- Partner deals
SELECT partners, COUNT(partners) AS cnt
FROM [Shark tank project]..data
WHERE partners != '-'
GROUP BY partners
ORDER BY cnt DESC;

-- Highest amount invested per sector
SELECT brand, sector, [amount invested lakhs]
FROM (
    SELECT brand, sector, [amount invested lakhs], 
           RANK() OVER (PARTITION BY sector ORDER BY [amount invested lakhs] DESC) AS rnk
    FROM [Shark tank project]..data
) AS ranked_data
WHERE rnk = 1;
