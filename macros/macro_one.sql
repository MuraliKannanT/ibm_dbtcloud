{% macro jodo(col1, col2) %}

    {{col1}} || ' ' || {{col2}}

{% endmacro %}

{% macro getemps() %}
{% do run_query("select name from analytics.dbt_murali.stg_regions") %}
{% endmacro %}

{% macro unload() %}
{% do run_query("create or replace stage stage_analytics") %}
{% do run_query("copy into @stage_analytics from stg_nations partition by (region_id) 
file_format = (type=csv compression=none null_if=(' ') ) header=true ;  ") %}
{% endmacro %}
 