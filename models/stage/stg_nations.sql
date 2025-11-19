with nation as (
select
        n_nationkey as nation_id,
        n_regionkey as region_id,
        n_name as name,
        n_comment as comment,
       {{ jodo('n_name', 'n_comment') }} as jodo_col,
       current_timestamp() as updated_at 
from {{ source('src', 'nations') }}
)
select * from nation