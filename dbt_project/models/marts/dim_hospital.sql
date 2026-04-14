select
    organization_id,
    organization_name,
    city,
    state,
    zip_code,
    latitude,
    longitude,
    revenue,
    utilization
from {{ ref('stg_organizations') }}