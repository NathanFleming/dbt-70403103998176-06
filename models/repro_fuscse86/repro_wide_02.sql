-- Repro upstream 02 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 2 as id, 'u02' as label_02
