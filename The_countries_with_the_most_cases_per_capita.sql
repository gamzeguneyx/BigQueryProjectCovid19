with countrypop AS( SELECT IF(country = "United States","US",IF(country="Turkiye","Turkiye",country)) AS country, year2022
FROM
bigquery-public-data.world_bank_global_population.population_by_country)

SELECT
cases.date AS date,
cases.countryregion AS countryregion,
SUM(cases.confirmed) AS totalconfirmedcases,
SUM(cases.confirmed)/AVG(countrypop.year2022) * 100000 AS confirmedcasesper100000 FROM bigquery-public-data.covid19_jhu_csse.summary cases JOIN countrypop ON cases.countryregion LIKE CONCAT('%',countrypop.country,'%')
WHERE
cases.countryregion = "US" AND countrypop.country = "US"
AND cases.date = DATESUB(currentdate(),INTERVAL 1 day)
GROUP BY
country_region, date

UNION ALL

SELECT
cases.date AS date,
cases.countryregion AS countryregion,
SUM(cases.confirmed) AS totalconfirmedcases,
SUM(cases.confirmed)/AVG(countrypop.year2022) * 100000 AS confirmedcasesper100000 FROM bigquery-public-data.covid19_jhu_csse.summary cases JOIN countrypop ON cases.countryregion LIKE CONCAT('%',countrypop.country,'%')
WHERE
cases.countryregion = "Turkiye" AND countrypop.country = "Turkiye"
AND cases.date = DATESUB(currentdate(),INTERVAL 1 day)
GROUP BY
country_region, date

UNION ALL

SELECT
cases.date AS date,
cases.countryregion AS countryregion,
SUM(cases.confirmed) AS totalconfirmedcases,
SUM(cases.confirmed)/AVG(countrypop.year2022) * 100000 AS confirmedcasesper100000 FROM bigquery-public-data.covid19_jhu_csse.summary cases JOIN countrypop ON cases.countryregion LIKE CONCAT('%',countrypop.country,'%')
WHERE
cases.countryregion = "China" AND countrypop.country = "China"
AND cases.date = DATESUB(currentdate(),INTERVAL 1 day)

GROUP BY
country_region, date

UNION ALL

SELECT
cases.date AS date,
cases.countryregion AS countryregion,
cases.confirmed AS totalconfirmedcases,
cases.confirmed/countrypop.year2018 * 100000 AS confirmedcasesper100000 FROM bigquery-public-data.covid19_jhu_csse.summary cases JOIN countrypop ON cases.countryregion LIKE CONCAT('%',countrypop.country,'%')
WHERE
cases.countryregion IN ("Italy", "Spain", "Germany", "France") AND cases.date = DATESUB(currentdate(),INTERVAL 1 day) ORDER BY confirmedcasesper100000 desc
