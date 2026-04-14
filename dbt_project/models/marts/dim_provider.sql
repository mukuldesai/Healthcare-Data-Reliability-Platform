select
    provider_id,
    organization_id,
    provider_name,
    gender,
    specialty,
    city,
    state,
    zip_code,
    latitude,
    longitude,
    encounter_count,
    procedure_count
from {{ ref('stg_providers') }}