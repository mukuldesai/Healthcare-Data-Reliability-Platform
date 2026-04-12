select
    trim(provider_id) as provider_id,
    trim(organization_id) as organization_id,
    trim(provider_name) as provider_name,
    upper(trim(gender)) as gender,
    trim(specialty) as specialty,
    trim(city) as city,
    trim(state) as state,
    trim(zip_code) as zip_code,
    latitude,
    longitude,
    encounter_count,
    procedure_count
from {{ source('raw', 'raw_providers') }}