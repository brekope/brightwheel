{{
    config(
        materialized ="table"
    )
}}

with
    state_abb as (
        select
            lower(state) as state_lower
            , abbreviation
        from {{ ref('state_abb_lookup') }}
    )
    , salesforce_leads as (
        select
             /* PK */
            salesforce_lead_id
        
            /* FKs and IDs */
            , brightwheel_school_id
            
            /* Attributes */
            , first_name
            , last_name
            , company_name
            , address
            , city
            , state
            , lower(state) as state_lower
            , postal_code
            , country
            , phone
            , mobile_phone
            , email
            , website
            , lead_source
            , email_bounced_reason
            , outreach_stage
        
            /* booleans */
            , is_converted
            , is_deleted
        
            /* Metrics */
            , current_enrollment
            , capacity
        
            /* timestamps and dates */
            , created_at_utc
            , last_modified_at_utc
            , last_activity_date
            , last_viewed_date
            , last_referenced_date
            , email_bounced_date
            , lead_source_last_updated_date
        from {{ ref('prep__salesforce_leads') }}
    )

select
    salesforce_leads.* 
    , state_abb.abbreviation as state_abb
from salesforce_leads
/* this does not account for all possible formats in the state string so it would likely need more cleaning */
left join state_abb
    on salesforce_leads.state_lower = state_abb.state_lower