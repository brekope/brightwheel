{{
    config(
        materialized="view"
    )
}}

select
    /* PK */
    /* This would need a country code look-up, but the sample data is all in US so just hard coding the 1 for time */
    1 || replace(phone, '-', '') as phone

    /* attributes */
    , credential_type
    , credential_number
    , name as company_name 
    , status
    , address /* this would need to extract just the street address to be consistent with other source */
    , split_part(split_part(address, ',', 1), ' ', -1) as city
    , split_part(address, ' ', -1) as zip
    , state
    , county
    
    , primary_contact_name
    , primary_contact_role

    /* booleans */
    , disciplinary_action as has_disciplinary_action
    , first_issue_date

    /* timestamps and dates */
    , expiration_date
from {{ source('raw_data', 'source1') }}