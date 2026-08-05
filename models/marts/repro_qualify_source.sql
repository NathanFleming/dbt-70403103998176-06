{{ config(materialized='view', tags=['ready_for_prod']) }}

-- Test: isolated repro for ticket 131927 - just the upstream shape,
-- a plain unquoted lowercase column alongside others.
select
    customer_id,
    customer_name,
    current_date as activedate,
    cast(null as date) as inactivedate
from {{ ref('stg_customers') }}
