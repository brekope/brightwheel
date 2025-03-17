{{
    config(
        materialized="table"
    )
}}


/* source1 contains additional attributes about credentails */
select
     phone
    , credential_type
    , credential_number
    , status as credntial_status
    , expiration_date as credential_expiration_date
    , has_disciplinary_action
from {{ ref('prep__source1') }}
