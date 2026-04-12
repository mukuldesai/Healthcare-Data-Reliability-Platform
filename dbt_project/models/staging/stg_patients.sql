select
    trim(patient_id) as patient_id,
    birth_date,
    death_date,
    upper(trim(gender)) as gender,
    trim(race) as race,
    trim(ethnicity) as ethnicity,
    trim(city) as city,
    trim(state) as state,
    trim(zip_code) as zip_code,
    healthcare_expenses,
    healthcare_coverage,
    trim(marital_status) as marital_status
from {{ source('raw', 'raw_patients') }}