{{ config(materialized='view', tags=['ready_for_prod']) }}

-- Test: repro attempt 4 for ticket 131927 - step 2, redefining the existing
-- view to add activedate/inactivedate, mirroring the customer's "rewrote the
-- definition for an existing object" timeline.
select
    customer_id,
    customer_name,
    current_date as activedate,
    cast(null as date) as inactivedate
from {{ ref('stg_customers') }}
