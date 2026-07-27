{# Reproduction macro for FUSCSE-38: builds a column list dynamically via
   run_query, gated on the execute context flag, mimicking the customer's
   map_columns macro. Expectation under the bug theory: static/non-executing
   analysis passes will see this macro emit nothing, since execute is False.
   Queries information_schema directly to avoid needing a new seed table. #}
{% macro reproduce_dynamic_cols(relation) %}
  {%- if execute %}
    {%- set results = run_query(
      "select column_name from " ~ relation.database ~ ".information_schema.columns" ~
      " where table_schema = '" ~ relation.schema | upper ~ "' and table_name = '" ~ relation.identifier | upper ~ "'" ~
      " order by ordinal_position"
    ) %}
    {%- for row in results.rows %}
      {{ row[0] }} as dyn_{{ row[0] }}{% if not loop.last %},{% endif %}
    {%- endfor %}
  {%- endif %}
{% endmacro %}

{# Reproduction macro for FUSCSE-38: builds a column list via
   adapter get_columns_in_relation, NOT gated on execute,
   mimicking the customer's dedupe_and_backfill macro. #}
{% macro reproduce_introspected_cols(relation) %}
  {%- set columns = adapter.get_columns_in_relation(relation) %}
  {%- for column in columns %}
    {{ column.name }}{% if not loop.last %},{% endif %}
  {%- endfor %}
{% endmacro %}
