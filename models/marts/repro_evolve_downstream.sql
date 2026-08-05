{{ config(materialized='table', tags=['ready_for_prod']) }}

-- Test: repro attempt 4 for ticket 131927 - step 2, now references the
-- newly-added column on the redefined (pre-existing) view, using the same
-- where-subquery + qualify shape as the customer's failing model.
with
parameters as (
    select dateadd(day, -1, current_date) as rpt_date
),

filtered as (
    select *
    from {{ ref('repro_evolve_source') }}
    where
        activedate <= (select rpt_date from parameters)
        and (
            inactivedate is null
            or inactivedate > (select rpt_date from parameters)
        )
    qualify row_number() over (partition by customer_id order by activedate desc) = 1
)

select * from filtered
