# Warehouse Data Model

## dim_patient
- Grain: one row per patient
- PK: patient_id
- Source: raw_patients

## dim_provider
- Grain: one row per provider
- PK: provider_id
- FK: organization_id
- Source: raw_providers

## dim_hospital
- Grain: one row per organization
- PK: organization_id
- Source: raw_organizations

## fct_encounters
- Grain: one row per encounter
- PK: encounter_id
- FK: patient_id, provider_id, organization_id
- Source: raw_encounters

## fct_claims
- Grain: one row per claim
- PK: claim_id
- FK: patient_id
- Source: raw_claims

## Source to Warehouse Mapping
- patients.csv → raw_patients → dim_patient
- encounters.csv → raw_encounters → fct_encounters
- claims.csv → raw_claims → fct_claims
- providers.csv → raw_providers → dim_provider
- organizations.csv → raw_organizations → dim_hospital