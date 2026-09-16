-- Repro upstream 12 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 12 as id, 'u12' as label_12
