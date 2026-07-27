-- FUSCSE-38 repro control: plain literal column list, materialized
-- incremental. Isolates whether "incremental" alone (without dynamic
-- column generation) is enough to break catalog/CLL generation.
{{ config(materialized='incremental') }}

select
    id as customer_id,
    name as customer_name
from {{ ref('raw_customers') }}
