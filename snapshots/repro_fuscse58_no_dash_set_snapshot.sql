-- Test D: check_cols via {% set %} macro chain, but WITHOUT whitespace-control
-- dashes anywhere (plain outer tags, plain set statements, no for-loop).
-- Hypothesis: this should NOT reproduce, since there's no "-%}" anywhere in
-- the file for the buggy search to latch onto.
{% snapshot repro_fuscse58_no_dash_set_snapshot %}

{% set check_columns = repro_get_column_names_from_config(repro_get_events_columns(), check_columns=true) %}
{% set column_names = repro_get_column_names_from_config(repro_get_events_columns()) %}

{{
    config(
      unique_key='ID',
      strategy='check',
      check_cols=check_columns,
      invalidate_hard_deletes=true,
    )
}}

select ID, CUSTOMER, ORDERED_AT, STORE_ID, SUBTOTAL, TAX_PAID, ORDER_TOTAL
from {{ repro_generate_fivetran_active_source('raw', 'orders') }}

{% endsnapshot %}
