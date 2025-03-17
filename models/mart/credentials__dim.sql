{{
    config(
        materialized= "table"
    )
}}

select
   /* I would not use a select * in production */
   {{ dbt_utils.generate_surrogate_key(['phone']) }} as credentails_sk
   , *
from {{ ref('inter__source1') }}