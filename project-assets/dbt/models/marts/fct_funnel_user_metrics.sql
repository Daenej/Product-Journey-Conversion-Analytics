SELECT

    user_id,

    MAX(device_category) AS device_category,
    MAX(country) AS country,
    MAX(traffic_medium) AS traffic_medium,
    MAX(traffic_source) AS traffic_source,

    MIN(event_date) AS first_activity_date,

    MAX(CASE WHEN event_name = 'page_view' THEN 1 ELSE 0 END) AS did_page_view,
    MAX(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS did_view_item,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS did_add_to_cart,
    MAX(CASE WHEN event_name = 'begin_checkout' THEN 1 ELSE 0 END) AS did_begin_checkout,
    MAX(CASE WHEN event_name = 'add_payment_info' THEN 1 ELSE 0 END) AS did_add_payment,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS did_purchase,

    SUM(COALESCE(revenue,0)) AS total_revenue

FROM {{ ref('int_user_sessions') }}

GROUP BY user_id