use database healthcare_reliability_db;
use schema raw;

create or replace file format csv_file_format
    type = csv
    field_delimiter = ','
    parse_header = true
    field_optionally_enclosed_by = '"'
    trim_space = true
    empty_field_as_null = true
    null_if = ('NULL', 'null', '');

create or replace stage healthcare_csv_stage
    file_format = csv_file_format;

