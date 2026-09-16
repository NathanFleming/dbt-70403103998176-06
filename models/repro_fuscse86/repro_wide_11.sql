-- Repro upstream 11 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 11 as id, 'u11' as label_11
