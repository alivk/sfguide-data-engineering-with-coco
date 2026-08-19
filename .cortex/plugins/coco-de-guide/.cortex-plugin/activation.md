# coco-de-guide

Project-scoped CoCo Desktop plugin for this dbt + Snowflake data engineering project.

## What's included

- **Skills** (`./skills`) — task instructions for working in this project, notably creating new
  dbt models that follow the project's `source()`, `_schema.yml` testing, and `dbt build`
  conventions.
- **Agents** (`./agents`) — subagent definitions the main agent can delegate to for
  project-specific work such as reviewing models against `AGENTS.md`.
- **Hooks** (`./hooks/hooks.json`) — shell commands that run automatically on agent events, used
  to keep dbt work consistent (for example, validating models after edits).

## Context

Targets Snowflake `DEMO_DB.TPCH_TRANSFORMED` on warehouse `DEMO_WH`, with raw data sourced from
`SNOWFLAKE_SAMPLE_DATA.TPCH_SF1` via `dbt/models/_sources.yml`.

Being project-scoped (`.cortex/plugins/`), this plugin requires workspace trust before it
auto-activates.
