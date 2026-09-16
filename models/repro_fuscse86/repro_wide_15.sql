-- Repro upstream 15 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 15 as id, 'u15' as label_15
