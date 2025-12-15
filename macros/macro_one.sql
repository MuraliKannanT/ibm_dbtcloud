{% macro jodo(col1, col2) %}

    {{col1}} || ' ' || {{col2}}

{% endmacro %}

{% macro appendnations() %}
{% set newnat %}
insert into {{ref('int_nations')}} (nation_id,name)
select nation_id,name from {{ ref('stg_nations') }}
{% endset %}

{% do run_query(newnat) %}
{% endmacro %}

{% macro unload() %}
{% do run_query("create or replace stage stage_analytics") %}
{% do run_query("copy into @stage_analytics from stg_nations partition by (region_id) 
file_format = (type=csv compression=none null_if=(' ') ) header=true ;  ") %}
{% endmacro %}
 