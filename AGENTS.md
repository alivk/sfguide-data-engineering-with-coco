# AGENTS.md

Guidance for AI agents working in this repository.

## Snowflake environment

| Setting   | Value             |
| --------- | ----------------- |
| Database  | `DEMO_DB`         |
| Schema    | `TPCH_TRANSFORMED` |
| Warehouse | `DEMO_WH`         |

## Source data

- All raw data comes from the `TPCH_SF1` schema in the `SNOWFLAKE_SAMPLE_DATA` database.
- Never reference raw tables directly. Every raw table must be declared in
  `dbt/models/_sources.yml` and referenced through `{{ source(...) }}`.

## dbt commands

Build the whole project:

```
dbt build --project-dir dbt/
```

Build a single model:

```
dbt build --select <model_name> --project-dir dbt/
```

## Conventions

- Model file names use `snake_case` (e.g. `orders_summary.sql`).

## Git workflow

- Feature branches follow the pattern `feature/<description>`.
- A pull request is required before merging to `main`. Do not commit directly to `main`.

## Tooling

- This project uses CoCo Desktop. Do not use the `cortex` CLI command.
