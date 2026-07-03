SELECT
    user_id,
    event_name,
    event_time,
    event_date,
    device_category,
    country,
    traffic_medium,
    traffic_source,
    revenue

FROM {{ source('ga4', 'cleaned_funnel_events') }}

WHERE event_name IN (
    'page_view',
    'view_item',
    'add_to_cart',
    'begin_checkout',
    'add_payment_info',
    'purchase'
)