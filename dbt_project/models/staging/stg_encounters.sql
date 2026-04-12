select
    trim(encounter_id) as encounter_id,
    trim(patient_id) as patient_id,
    trim(provider_id) as provider_id,
    trim(organization_id) as organization_id,
    trim(payer_id) as payer_id,
    encounter_start,
    encounter_end,
    lower(trim(encounter_class)) as encounter_class,
    trim(encounter_code) as encounter_code,
    trim(encounter_description) as encounter_description,
    base_cost,
    total_claim_cost,
    payer_coverage
from {{ source('raw', 'raw_encounters') }}