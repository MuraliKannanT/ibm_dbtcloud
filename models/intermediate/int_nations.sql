{{ config(materialized = 'incremental') }}
with nation as (
select
nation_id,
region_id,
name,
comment,
jodo_col,
{{ dbt_meta() }}
from {{ ref('stg_nations') }}
)
select * from nation