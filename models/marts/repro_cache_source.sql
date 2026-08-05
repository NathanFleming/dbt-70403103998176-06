{{ config(materialized='view', tags=['ready_for_prod']) }}

-- Test: repro attempt 5 for ticket 131927, step 2. Added inactivedate.
-- repro_cache_dynamic.sql was NOT touched in this commit.
select
    customer_id,
    customer_name,
    current_date as activedate,
    cast(null as date) as inactivedate
from {{ ref('stg_customers') }}
