-- Repro upstream 07 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 7 as id, 'u07' as label_07
