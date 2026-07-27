-- FUSCSE-38 repro: dynamic column list via execute-gated run_query,
-- materialized incremental, mirrors customer's map_columns pattern.
-- Expectation under bug theory: catalog.json omits this model's columns.
{{ config(materialized='incremental') }}

with source as (
    select * from {{ ref('raw_customers') }}
)

select
    {{ reproduce_dynamic_cols(ref('raw_customers')) }}
from source
