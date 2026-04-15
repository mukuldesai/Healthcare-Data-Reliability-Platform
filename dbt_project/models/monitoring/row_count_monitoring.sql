select 'raw_patients' as model_name, count(*) as row_count from {{ source('raw', 'raw_patients') }}
union all
select 'raw_encounters' as model_name, count(*) as row_count from {{ source('raw', 'raw_encounters') }}
union all
select 'raw_claims' as model_name, count(*) as row_count from {{ source('raw', 'raw_claims') }}
union all
select 'raw_claim_transactions' as model_name, count(*) as row_count from {{ source('raw', 'raw_claim_transactions') }}
union all
select 'raw_providers' as model_name, count(*) as row_count from {{ source('raw', 'raw_providers') }}
union all
select 'raw_organizations' as model_name, count(*) as row_count from {{ source('raw', 'raw_organizations') }}
union all
select 'raw_payers' as model_name, count(*) as row_count from {{ source('raw', 'raw_payers') }}
union all
select 'dim_patient' as model_name, count(*) as row_count from {{ ref('dim_patient') }}
union all
select 'dim_provider' as model_name, count(*) as row_count from {{ ref('dim_provider') }}
union all
select 'dim_hospital' as model_name, count(*) as row_count from {{ ref('dim_hospital') }}
union all
select 'dim_payer' as model_name, count(*) as row_count from {{ ref('dim_payer') }}
union all
select 'fct_encounters' as model_name, count(*) as row_count from {{ ref('fct_encounters') }}
union all
select 'fct_claims' as model_name, count(*) as row_count from {{ ref('fct_claims') }}
union all
select 'fct_claim_transactions' as model_name, count(*) as row_count from {{ ref('fct_claim_transactions') }}