select
    encounter_id,
    patient_id,
    provider_id,
    organization_id,
    payer_id,
    encounter_start,
    encounter_end,
    encounter_class,
    encounter_code,
    encounter_description,
    base_cost,
    total_claim_cost,
    payer_coverage
from {{ ref('stg_encounters') }}