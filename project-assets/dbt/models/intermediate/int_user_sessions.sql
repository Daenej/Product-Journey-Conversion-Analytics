WITH ordered_events AS (

    SELECT
        user_id,
        event_name,
        event_time,
        event_date,
        device_category,
        country,
        traffic_medium,
        traffic_source,
        revenue,

        LAG(event_time) OVER (
            PARTITION BY user_id
            ORDER BY event_time
        ) AS previous_event_time

    FROM {{ ref('stg_funnel_events') }}

),

sessionized AS (

    SELECT
        *,

        CASE
            WHEN previous_event_time IS NULL THEN 1
            WHEN TIMESTAMP_DIFF(
                    event_time,
                    previous_event_time,
                    MINUTE
                 ) > 30 THEN 1
            ELSE 0
        END AS new_session_flag

    FROM ordered_events

)

SELECT
    *,

    SUM(new_session_flag) OVER (
        PARTITION BY user_id
        ORDER BY event_time
    ) AS session_id

FROM sessionized