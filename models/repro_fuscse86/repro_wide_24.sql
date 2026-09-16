-- Repro upstream 24 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 24 as id, 'u24' as label_24
