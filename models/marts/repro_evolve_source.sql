{{ config(materialized='view', tags=['ready_for_prod']) }}

-- Test: repro attempt 4 for ticket 131927 - step 1, view WITHOUT activedate yet.
select
    customer_id,
    customer_name
from {{ ref('stg_customers') }}
