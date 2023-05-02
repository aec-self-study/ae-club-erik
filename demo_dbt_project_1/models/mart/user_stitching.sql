select
    id
    , first_value(visitor_id) over(partition by customer_id order by timestamp asc) as visitor_id
    , device_type
    , timestamp
    , pageviews
    , customer_id
from {{source('web_tracking','pageviews') }} as pageviews