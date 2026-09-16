-- Repro upstream 08 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 8 as id, 'u08' as label_08
