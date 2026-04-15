with patient_metrics as (
    select
        'dim_patient' as model_name,
        count(*) as row_count,
        sum(case when patient_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct patient_id) as duplicate_key_count
    from {{ ref('dim_patient') }}
),

provider_metrics as (
    select
        'dim_provider' as model_name,
        count(*) as row_count,
        sum(case when provider_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct provider_id) as duplicate_key_count
    from {{ ref('dim_provider') }}
),

hospital_metrics as (
    select
        'dim_hospital' as model_name,
        count(*) as row_count,
        sum(case when organization_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct organization_id) as duplicate_key_count
    from {{ ref('dim_hospital') }}
),

payer_metrics as (
    select
        'dim_payer' as model_name,
        count(*) as row_count,
        sum(case when payer_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct payer_id) as duplicate_key_count
    from {{ ref('dim_payer') }}
),

encounter_metrics as (
    select
        'fct_encounters' as model_name,
        count(*) as row_count,
        sum(case when encounter_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct encounter_id) as duplicate_key_count
    from {{ ref('fct_encounters') }}
),

claims_metrics as (
    select
        'fct_claims' as model_name,
        count(*) as row_count,
        sum(case when claim_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct claim_id) as duplicate_key_count
    from {{ ref('fct_claims') }}
),

claim_txn_metrics as (
    select
        'fct_claim_transactions' as model_name,
        count(*) as row_count,
        sum(case when transaction_id is null then 1 else 0 end) as null_key_count,
        count(*) - count(distinct transaction_id) as duplicate_key_count
    from {{ ref('fct_claim_transactions') }}
)

select * from patient_metrics
union all
select * from provider_metrics
union all
select * from hospital_metrics
union all
select * from payer_metrics
union all
select * from encounter_metrics
union all
select * from claims_metrics
union all
select * from claim_txn_metrics