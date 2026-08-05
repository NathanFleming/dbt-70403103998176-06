{{ config(materialized='incremental', tags=['ready_for_prod']) }}

-- Test: repro for ticket 131927 - queries repro_view_source's activedate column
-- in a WHERE clause, mirroring the customer's org_step1 CTE pattern, to see
-- whether this fails with 'invalid identifier' right after the view rebuilds.
select *
from {{ ref('repro_view_source') }}
where
    activedate <= current_date
    and (inactivedate is null or inactivedate > current_date)
