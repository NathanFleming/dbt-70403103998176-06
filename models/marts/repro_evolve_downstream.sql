{{ config(materialized='table', tags=['ready_for_prod']) }}

-- Test: repro attempt 4 for ticket 131927 - step 1, downstream does not
-- reference the not-yet-existing column.
select *
from {{ ref('repro_evolve_source') }}
