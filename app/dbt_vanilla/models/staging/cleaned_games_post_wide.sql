{{
  config(
    materialized = 'table',
    )
}}

SELECT *
FROM {{ source('bikeshare', 'games_post_wide') }}