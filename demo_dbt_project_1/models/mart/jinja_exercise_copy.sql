{% set payment_methods = ["coffee beans", "merch", "brewing supplies"] %}

select
    date_trunc(sold_at, month) as date_month,
    {% for category in payment_methods %}
        sum(case when product_category = '{{ category }}' then amount end) as {{ category | replace(" ","_")}}_amount
        {% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('item_sales') }}
group by 1
