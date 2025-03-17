{{
    config(
        materialized="view"
    )
}}

select
    /* PK */
    id as salesforce_lead_id
    , phone

    /* FKs and IDs */
    , brightwheel_school_uuid_c as brightwheel_school_id
    
    /* Attributes */
    , title
    , first_name
    , last_name
    , company as company_name
    , street as address
    , city
    , state
    , postal_code
    , split_part(postal_code, '-', 1) as zip
    , country
    , mobile_phone
    , lower(email) as email
    , website
    , lead_source
    , status
    , email_bounced_reason
    , outreach_stage_c as outreach_stage

    /* booleans */
    , is_converted
    , is_deleted

    /* Metrics */
    , current_enrollment_c as current_enrollment
    , capacity_c as capacity

    /* timestamps and dates */
    -- assuming UTC for the purposes of this exercise
    , created_date as created_at_utc
    , last_modified_date as last_modified_at_utc
    , last_activity_date
    , last_viewed_date
    , last_referenced_date
    , email_bounced_date
    , lead_source_last_updated_c as lead_source_last_updated_date
    
from {{ source('raw_data', 'salesforce_leads')}}