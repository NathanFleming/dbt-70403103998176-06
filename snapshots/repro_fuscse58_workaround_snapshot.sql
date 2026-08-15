-- Workaround test: outer tags use whitespace-control dashes to avoid the
-- conform_normalized_snapshot_raw_code_to_mantle_format bug, where the opening-tag
-- strip greedily matches the first "-%}" anywhere in the file rather than the
-- opening tag's own boundary.
{%- snapshot repro_fuscse58_workaround_snapshot -%}

{%- set check_columns = repro_get_column_names_from_config(repro_get_events_columns(), check_columns=true) -%}
{%- set column_names = repro_get_column_names_from_config(repro_get_events_columns()) -%}

{{
    config(
      unique_key='ID',
      strategy='check',
      check_cols=check_columns,
      invalidate_hard_deletes=true,
    )
}}

select
    {% for column_name in column_names -%}
        {{ column_name }} as {{ column_name }}{%- if not loop.last %},{%- endif -%}
    {%- endfor %}
from {{ repro_generate_fivetran_active_source('raw', 'orders') }}

{%- endsnapshot -%}
