-- Repro upstream 14 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 14 as id, 'u14' as label_14
