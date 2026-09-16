-- Repro upstream 10 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 10 as id, 'u10' as label_10
