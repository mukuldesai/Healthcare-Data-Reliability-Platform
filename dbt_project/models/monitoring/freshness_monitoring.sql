with encounter_freshness as (
    select
        'fct_encounters' as model_name,
        max(encounter_start) as latest_record_timestamp
    from {{ ref('fct_encounters') }}
),

claims_freshness as (
    select
        'fct_claims' as model_name,
        max(service_date) as latest_record_timestamp
    from {{ ref('fct_claims') }}
),

claim_txn_freshness as (
    select
        'fct_claim_transactions' as model_name,
        max(to_date) as latest_record_timestamp
    from {{ ref('fct_claim_transactions') }}
)

select
    model_name,
    latest_record_timestamp,
    current_timestamp as checked_at
from encounter_freshness

union all

select
    model_name,
    latest_record_timestamp,
    current_timestamp as checked_at
from claims_freshness

union all

select
    model_name,
    latest_record_timestamp,
    current_timestamp as checked_at
from claim_txn_freshness