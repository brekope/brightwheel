{{
    config(
        materialized="table"
    )
}}
{% set core_columns =[
    'emai'
    , 'first_name'
    , 'last_name'
    , 'full_name'
    , 'title'
    , 'phone'
    , 'mobile_phone'
    ]
%}

select
    'salesforce_leads' as data_source
    , email
    , first_name
    , last_name
    , first_name || ' ' || last_name as full_name
    , title    
from {{ ref('prep__salesforce_leads') }}
