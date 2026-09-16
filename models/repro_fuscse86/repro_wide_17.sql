-- Repro upstream 17 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 17 as id, 'u17' as label_17
