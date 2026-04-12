# Source Data Notes

## patients.csv
- Grain: one row per patient
- Source PK: Id
- Important columns:
- Likely relationships:
- Use in v1: Yes

## encounters.csv
- Grain: one row per encounter
- Source PK: Id
- Source FKs: PATIENT, PROVIDER, ORGANIZATION
- Important columns:
- Likely relationships:
- Use in v1: Yes

## claims.csv
- Grain: one row per claim
- Source PK: Id
- Source FKs: PATIENT
- Important columns:
- Likely relationships:
- Use in v1: Yes

## providers.csv
- Grain: one row per provider
- Source PK: Id
- Source FK: ORGANIZATION
- Important columns:
- Likely relationships:
- Use in v1: Yes

## organizations.csv
- Grain: one row per organization
- Source PK: Id
- Important columns:
- Likely relationships:
- Use in v1: Yes