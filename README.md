
### Birghtwheel Exercise
This dbt project consolidates multiple lead sources into reusable facts and dimensions. I made several assumptions, which are noted in this README and within the code comments.

## Summary
The project follows a standard three-layer model architecture:

# Architecture
- Prepared: Stages raw data, renames columns, adjusts data types, and creates base views for transformations. These are views.
- Intermediate: Performs the core transformations, including joins. This layer is incremental or table-based, depending on data size and complexity, with tests to prevent bad data from reaching stakeholders.
- Mart: The final, consumer-facing layer containing facts and dimensions. It also includes models for reporting or BI tools.

# Final Models
Dimensions:
- Companies – Includes company name, address, type, grades serviced, etc.
- Contacts – Includes name, phone, email, etc. Assumes email is unique, though real data may require de-duplication.

Facts
- Leads – Captures lead-related information.

## Exploring the data
Before modeling, I explored the dataset and found:

- No companies appeared in multiple sources.
- No consistent company names, addresses, or primary contacts across sources.
- If the full dataset contained duplicate companies across sources, address or email could potentially be used for matching.


## Assumptions
- The full dataset follows the same format as the sample data.
- Boolean and ID columns maintain consistent formatting across the dataset (e.g., licence_id, subsidy_contract_number)
- All timestamps are in UTC.

## Future
With more time, I would enhance:

- Incremental models – The full dataset is likely much larger, requiring incremental processing.
- Documentation – Complete YAML documentation for all models and columns, including source data.
- Company hours – Incorporate company hours from Source 2 into a separate dimension.

