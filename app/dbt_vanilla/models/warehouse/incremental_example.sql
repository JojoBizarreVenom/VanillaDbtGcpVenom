{{
  config(
    materialized = 'incremental',
    partition_by={
      "field": "createdAt",
      "data_type": "timestamp",
      "granularity": "day"
    }
    )
}}

SELECT games_post_wide.*
FROM {{ ref('cleaned_games_post_wide') }} AS games_post_wide
LEFT JOIN {{ ref('cleaned_schedules') }} AS cleaned_schedules ON cleaned_schedules.gameId = games_post_wide.gameId
{% if is_incremental() %}
WHERE updatedAt >= coalesce((select max(updatedAt) from {{ this }}), '1900-01-01')
{% endif %}