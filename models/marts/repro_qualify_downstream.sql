{{ config(materialized='table', tags=['ready_for_prod']) }}

-- Test: isolated repro for ticket 131927 - mirrors the exact SQL shape of the
-- failing customer model: a WHERE clause with a scalar subquery, combined
-- with a QUALIFY clause, in the same SELECT block referencing a plain
-- unquoted lowercase column from the FROM target. No concurrency games -
-- single model, testing whether this SQL shape alone causes a resolution
-- failure on `activedate`.

with
parameters as (
    select dateadd(day, -1, current_date) as rpt_date
),

filtered as (
    select *
    from {{ ref('repro_qualify_source') }}
    where
        activedate <= (select rpt_date from parameters)
        and (
            inactivedate is null
            or inactivedate > (select rpt_date from parameters)
        )
    qualify row_number() over (partition by customer_id order by activedate desc) = 1
)

select * from filtered
