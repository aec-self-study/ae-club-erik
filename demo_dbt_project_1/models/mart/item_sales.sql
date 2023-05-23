with order_items as (
    select * from {{ source('coffee_shop', 'order_items') }}
),

orders as (
    select * from {{ source('coffee_shop', 'orders') }}
),

products as (
    select * from {{ source('coffee_shop', 'products') }}
),

product_prices as (
    select * from {{ source('coffee_shop', 'product_prices') }}
),

joined as (
    select
        order_items.id,
        order_items.order_id,
        order_items.product_id,
        orders.created_at as sold_at,
        products.category as product_category,
        product_prices.price as amount

    from order_items

    left join orders
        on order_items.order_id = orders.id

    left join products
        on order_items.product_id = products.id

    left join product_prices
        on order_items.product_id = product_prices.product_id
        and orders.created_at between product_prices.created_at and product_prices.ended_at
)

select * from joined