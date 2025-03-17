{{
    config(
        materialized= "table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['company_name']) }} as company_sk
    , company_name
    , address
    , city
    , state
from {{ ref('lead_companies') }}