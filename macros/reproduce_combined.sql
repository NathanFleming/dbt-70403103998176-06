{# Reproduction macro for FUSCSE-38: high-fidelity mirror of the customer's
   dedupe_and_backfill macro. Uses adapter get_columns_in_relation (not
   gated on execute) plus two window-function-ranked CTEs and a per-column
   CASE WHEN merge, branching on is_incremental. #}
{% macro reproduce_dedupe_and_backfill(source_relation, cte_name) %}
{%- set columns = adapter.get_columns_in_relation(source_relation) %}
{%- set cdc_cols = ['SIMP_KEY', 'SIMP_OPERATION', 'SIMP_OFFSET', 'INGESTED_AT'] %}

    with in_scope as (
        select * from {{ cte_name }}
        {%- if is_incremental() %}
        where INGESTED_AT > (select max(INGESTED_AT) from {{ this }})
        {%- endif %}
    ),

    ranked_latest as (
        select *,
            row_number() over (
                partition by SIMP_KEY
                order by INGESTED_AT desc, SIMP_OFFSET desc
            ) as __rn
        from in_scope
    ),

    ranked_non_delete as (
        select *,
            row_number() over (
                partition by SIMP_KEY
                order by INGESTED_AT desc, SIMP_OFFSET desc
            ) as __rn
        from in_scope
        where SIMP_OPERATION != 'D'
    ),

    latest as (select * exclude (__rn) from ranked_latest where __rn = 1),
    latest_val as (select * exclude (__rn) from ranked_non_delete where __rn = 1),

    merged as (
        select
            {%- for column in columns %}
            {%- if column.name not in cdc_cols %}
            case
                when l.SIMP_OPERATION = 'D' and lv.SIMP_KEY is not null
                then lv.{{ column.name }}
                else l.{{ column.name }}
            end as {{ column.name }}
            {%- else %}
            l.{{ column.name }}
            {%- endif %}{%- if not loop.last %},{% endif %}
            {%- endfor %}
        from latest l
        left join latest_val lv on l.SIMP_KEY = lv.SIMP_KEY
    )

    select * from merged
    {%- if not is_incremental() %}
    where not (SIMP_OPERATION = 'D' and SIMP_KEY is null)
    {%- endif %}
{% endmacro %}

{# Reproduction macro for FUSCSE-38: high-fidelity mirror of the customer's
   map_columns macro. Gated on execute, runs run_query against a mapping
   seed, and applies type-based casting logic per column via elif branches. #}
{% macro reproduce_map_columns(table_name) %}
  {%- if execute %}
    {%- set results = run_query(
      "select source_column, target_column, source_type from " ~ ref('reproduce_column_mappings') ~
      " where table_name = '" ~ table_name ~ "' order by ordinal_position"
    ) %}
    {%- if results.rows | length == 0 %}
      {{ exceptions.raise_compiler_error(
        "No mappings found for table '" ~ table_name ~ "' in reproduce_column_mappings seed"
      ) }}
    {%- endif %}
    {%- for row in results.rows %}
      {%- if row[2] == 'DATE' %}
      to_date({{ row[0] }}) as {{ row[1] }}
      {%- elif row[2] == 'TIMESTAMP' %}
      cast({{ row[0] }} as timestamp) as {{ row[1] }}
      {%- elif 'CHAR' in row[2] %}
      trim({{ row[0] }}) as {{ row[1] }}
      {%- else %}
      {{ row[0] }} as {{ row[1] }}
      {%- endif -%}
      {%- if not loop.last %},{% endif %}
    {%- endfor %}
  {%- endif %}
{% endmacro %}
