-- Repro upstream 05 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 5 as id, 'u05' as label_05
