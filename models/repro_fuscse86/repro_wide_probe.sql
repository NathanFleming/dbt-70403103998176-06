-- Wide repro probe for FUSCSE-86 / Zendesk 136752.
-- Prefetches get_columns_in_relation across 24 referenced-but-not-built relations,
-- widening the concurrent-fetch window the customer hits with 39.
{{ config(materialized='table') }}

{%- set c01 = repro_get_cols(ref('repro_wide_01')) -%}
{%- set c02 = repro_get_cols(ref('repro_wide_02')) -%}
{%- set c03 = repro_get_cols(ref('repro_wide_03')) -%}
{%- set c04 = repro_get_cols(ref('repro_wide_04')) -%}
{%- set c05 = repro_get_cols(ref('repro_wide_05')) -%}
{%- set c06 = repro_get_cols(ref('repro_wide_06')) -%}
{%- set c07 = repro_get_cols(ref('repro_wide_07')) -%}
{%- set c08 = repro_get_cols(ref('repro_wide_08')) -%}
{%- set c09 = repro_get_cols(ref('repro_wide_09')) -%}
{%- set c10 = repro_get_cols(ref('repro_wide_10')) -%}
{%- set c11 = repro_get_cols(ref('repro_wide_11')) -%}
{%- set c12 = repro_get_cols(ref('repro_wide_12')) -%}
{%- set c13 = repro_get_cols(ref('repro_wide_13')) -%}
{%- set c14 = repro_get_cols(ref('repro_wide_14')) -%}
{%- set c15 = repro_get_cols(ref('repro_wide_15')) -%}
{%- set c16 = repro_get_cols(ref('repro_wide_16')) -%}
{%- set c17 = repro_get_cols(ref('repro_wide_17')) -%}
{%- set c18 = repro_get_cols(ref('repro_wide_18')) -%}
{%- set c19 = repro_get_cols(ref('repro_wide_19')) -%}
{%- set c20 = repro_get_cols(ref('repro_wide_20')) -%}
{%- set c21 = repro_get_cols(ref('repro_wide_21')) -%}
{%- set c22 = repro_get_cols(ref('repro_wide_22')) -%}
{%- set c23 = repro_get_cols(ref('repro_wide_23')) -%}
{%- set c24 = repro_get_cols(ref('repro_wide_24')) -%}

select
    {% for c in c01 %}t01.{{ c }} as t01_{{ c }}, {% endfor %}
    {% for c in c02 %}t02.{{ c }} as t02_{{ c }}, {% endfor %}
    {% for c in c03 %}t03.{{ c }} as t03_{{ c }}, {% endfor %}
    {% for c in c04 %}t04.{{ c }} as t04_{{ c }}, {% endfor %}
    {% for c in c05 %}t05.{{ c }} as t05_{{ c }}, {% endfor %}
    {% for c in c06 %}t06.{{ c }} as t06_{{ c }}, {% endfor %}
    {% for c in c07 %}t07.{{ c }} as t07_{{ c }}, {% endfor %}
    {% for c in c08 %}t08.{{ c }} as t08_{{ c }}, {% endfor %}
    {% for c in c09 %}t09.{{ c }} as t09_{{ c }}, {% endfor %}
    {% for c in c10 %}t10.{{ c }} as t10_{{ c }}, {% endfor %}
    {% for c in c11 %}t11.{{ c }} as t11_{{ c }}, {% endfor %}
    {% for c in c12 %}t12.{{ c }} as t12_{{ c }}, {% endfor %}
    {% for c in c13 %}t13.{{ c }} as t13_{{ c }}, {% endfor %}
    {% for c in c14 %}t14.{{ c }} as t14_{{ c }}, {% endfor %}
    {% for c in c15 %}t15.{{ c }} as t15_{{ c }}, {% endfor %}
    {% for c in c16 %}t16.{{ c }} as t16_{{ c }}, {% endfor %}
    {% for c in c17 %}t17.{{ c }} as t17_{{ c }}, {% endfor %}
    {% for c in c18 %}t18.{{ c }} as t18_{{ c }}, {% endfor %}
    {% for c in c19 %}t19.{{ c }} as t19_{{ c }}, {% endfor %}
    {% for c in c20 %}t20.{{ c }} as t20_{{ c }}, {% endfor %}
    {% for c in c21 %}t21.{{ c }} as t21_{{ c }}, {% endfor %}
    {% for c in c22 %}t22.{{ c }} as t22_{{ c }}, {% endfor %}
    {% for c in c23 %}t23.{{ c }} as t23_{{ c }}, {% endfor %}
    {% for c in c24 %}t24.{{ c }} as t24_{{ c }}, {% endfor %}
    1 as sentinel
from {{ ref('repro_wide_01') }} t01
join {{ ref('repro_wide_02') }} t02 on t01.id = t02.id - 1
join {{ ref('repro_wide_03') }} t03 on t01.id = t03.id - 2
join {{ ref('repro_wide_04') }} t04 on t01.id = t04.id - 3
join {{ ref('repro_wide_05') }} t05 on t01.id = t05.id - 4
join {{ ref('repro_wide_06') }} t06 on t01.id = t06.id - 5
join {{ ref('repro_wide_07') }} t07 on t01.id = t07.id - 6
join {{ ref('repro_wide_08') }} t08 on t01.id = t08.id - 7
join {{ ref('repro_wide_09') }} t09 on t01.id = t09.id - 8
join {{ ref('repro_wide_10') }} t10 on t01.id = t10.id - 9
join {{ ref('repro_wide_11') }} t11 on t01.id = t11.id - 10
join {{ ref('repro_wide_12') }} t12 on t01.id = t12.id - 11
join {{ ref('repro_wide_13') }} t13 on t01.id = t13.id - 12
join {{ ref('repro_wide_14') }} t14 on t01.id = t14.id - 13
join {{ ref('repro_wide_15') }} t15 on t01.id = t15.id - 14
join {{ ref('repro_wide_16') }} t16 on t01.id = t16.id - 15
join {{ ref('repro_wide_17') }} t17 on t01.id = t17.id - 16
join {{ ref('repro_wide_18') }} t18 on t01.id = t18.id - 17
join {{ ref('repro_wide_19') }} t19 on t01.id = t19.id - 18
join {{ ref('repro_wide_20') }} t20 on t01.id = t20.id - 19
join {{ ref('repro_wide_21') }} t21 on t01.id = t21.id - 20
join {{ ref('repro_wide_22') }} t22 on t01.id = t22.id - 21
join {{ ref('repro_wide_23') }} t23 on t01.id = t23.id - 22
join {{ ref('repro_wide_24') }} t24 on t01.id = t24.id - 23
