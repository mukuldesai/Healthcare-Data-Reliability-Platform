use database healthcare_reliability_db;
use schema raw;

-- =========================
-- 1. RAW PATIENTS
-- =========================
create or replace table raw_patients (
    patient_id varchar,
    birth_date date,
    death_date date,
    gender varchar,
    race varchar,
    ethnicity varchar,
    city varchar,
    state varchar,
    zip_code varchar,
    healthcare_expenses number,
    healthcare_coverage number,
    marital_status varchar
);

-- =========================
-- 2. RAW ENCOUNTERS
-- =========================
create or replace table raw_encounters (
    encounter_id varchar,
    patient_id varchar,
    provider_id varchar,
    organization_id varchar,
    payer_id varchar,
    encounter_start timestamp,
    encounter_end timestamp,
    encounter_class varchar,
    encounter_code varchar,
    encounter_description varchar,
    base_cost number,
    total_claim_cost number,
    payer_coverage number
);

-- =========================
-- 3. RAW CLAIMS
-- =========================
create or replace table raw_claims (
    claim_id varchar,
    patient_id varchar,
    provider_id varchar,
    primary_patient_insurance_id varchar,
    secondary_patient_insurance_id varchar,
    department_id varchar,
    patient_department_id varchar,
    diagnosis_1 varchar,
    diagnosis_2 varchar,
    diagnosis_3 varchar,
    diagnosis_4 varchar,
    appointment_id varchar,
    current_illness_date date,
    service_date date,
    status_primary varchar,
    status_secondary varchar,
    status_patient varchar,
    outstanding_primary number,
    outstanding_secondary number,
    outstanding_patient number,
    last_billed_date_primary date,
    last_billed_date_secondary date,
    last_billed_date_patient date,
    claim_type_id_primary varchar,
    claim_type_id_secondary varchar
);

-- =========================
-- 4. RAW CLAIM TRANSACTIONS
-- =========================
create or replace table raw_claim_transactions (
    transaction_id varchar,
    claim_id varchar,
    charge_id varchar,
    patient_id varchar,
    transaction_type varchar,
    amount number,
    payment_method varchar,
    from_date date,
    to_date date,
    place_of_service varchar,
    procedure_code varchar,
    diagnosis_ref_1 varchar,
    diagnosis_ref_2 varchar,
    diagnosis_ref_3 varchar,
    diagnosis_ref_4 varchar,
    units number,
    department_id varchar,
    unit_amount number,
    payments number,
    adjustments number,
    transfers number,
    outstanding number,
    appointment_id varchar,
    patient_insurance_id varchar,
    provider_id varchar
);

-- =========================
-- 5. RAW PROVIDERS
-- =========================
create or replace table raw_providers (
    provider_id varchar,
    organization_id varchar,
    provider_name varchar,
    gender varchar,
    specialty varchar,
    city varchar,
    state varchar,
    zip_code varchar,
    latitude float,
    longitude float,
    encounter_count number,
    procedure_count number
);

-- =========================
-- 6. RAW ORGANIZATIONS
-- =========================
create or replace table raw_organizations (
    organization_id varchar,
    organization_name varchar,
    city varchar,
    state varchar,
    zip_code varchar,
    latitude float,
    longitude float,
    revenue number,
    utilization number
);

-- =========================
-- 7. RAW PAYERS
-- =========================
create or replace table raw_payers (
    payer_id varchar,
    payer_name varchar,
    ownership varchar,
    city varchar,
    state_headquartered varchar,
    zip_code varchar,
    amount_covered number,
    amount_uncovered number,
    revenue number,
    covered_encounters number,
    uncovered_encounters number,
    covered_medications number,
    uncovered_medications number,
    covered_procedures number,
    uncovered_procedures number,
    covered_immunizations number,
    uncovered_immunizations number,
    unique_customers number,
    qols_avg float,
    member_months number
);