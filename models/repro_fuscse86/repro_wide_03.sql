-- Repro upstream 03 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 3 as id, 'u03' as label_03
