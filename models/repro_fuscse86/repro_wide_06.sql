-- Repro upstream 06 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 6 as id, 'u06' as label_06
