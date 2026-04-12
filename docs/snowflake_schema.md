# Snowflake Schema Design

## Project
Healthcare Data Reliability Platform

## Database
`healthcare_reliability_db`

## Schemas
The warehouse uses 3 schemas:

### 1. raw
Purpose:
- landing zone for cleaned CSV files
- minimal transformation
- preserves source structure for ingestion

Raw tables:
- raw_patients
- raw_encounters
- raw_claims
- raw_claim_transactions
- raw_providers
- raw_organizations
- raw_payers

### 2. staging
Purpose:
- standardize data types
- convert strings to dates and numerics
- trim and clean values
- prepare data for modeling in dbt

Staging models:
- stg_patients
- stg_encounters
- stg_claims
- stg_claim_transactions
- stg_providers
- stg_organizations
- stg_payers

### 3. marts
Purpose:
- final analytics-ready warehouse layer
- star-schema style dimensions and facts
- used for reporting, testing, and monitoring

Mart models:
- dim_patient
- dim_provider
- dim_hospital
- dim_payer
- fct_encounters
- fct_claims
- fct_claim_transactions

---

## Final Warehouse Design

### Dimensions

#### dim_patient
Grain: one row per patient

Columns:
- patient_id
- birth_date
- death_date
- gender
- race
- ethnicity
- city
- state
- zip_code
- healthcare_expenses
- healthcare_coverage
- marital_status

#### dim_provider
Grain: one row per provider

Columns:
- provider_id
- organization_id
- provider_name
- gender
- specialty
- city
- state
- zip_code
- latitude
- longitude
- encounter_count
- procedure_count

#### dim_hospital
Grain: one row per organization

Columns:
- organization_id
- organization_name
- city
- state
- zip_code
- latitude
- longitude
- revenue
- utilization

#### dim_payer
Grain: one row per payer

Columns:
- payer_id
- payer_name
- ownership
- city
- state_headquartered
- zip_code
- amount_covered
- amount_uncovered
- revenue
- covered_encounters
- uncovered_encounters
- covered_medications
- uncovered_medications
- covered_procedures
- uncovered_procedures
- covered_immunizations
- uncovered_immunizations
- unique_customers
- qols_avg
- member_months

### Facts

#### fct_encounters
Grain: one row per encounter

Columns:
- encounter_id
- patient_id
- provider_id
- organization_id
- payer_id
- encounter_start
- encounter_end
- encounter_class
- encounter_code
- encounter_description
- base_cost
- total_claim_cost
- payer_coverage

#### fct_claims
Grain: one row per claim

Columns:
- claim_id
- patient_id
- provider_id
- primary_patient_insurance_id
- secondary_patient_insurance_id
- department_id
- patient_department_id
- diagnosis_1
- diagnosis_2
- diagnosis_3
- diagnosis_4
- appointment_id
- current_illness_date
- service_date
- status_primary
- status_secondary
- status_patient
- outstanding_primary
- outstanding_secondary
- outstanding_patient
- last_billed_date_primary
- last_billed_date_secondary
- last_billed_date_patient
- claim_type_id_primary
- claim_type_id_secondary

#### fct_claim_transactions
Grain: one row per claim transaction line

Columns:
- transaction_id
- claim_id
- charge_id
- patient_id
- transaction_type
- amount
- payment_method
- from_date
- to_date
- place_of_service
- procedure_code
- diagnosis_ref_1
- diagnosis_ref_2
- diagnosis_ref_3
- diagnosis_ref_4
- units
- department_id
- unit_amount
- payments
- adjustments
- transfers
- outstanding
- appointment_id
- patient_insurance_id
- provider_id

---

## Snowflake Build Order

1. Create database
2. Create schemas
3. Create raw tables
4. Create file format
5. Create stage
6. Load CSV files into raw tables
7. Build staging models in dbt
8. Build mart models in dbt
9. Add tests and monitoring