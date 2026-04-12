use database healthcare_reliability_db;
use schema raw;

copy into raw_patients
from @healthcare_csv_stage/patients.csv
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;

copy into raw_encounters
from @healthcare_csv_stage/encounters.csv
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;

copy into raw_claims
from @healthcare_csv_stage/claims.csv
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;

copy into raw_claim_transactions
from @healthcare_csv_stage
pattern = '.*claims_transactions_part_.*[.]csv'
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;

copy into raw_providers
from @healthcare_csv_stage/providers.csv
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;

copy into raw_organizations
from @healthcare_csv_stage/organizations.csv
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;

copy into raw_payers
from @healthcare_csv_stage/payers.csv
file_format = (format_name = csv_file_format)
match_by_column_name = case_insensitive;