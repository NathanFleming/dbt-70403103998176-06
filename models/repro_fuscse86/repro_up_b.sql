-- Repro upstream B for FUSCSE-86. Synthetic data only.
-- Second relation is essential: the panic needs concurrency in the prefetch.
{{ config(materialized='table') }}
select 1 as id, 'bravo' as label_b
