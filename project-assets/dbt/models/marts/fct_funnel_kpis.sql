SELECT

    COUNT(DISTINCT user_id) AS total_users,

    SUM(did_page_view) AS users_page_view,

    SUM(did_view_item) AS users_view_item,

    SUM(did_add_to_cart) AS users_add_to_cart,

    SUM(did_begin_checkout) AS users_begin_checkout,

    SUM(did_purchase) AS users_purchase,

    ROUND(
        SAFE_DIVIDE(
            SUM(did_view_item),
            COUNT(DISTINCT user_id)
        ) * 100,
        2
    ) AS view_item_conversion_rate,

    ROUND(
        SAFE_DIVIDE(
            SUM(did_add_to_cart),
            SUM(did_view_item)
        ) * 100,
        2
    ) AS add_to_cart_rate,

    ROUND(
        SAFE_DIVIDE(
            SUM(did_begin_checkout),
            SUM(did_add_to_cart)
        ) * 100,
        2
    ) AS checkout_rate,

    ROUND(
        SAFE_DIVIDE(
            SUM(did_purchase),
            SUM(did_begin_checkout)
        ) * 100,
        2
    ) AS purchase_conversion_rate,

    ROUND(
        COALESCE(SUM(total_revenue),0),
        2
    ) AS total_revenue

FROM {{ ref('fct_funnel_user_metrics') }}