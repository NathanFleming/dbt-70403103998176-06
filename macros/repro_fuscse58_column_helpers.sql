{#- Repro helpers mirroring Weedmaps' real macro pattern from ticket 133584 / FUSCSE-58 -#}

{% macro repro_get_events_columns() %}
    {{ return([
        {'name': 'ID', 'check_columns': true},
        {'name': 'CUSTOMER', 'check_columns': true},
        {'name': 'ORDERED_AT', 'check_columns': true},
        {'name': 'STORE_ID', 'check_columns': true},
        {'name': 'SUBTOTAL', 'check_columns': true},
        {'name': 'TAX_PAID', 'check_columns': false},
        {'name': 'ORDER_TOTAL', 'check_columns': false},
    ]) }}
{% endmacro %}

{% macro repro_get_column_names_from_config(columns, check_columns=false) %}
    {% set names = [] %}
    {% for col in columns %}
        {% if not check_columns or col.check_columns %}
            {% do names.append(col.name) %}
        {% endif %}
    {% endfor %}
    {{ return(names) }}
{% endmacro %}

{% macro repro_generate_fivetran_active_source(schema_name, table_name) %}
    {{ return(ref('raw_orders')) }}
{% endmacro %}
