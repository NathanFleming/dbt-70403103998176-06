-- FUSCSE-38 repro: high-fidelity mirror of crmc_phase_t's two-layer
-- structure - dedupe_and_backfill (window-function CASE merge, adapter
-- get_columns_in_relation) feeding into map_columns (execute-gated
-- run_query with type-based casting). Materialized incremental.
-- depends_on: {{ ref('reproduce_column_mappings') }}
{{ config(materialized='incremental') }}

with source as (
    select * from {{ ref('reproduce_cdc_source') }}
),

dedupe as (
    {{ reproduce_dedupe_and_backfill(ref('reproduce_cdc_source'), 'source') }}
),

renamed as (
    select
        {{ reproduce_map_columns('stg_reproduce_combined') }}
    from dedupe
)

select * from renamed
