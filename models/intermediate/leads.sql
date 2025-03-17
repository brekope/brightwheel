{{
    config(
        materialized ="table"
    )
}}


with salesforce as (
    select
       'salesforce_leads' as data_source
        , phone
        , lower(company_name) as company_name
        , email
        , brightwheel_school_id
        , lead_source
        , status
        , is_converted
        , created_at_utc
        , last_modified_at_utc
        , last_activity_date
        , lead_source_last_updated_date

        , outreach_stage

        , current_enrollment
        , capacity
    from {{ ref('prep__salesforce_leads') }}
)

select
    /* PK */
    coalesce(salesforce.phone, source1.phone, source2.phone, source3.phone) as phone
    , source1.phone as source1_phone
    , source2.phone as source2_phone
    , source2.phone as source3_phone

    , salesforce.company_name as company_name
    , salesforce.email
    , salesforce.brightwheel_school_id
    , salesforce.lead_source
    , salesforce.status
    , salesforce.is_converted
    , salesforce.created_at_utc
    , salesforce.last_modified_at_utc
    , salesforce.last_activity_date
    , salesforce.lead_source_last_updated_date

    , salesforce.outreach_stage
    , salesforce.current_enrollment
    , salesforce.capacity

    , case when salesforce.phone is null then true else false end as is_new_lead

from salesforce
full outer join {{ ref('inter__source1') }} as source1
   on salesforce.phone = source1.phone
full outer join {{ ref('inter__source2') }} as source1
   on salesforce.phone = source2.phone
full outer join {{ ref('inter__source3') }} as source3
   on salesforce.phone = prep__source3.phone