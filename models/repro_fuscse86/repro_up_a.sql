-- Repro upstream A for FUSCSE-86. Synthetic data only.
-- Built once, then deliberately NOT selected, so it becomes a Frontier relation.
{{ config(materialized='table') }}
select 1 as id, 'alpha' as label_a
