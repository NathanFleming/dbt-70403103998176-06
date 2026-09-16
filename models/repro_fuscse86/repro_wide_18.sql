-- Repro upstream 18 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 18 as id, 'u18' as label_18
