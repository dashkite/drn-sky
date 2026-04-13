# DRN Sky

*Sky-specific resolvers and storage utilities for Dynamic Resource Names.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

DRN Sky extends the core DRN system with support for Sky cloud resources, including S3 buckets, Lambdas, Graphene databases, and custom domains. For selected resource types, DRN Sky provides a storage interface for writing and removing additional environment-specific configuration data associated with DRNs locally.

For example, storing local environment configuration for a Graphene-backed DRN:

```coffeescript
import { store } from "@dashkite/drn-sky"

await store "drn:graphene:db/my-app/my-db", { address: "abc123" }
```

### Features
- **Cloud Resource Resolvers**: Built-in support for `s3`, `lambda`, `graphene`, `domain`, `origin`, and `url`.
- **Environment Management**: Easily manage local environment data using the `store` and `remove` functions.
- **Transparent Integration**: Automatically registers all Sky resolvers upon import. 

## Installation

Use your favorite package manager to install:

```bash
pnpm add @dashkite/drn-sky
```

## Usage

DRN Sky is a preset for `@dashkite/drn` that includes additional storage methods and cloud-aware resolvers.

```coffeescript
import { resolve, store, remove } from "@dashkite/drn-sky"

# Resolve a cloud resource
bucket = await resolve "drn:s3:my-bucket"

# Store data
await store "drn:graphene:db/my-app/my-db", { address: "abc123" }

# Remove a resource
await remove "drn:graphene:db/my-app/my-db"
```

## Other Resources
- [Reference](./docs/reference.md): API documentation for storage and cloud-specific resolvers.
- [Recipes](./docs/recipes.md): Patterns for cloud resource management and storage.

## Status
This software is currently in active development and is not yet suitable for production use. Please report bugs or request features via the repository's issue tracker.
