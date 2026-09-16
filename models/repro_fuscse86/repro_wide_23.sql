-- Repro upstream 23 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 23 as id, 'u23' as label_23
