-- FUSCSE-38 repro: column list via adapter get_columns_in_relation,
-- not gated on execute, materialized incremental, mirrors
-- the customer's dedupe_and_backfill macro pattern.
{{ config(materialized='incremental') }}

with source as (
    select * from {{ ref('raw_customers') }}
)

select
    {{ reproduce_introspected_cols(ref('raw_customers')) }}
from source
