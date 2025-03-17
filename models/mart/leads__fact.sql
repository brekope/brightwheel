{{
    config(
        materialized= "table"
    )
}}

select
    /* PK */
    {{ dbt_utils.generate_surrogate_key(['phone'] )}} as lead_sk

    /* FKs */
    , {{ dbt_utils.generate_surrogate_key(['company_name']) }} as company_sk
    , {{ dbt_utils.generate_surrogate_key(['email']) }} as contact_sk
    , {{ dbt_utils.generate_surrogate_key(['source1']) }} as credentails_sk
    , {{ dbt_utils.generate_surrogate_key(['source2']) }} as company_schedule_sk
    , {{ dbt_utils.generate_surrogate_key(['source3']) }} as permits_sk

    /* Facts */
    , capacity
    , current_enrollment
    , is_new_lead

    /* timestamps and dates */
    , created_at_utc
    , last_modified_at_utc
    , last_activity_date
    , lead_source_last_updated_date

from {{ ref('leads') }}