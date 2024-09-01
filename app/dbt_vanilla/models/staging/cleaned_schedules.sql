{{
  config(
    materialized = 'table',
    )
}}

SELECT *
FROM {{ source('bikeshare', 'schedules') }}