-- Repro upstream 19 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 19 as id, 'u19' as label_19
