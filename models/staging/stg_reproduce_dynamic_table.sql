-- FUSCSE-38 repro control: same dynamic-column macro as
-- stg_reproduce_dynamic_incremental, but materialized as table.
-- Isolates whether materialization (vs. the macro pattern) matters.
{{ config(materialized='table') }}

with source as (
    select * from {{ ref('raw_customers') }}
)

select
    {{ reproduce_dynamic_cols(ref('raw_customers')) }}
from source
