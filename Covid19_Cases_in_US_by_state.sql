SELECT provincestate,
confirmed AS febconfirmedcases,
FROM
bigquery-public-data.covid19_jhu_csse.summary
WHERE
countryregion = "US" AND date = '2020-02-29' ORDER BY febconfirmed_cases desc
