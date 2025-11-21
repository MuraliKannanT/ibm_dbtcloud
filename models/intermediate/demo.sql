{{ config(materialized='ephemeral')}}
with

customers as (

    select * from Analytics.dbt_mkannan_new.stg_customers

),

orders_table as (

    select * from Analytics.dbt_mkannan_new.stg_orders

),

order_items_table as (

    select * from Analytics.dbt_mkannan_new.stg_line_items
),

order_summary as (

    select
        customer_id,

        count(distinct orders.order_id) as count_lifetime_orders,
        count(distinct orders.order_id) > 1 as is_repeat_buyer,
        min(orders.order_date) as first_ordered_at,
        max(orders.order_date) as last_ordered_at,
        sum(order_items.extended_price) as lifetime_spend_pretax,
        sum(orders.total_price) as lifetime_spend_total

    from orders_table as orders
    
    left join order_items_table as order_items on orders.order_id = order_items.order_id
    
    group by 1

),

joined as (

    select
        customers.*,
        order_summary.count_lifetime_orders,
        order_summary.first_ordered_at,
        order_summary.last_ordered_at,
        order_summary.lifetime_spend_pretax,
        order_summary.lifetime_spend_total,

        case
            when order_summary.is_repeat_buyer then 'returning'
            else 'new'
        end as customer_type

    from customers

    left join order_summary
        on customers.customer_id = order_summary.customer_id)

select * from joined