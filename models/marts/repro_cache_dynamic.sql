{{ config(materialized='table', tags=['ready_for_prod']) }}

-- Test: repro attempt 5 for ticket 131927. Deliberately left byte-for-byte
-- unchanged between build 1 (source without inactivedate) and build 2
-- (source with inactivedate added), so we can see whether
-- adapter.get_columns_in_relation() on repro_cache_source returns a stale,
-- cached column list on build 2 instead of the current one. The result is
-- materialized as data so we can just query it after each build rather than
-- relying on a compile-time assertion.
{% set cols = adapter.get_columns_in_relation(ref('repro_cache_source')) %}
{% set col_names = cols | map(attribute='name') | list %}

select
    '{{ col_names | join(",") }}' as observed_columns,
    {{ 'true' if 'inactivedate' in col_names else 'false' }} as saw_inactivedate
