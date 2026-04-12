select
    trim(organization_id) as organization_id,
    trim(organization_name) as organization_name,
    trim(city) as city,
    trim(state) as state,
    trim(zip_code) as zip_code,
    latitude,
    longitude,
    revenue,
    utilization
from {{ source('raw', 'raw_organizations') }}