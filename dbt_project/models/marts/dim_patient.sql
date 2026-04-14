select
    patient_id,
    birth_date,
    death_date,
    gender,
    race,
    ethnicity,
    city,
    state,
    zip_code,
    healthcare_expenses,
    healthcare_coverage,
    marital_status
from {{ ref('stg_patients') }}