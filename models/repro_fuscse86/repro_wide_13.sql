-- Repro upstream 13 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 13 as id, 'u13' as label_13
