select
    model_name,
    row_count,
    null_key_count,
    duplicate_key_count,
    case
        when row_count = 0 then 'critical'
        when null_key_count > 0 then 'warning'
        when duplicate_key_count > 0 then 'warning'
        else 'healthy'
    end as pipeline_status,
    current_timestamp as generated_at
from {{ ref('data_quality_metrics') }}