{{ config(materialized='view', tags=['ready_for_prod']) }}

-- Test: repro for ticket 131927 - a view with a column that a downstream model
-- queries in a WHERE clause immediately after this view rebuilds.
select
    customer_id,
    customer_name,
    current_date as activedate,
    null as inactivedate
from {{ ref('stg_customers') }}
