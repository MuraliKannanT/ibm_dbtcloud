{% macro generate_schema_name(custom_schema_name, node) -%}

{% set custom_schema_name = 'new' %}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {#-- dbt defaults to concatenating the custom schema to the target schema --#}
        {{ default_schema + "_" + custom_schema_name  }}

    {%- endif -%}

{%- endmacro %}