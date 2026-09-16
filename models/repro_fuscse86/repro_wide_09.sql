-- Repro upstream 09 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 9 as id, 'u09' as label_09
