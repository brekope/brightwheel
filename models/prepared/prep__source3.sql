{{
    config(
        materialized="view"
    )
}}

select
    /* PK */
    1 || replace(phone, '-', '') as phone

    /* FKs and IDs */
    , agency_number
    , facility_id
    , operation as company_id

    /* attributes */
    , operation_name as company_name
    , address
    , city
    , state
    , zip
    , country
    , type
    , status
    , email_address as email
    , monitory_freqency

    /* booleans */
    , infant as is_infant
    , toddler as is_toddler
    , preschool as is_preschool
    , school as is_school_age

    /* timestamps and dates */
    , issue_date

    /* metrics */
    , capacity
from {{ source('raw_data', 'source3') }}