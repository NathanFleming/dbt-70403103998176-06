-- Repro upstream 04 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 4 as id, 'u04' as label_04
