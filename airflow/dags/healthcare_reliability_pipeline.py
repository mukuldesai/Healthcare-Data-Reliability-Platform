from __future__ import annotations

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator # type: ignore


default_args = {
    "owner": "mukul",
    "depends_on_past": False,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

DBT_PROJECT_DIR = r"C:\Mukul\Healthcare Data Reliability Platform\dbt_project"
DBT_VENV_ACTIVATE = r"C:\Mukul\Healthcare Data Reliability Platform\.venv\Scripts\activate"

with DAG(
    dag_id="healthcare_data_reliability_pipeline",
    default_args=default_args,
    description="Orchestrates dbt models and quality checks for the Healthcare Data Reliability Platform",
    schedule="0 8 * * *",
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["healthcare", "snowflake", "dbt", "data-reliability"],
) as dag:

    start_pipeline = BashOperator(
        task_id="start_pipeline",
        bash_command='echo "Starting Healthcare Data Reliability Pipeline"',
    )

    run_dbt_models = BashOperator(
        task_id="run_dbt_models",
        bash_command=(
            f'cd "{DBT_PROJECT_DIR}" && '
            f'call "{DBT_VENV_ACTIVATE}" && '
            'dbt run'
        ),
    )

    run_dbt_tests = BashOperator(
        task_id="run_dbt_tests",
        bash_command=(
            f'cd "{DBT_PROJECT_DIR}" && '
            f'call "{DBT_VENV_ACTIVATE}" && '
            'dbt test'
        ),
    )

    refresh_monitoring_models = BashOperator(
        task_id="refresh_monitoring_models",
        bash_command=(
            f'cd "{DBT_PROJECT_DIR}" && '
            f'call "{DBT_VENV_ACTIVATE}" && '
            'dbt run --select data_quality_metrics pipeline_health_dashboard row_count_monitoring freshness_monitoring'
        ),
    )

    start_pipeline >> run_dbt_models >> run_dbt_tests >> refresh_monitoring_models