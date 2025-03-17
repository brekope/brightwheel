{{
    config(
        materialized="table"
    )
}}


/* source3 contains additional attributes ccenter license type and permis status */
select
     phone
    , status as permit_status
    , issue_date
    , capacity
    , facility_id
    , monitory_freqency
    , is_infant
    , is_toddler
    , is_preschool
    , is_school_age
from {{ ref('prep__source3') }}
