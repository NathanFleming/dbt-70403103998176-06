{{ config(materialized='view', tags=['ready_for_prod']) }}

-- Test: repro attempt 5 for ticket 131927, step 1. This view intentionally
-- omits inactivedate for this build. Step 2 will add it without touching
-- repro_cache_dynamic.sql, to test whether Fusion's parse-time schema cache
-- for adapter.get_columns_in_relation() reuses a stale column list.
select
    customer_id,
    customer_name,
    current_date as activedate
from {{ ref('stg_customers') }}
