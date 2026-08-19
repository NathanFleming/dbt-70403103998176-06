{% snapshot repro_fuscse58_no_dash_forloop_snapshot %}
{{ config(unique_key='ID', strategy='check', check_cols=['ID','CUSTOMER','ORDERED_AT','STORE_ID','SUBTOTAL'], invalidate_hard_deletes=true) }}
select
    {% for column_name in ['ID','CUSTOMER','ORDERED_AT','STORE_ID','SUBTOTAL','TAX_PAID','ORDER_TOTAL'] %}
        {{ column_name }} as {{ column_name }}{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ repro_generate_fivetran_active_source('raw', 'orders') }}
{% endsnapshot %}
