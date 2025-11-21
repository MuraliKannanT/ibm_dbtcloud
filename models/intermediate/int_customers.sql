with cust as 
(select * from {{ ref('stg_customers')}} ),
nation as 
(select * from {{ref('stg_nations')}}),
region as
(select * from {{ref('stg_regions')}})

select * from cust 
join nation on cust.nation_id = nation.nation_id
join region on nation.region_id = region.region_id