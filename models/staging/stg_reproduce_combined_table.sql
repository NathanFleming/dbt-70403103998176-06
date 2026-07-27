-- FUSCSE-38 repro control: same combined dedupe_and_backfill + map_columns
-- structure as stg_reproduce_combined_incremental, but materialized as
-- table. Isolates whether materialization matters once combined with the
-- full macro complexity, independent of the dynamic-column mechanism.
-- depends_on: {{ ref('reproduce_column_mappings') }}
{{ config(materialized='table') }}

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
