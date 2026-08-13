-- Control: literal check_cols, no macro indirection.
{% snapshot repro_fuscse58_control_snapshot %}

{{
    config(
      unique_key='ID',
      strategy='check',
      check_cols=['ID','CUSTOMER','ORDERED_AT','STORE_ID','SUBTOTAL'],
      invalidate_hard_deletes=true,
    )
}}

select ID, CUSTOMER, ORDERED_AT, STORE_ID, SUBTOTAL, TAX_PAID, ORDER_TOTAL
from {{ ref('raw_orders') }}

{% endsnapshot %}
