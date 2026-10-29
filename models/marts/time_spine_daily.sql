{{
    config(materialized='table')
}}

with days as (
    {{
        dbt.date_spine(
            'day',
            "to_date('01/01/2000','mm/dd/yyyy')",
            "dateadd(day, 30, current_date())"
        )
    }}
)

select cast(date_day as date) as date_day
from days