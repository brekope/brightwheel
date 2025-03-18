
### Birghtwheel Exercise
This dbt project consolidates multiple lead sources into reusable facts and dimensions. I made several assumptions, which are noted in this README and within the code comments.

## Summary
The project follows a standard three-layer model architecture:

# Architecture
- Prepared Layer: Stages raw data by renaming columns, adjusting data types, and creating base views for transformations. These models are implemented as views.
- Intermediate Layer: Handles core transformations, including joins and complex logic. Currently, models are materialized as tables for efficiency, but with real data, this layer would be incremental. The choice between incremental or table-based models depends on data size and complexity. This layer also incorpartes unique and not null test to prevent bad data from reaching stakeholders.
- Mart Layer: The final, consumer-facing layer containing facts and dimensions. This layer generates surrogate keys, and with more time, reporting models would be built.

# Final Models
Dimensions:
- Companies – Includes company name, address, type, grades serviced, etc.
- Contacts – Includes name, phone, email, etc. Assumes email is unique, though real data may require de-duplication.
- Credentials – Source 1 primarily contains additional information about company credentials. Given more time, I may integrate this data into the company dimension.
- Company Schedule – Source 2 primarily contains additional information about company schedules and subsidaries. Given more time, I may integrate this data into the company dimension.
- Permits – Source 3 primarily contains additional information about company permits. Given more time, I may integrate this data into the company dimension.

Facts
- Leads – Captures lead-related information.

The `is_new_lead` boolean flags leads that are not yet included in Salesforce and could be used to identify new leads. 
The `created_at_utc` identifies when the lead was created in Saleforce, it will be null if the lead does not exist in Saleforce.
The `status` and `last_activity` date columns can be used to get an idea of what leads are being worked on now or recently.
The `is_converted` flag and `lead_source` could be used to identify which lead source is performing the best over time.


## Exploring the data
Before modeling, I explored the dataset and found:

- No companies appeared in multiple sources.
- No consistent phone, company names, addresses, or primary contacts across sources.
- If the full dataset contained duplicate companies across sources, phone, address or email could be used for matching and deduplicainng the facts and dimensions. 


## Assumptions
- The full dataset follows the same format as the sample data.
- Boolean and ID columns maintain consistent formatting across the dataset (e.g., licence_id, subsidy_contract_number)
- All timestamps are in UTC.

## Future
With more time, I would enhance the project by:

- Incremental Models – The full dataset is likely much larger, requiring incremental processing for efficiency.
- Documentation – Completing YAML documentation for all models and columns, including source data.
- Implementing SCDs – Since new data overwrites old data, it may be difficult to track how leads move through different statuses to conversion. Creating Slowly Changing Dimensions (SCDs) would help maintain this history.
- Expanding Testing – Adding more tests to ensure leads are not being dropped from one layer to the next.
- Improving Lead Matching – Currently, leads are joined across sources using only phone numbers. Given more time, I would incorporate matching by addresses and possibly company names.
- Cleaning Address Data – I started cleaning address and state data but realized it would take longer than the allotted time. For a production implementation, I would fully clean the addresses and integrate them into the matching process.

Two hours is a limited timeframe for a project like this. A more in-depth exploratory analysis would be necessary to develop a logical model that fully meets business requirements. However, this serves as a starting point for tracking leads in Salesforce while incorporating external source data.
