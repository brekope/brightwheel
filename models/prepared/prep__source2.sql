{{
    config(
        materialized="view"
    )
}}

select
    /* PK */
    1 || regexp_replace(phone, '[(),\- ]','','g') as phone

    /* FKs and IDs */
    --assuming the varchar in this string is a license ID
    , split_part(type_license, '-', 2) as licence_id
    , split_part(subsidy_contract_number, ': ', 2) as subsidy_contract_number

    /* attributes */
    , company as company_name
    , split_part(type_license, '-', 1) as licence_type
    , star_level
    , split_part(primary_caregiver, E'\n', 1) as primary_caregiver_name
    , split_part(primary_caregiver, E'\n', 2) as primary_caregiver_title
    , email
    -- Dropping address 2 because it is always null, if that wasn't the case I would combine them
    , address1 as address
    , city
    , state
    , zip

    , mon as monday
    , tues as tuesday
    , wed as wednesday
    , thurs as thursday
    , friday
    , saturday
    , sunday

    /* booleans */
    , accepts_subsidy = 'Accepts Subsidary' as does_accept_subsidary
    , year_round = 'Year Round' as is_year_round
    , daytime_hours = 'Daytime Hours' as is_daytime_hours
    , ages_accepted_1 = 'Infants (0-11 months)'
        or aa2 = 'Infants (0-11 months)'
        or aa3 = 'Infants (0-11 months)'
        or aa4 = 'Infants (0-11 months)'
    as is_infant
    , ages_accepted_1 = 'Toddlers (12-23 months; 1yr.)'
        or aa2 = 'Toddlers (12-23 months; 1yr.)'
        or aa3 = 'Toddlers (12-23 months; 1yr.)'
        or aa4 = 'Toddlers (12-23 months; 1yr.)'
    as is_toddler
    , ages_accepted_1 = 'Preschool (24-48 months; 2-4 yrs.)'
        or aa2 = 'Preschool (24-48 months; 2-4 yrs.)'
        or aa3 = 'Preschool (24-48 months; 2-4 yrs.)'
        or aa4 = 'Preschool (24-48 months; 2-4 yrs.)'
    as is_preschool
    , ages_accepted_1 = 'School-age (5 years-older)'
        or aa2 = 'School-age (5 years-older)'
        or aa3 = 'School-age (5 years-older)'
        or aa4 = 'School-age (5 years-older)'
    as is_school_age

    /* timestamps and dates */
    , to_date(split_part(license_monitoring_since, 'Monitoring since ', 2), 'YYYY-MM-DD') as license_monitoring_since_date

    /* metrics */
    , total_cap as capacity
from {{ source('raw_data', 'source2') }}