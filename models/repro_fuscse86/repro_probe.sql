-- Repro probe for FUSCSE-86 / Zendesk 136752.
-- Calls get_columns_in_relation on TWO upstream relations that are referenced
-- but not built in this run. Expected: schemas prefetched cleanly and the model
-- builds. Suspected failure mode: one of the two concurrent schema fetches does
-- not register, and the unguarded lookup panics at schema_hydration.rs:826:17.
{{ config(materialized='table') }}

{%- set cols_a = repro_get_cols(ref('repro_up_a')) -%}
{%- set cols_b = repro_get_cols(ref('repro_up_b')) -%}

select
    {% for c in cols_a %}a.{{ c }} as a_{{ c }}, {% endfor %}
    {% for c in cols_b %}b.{{ c }} as b_{{ c }}{% if not loop.last %}, {% endif %}{% endfor %}
from {{ ref('repro_up_a') }} a
join {{ ref('repro_up_b') }} b on a.id = b.id
