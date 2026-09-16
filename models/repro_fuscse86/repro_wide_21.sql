-- Repro upstream 21 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 21 as id, 'u21' as label_21
