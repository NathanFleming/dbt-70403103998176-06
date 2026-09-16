-- Repro upstream 16 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 16 as id, 'u16' as label_16
