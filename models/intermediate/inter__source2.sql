{{
    config(
        materialized="table"
    )
}}


/* source2 contains additional attributes company hours and subsidary status */
select
     phone
    , subsidy_contract_number
    , does_accept_subsidary
    , is_year_round
    , is_daytime_hours
    , star_level
    , monday
    , tuesday
    , wednesday
    , thursday
    , friday
    , saturday
    , sunday
    , primary_caregiver_name    
    , is_infant
    , is_toddler
    , is_preschool
    , is_school_age
from {{ ref('prep__source2') }}
