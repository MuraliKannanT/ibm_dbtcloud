with supp as 
(select * from {{ ref('stg_suppliers')}} ),
nation as 
(select * from {{ref('stg_nations')}}),
region as
(select * from {{ref('stg_regions')}})

select 
supp.* exclude nation_id,
nation.name as nation, region.name as region
 from supp 
join nation on supp.nation_id = nation.nation_id
join region on nation.region_id = region.region_id