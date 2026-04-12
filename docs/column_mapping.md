# Column Mapping

This document defines how cleaned Synthea CSV data is mapped into warehouse tables for Version 1 of the Healthcare Data Reliability Platform.

## Naming Standard
- all columns use lowercase snake_case
- all ID fields use standardized names such as `patient_id`, `encounter_id`, `claim_id`, `provider_id`, `organization_id`, and `payer_id`
- raw source files were cleaned for V1 consistency before loading

---

## 1. patients.csv → raw_patients → dim_patient

### Grain
One row per patient.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| patient_id | patient_id | Yes | Primary key |
| birth_date | birth_date | Yes | |
| death_date | death_date | Yes | |
| gender | gender | Yes | |
| race | race | Yes | |
| ethnicity | ethnicity | Yes | |
| city | city | Yes | |
| state | state | Yes | |
| zip_code | zip_code | Yes | |
| healthcare_expenses | healthcare_expenses | Yes | |
| healthcare_coverage | healthcare_coverage | Yes | |
| marital_status | marital_status | Yes | |

### Removed in V1
- names
- address
- latitude / longitude
- SSN / driver / passport
- other personal identifiers

---

## 2. encounters.csv → raw_encounters → fct_encounters

### Grain
One row per healthcare encounter.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| encounter_id | encounter_id | Yes | Primary key |
| patient_id | patient_id | Yes | FK |
| provider_id | provider_id | Yes | FK |
| organization_id | organization_id | Yes | FK |
| payer_id | payer_id | Yes | FK |
| encounter_start | encounter_start | Yes | |
| encounter_end | encounter_end | Yes | |
| encounter_class | encounter_class | Yes | |
| encounter_code | encounter_code | Yes | |
| encounter_description | encounter_description | Yes | |
| base_cost | base_cost | Yes | |
| total_claim_cost | total_claim_cost | Yes | |
| payer_coverage | payer_coverage | Yes | |

### Removed in V1
- duplicate timestamps
- extra low-value technical fields

---

## 3. claims.csv → raw_claims → fct_claims

### Grain
One row per claim record.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| claim_id | claim_id | Yes | Primary key |
| patient_id | patient_id | Yes | FK |
| provider_id | provider_id | Yes | FK |
| primary_patient_insurance_id | primary_patient_insurance_id | Yes | Main payer linkage |
| secondary_patient_insurance_id | secondary_patient_insurance_id | Yes | Secondary payer linkage |
| department_id | department_id | Yes | |
| patient_department_id | patient_department_id | Yes | |
| diagnosis_1 | diagnosis_1 | Yes | |
| diagnosis_2 | diagnosis_2 | Yes | |
| diagnosis_3 | diagnosis_3 | Yes | |
| diagnosis_4 | diagnosis_4 | Yes | |
| appointment_id | appointment_id | Yes | |
| current_illness_date | current_illness_date | Yes | |
| service_date | service_date | Yes | |
| status_primary | status_primary | Yes | |
| status_secondary | status_secondary | Yes | |
| status_patient | status_patient | Yes | |
| outstanding_primary | outstanding_primary | Yes | |
| outstanding_secondary | outstanding_secondary | Yes | |
| outstanding_patient | outstanding_patient | Yes | |
| last_billed_date_primary | last_billed_date_primary | Yes | |
| last_billed_date_secondary | last_billed_date_secondary | Yes | |
| last_billed_date_patient | last_billed_date_patient | Yes | |
| claim_type_id_primary | claim_type_id_primary | Yes | |
| claim_type_id_secondary | claim_type_id_secondary | Yes | |

### Removed in V1
- diagnosis_5
- diagnosis_6
- diagnosis_7
- diagnosis_8
- referring_provider_id
- supervising_provider_id

---

## 4. claims_transactions.csv → raw_claim_transactions → fct_claim_transactions

