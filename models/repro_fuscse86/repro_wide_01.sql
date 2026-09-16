-- Repro upstream 01 for FUSCSE-86. Synthetic data only.
{{ config(materialized='table') }}
select 1 as id, 'u01' as label_01
