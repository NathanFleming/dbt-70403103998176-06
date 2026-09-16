-- Repro upstream 20 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 20 as id, 'u20' as label_20