### Grain
One row per claim transaction line.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| transaction_id | transaction_id | Yes | Primary key |
| claim_id | claim_id | Yes | FK |
| charge_id | charge_id | Yes | |
| patient_id | patient_id | Yes | FK |
| transaction_type | transaction_type | Yes | |
| amount | amount | Yes | |
| payment_method | payment_method | Yes | |
| from_date | from_date | Yes | |
| to_date | to_date | Yes | |
| place_of_service | place_of_service | Yes | |
| procedure_code | procedure_code | Yes | |
| diagnosis_ref_1 | diagnosis_ref_1 | Yes | |
| diagnosis_ref_2 | diagnosis_ref_2 | Yes | |
| diagnosis_ref_3 | diagnosis_ref_3 | Yes | |
| diagnosis_ref_4 | diagnosis_ref_4 | Yes | |
| units | units | Yes | |
| department_id | department_id | Yes | |
| unit_amount | unit_amount | Yes | |
| payments | payments | Yes | |
| adjustments | adjustments | Yes | |
| transfers | transfers | Yes | |
| outstanding | outstanding | Yes | |
| appointment_id | appointment_id | Yes | |
| patient_insurance_id | patient_insurance_id | Yes | |
| provider_id | provider_id | Yes | FK |

### Removed in V1
- modifier1
- modifier2
- notes
- linenote
- transferoutid
- transfertype
- feescheduleid
- supervisingproviderid

---

## 5. providers.csv → raw_providers → dim_provider

### Grain
One row per provider.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| provider_id | provider_id | Yes | Primary key |
| organization_id | organization_id | Yes | FK |
| provider_name | provider_name | Yes | |
| gender | gender | Yes | |
| specialty | specialty | Yes | |
| city | city | Yes | |
| state | state | Yes | |
| zip_code | zip_code | Yes | |
| latitude | latitude | Yes | |
| longitude | longitude | Yes | |
| encounter_count | encounter_count | Yes | |
| procedure_count | procedure_count | Yes | |

### Removed in V1
- address

---

## 6. organizations.csv → raw_organizations → dim_hospital

### Grain
One row per healthcare organization.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| organization_id | organization_id | Yes | Primary key |
| organization_name | organization_name | Yes | |
| city | city | Yes | |
| state | state | Yes | |
| zip_code | zip_code | Yes | |
| latitude | latitude | Yes | |
| longitude | longitude | Yes | |
| revenue | revenue | Yes | |
| utilization | utilization | Yes | |

### Removed in V1
- address
- phone

---

## 7. payers.csv → raw_payers → dim_payer

### Grain
One row per payer.

### Selected Columns

| Source Column | Target Column | Keep? | Notes |
|--------------|--------------|------|------|
| payer_id | payer_id | Yes | Primary key |
| payer_name | payer_name | Yes | |
| ownership | ownership | Yes | |
| city | city | Yes | |
| state_headquartered | state_headquartered | Yes | |
| zip_code | zip_code | Yes | |
| amount_covered | amount_covered | Yes | |
| amount_uncovered | amount_uncovered | Yes | |
| revenue | revenue | Yes | |
| covered_encounters | covered_encounters | Yes | |
| uncovered_encounters | uncovered_encounters | Yes | |
| covered_medications | covered_medications | Yes | |
| uncovered_medications | uncovered_medications | Yes | |
| covered_procedures | covered_procedures | Yes | |
| uncovered_procedures | uncovered_procedures | Yes | |
| covered_immunizations | covered_immunizations | Yes | |
| uncovered_immunizations | uncovered_immunizations | Yes | |
| unique_customers | unique_customers | Yes | |
| qols_avg | qols_avg | Yes | |
| member_months | member_months | Yes | |

### Removed in V1
- address
- phone

---

## Final Warehouse Tables

### Dimensions
- dim_patient
- dim_provider
- dim_hospital
- dim_payer

### Facts
- fct_encounters
- fct_claims
- fct_claim_transactions