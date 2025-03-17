{{
    config(
        materialized= "table"
    )
}}

select
    /* this is not unique in the data, but I am assuming this is the best PK for contacts within the real data */
    {{ dbt_utils.generate_surrogate_key(['email']) }} as contact_sk
    , email
    , first_name
    , last_name
    , full_name
    , title
from {{ ref('lead_contacts') }}