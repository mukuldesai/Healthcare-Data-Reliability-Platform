# Airflow Orchestration

This folder contains the Airflow DAG for orchestrating the Healthcare Data Reliability Platform.

## DAG
`healthcare_data_reliability_pipeline`

## Task Flow
1. start_pipeline
2. run_dbt_models
3. run_dbt_tests
4. refresh_monitoring_models

## Purpose
The DAG is designed to automate the transformation, testing, and monitoring refresh cycle for the Snowflake + dbt healthcare warehouse.

## Future Enhancements
- source freshness checks
- alerting for failed quality tests
- automated raw file ingestion