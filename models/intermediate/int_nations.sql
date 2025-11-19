{{ config(materialized = 'incremental') }}
with nation as (
select
nation_id,
region_id,
name,
comment,
jodo_col,
from {{ ref('stg_nations') }}
)
select * from nation