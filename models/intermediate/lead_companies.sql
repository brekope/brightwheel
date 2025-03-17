{{
    config(
        materialized="table"
    )
}}

select
    company_name
    , address
    , city
    , state
    , zip
from {{ ref('prep__salesforce_leads') }}