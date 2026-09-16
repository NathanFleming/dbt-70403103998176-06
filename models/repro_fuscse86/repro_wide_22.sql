-- Repro upstream 22 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 22 as id, 'u22' as label_22
