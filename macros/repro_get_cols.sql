{#
  Repro harness for FUSCSE-86 / Zendesk 136752.
  Calls get_columns_in_relation on a relation at render time, which is what
  populates selected_get_columns_in_relation in schema_hydration.rs. Hand-rolled
  deliberately: no dbtplyr or dbt_utils dependency, so the harness has no
  package surface of its own.
#}
{% macro repro_get_cols(rel) %}
  {%- set cols = adapter.get_columns_in_relation(rel) -%}
  {{ return(cols | map(attribute='name') | list) }}
{% endmacro %}
