# DRN Sky

*Sky-specific resolvers and storage utilities for Dynamic Resource Names.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

DRN Sky extends the core DRN system with support for Sky cloud resources, including S3 buckets, Lambdas, Graphene databases, and custom domains. For selected resource types, DRN Sky provides a storage interface for writing and removing additional environment-specific configuration data associated with DRNs locally.

## Features
- **Cloud Resource Resolvers**: Built-in support for `s3`, `lambda`, `graphene`, `domain`, `origin`, and `url`.
- **Environment Management**: Easily manage local environment data using the `store` and `remove` functions.
- **Transparent Integration**: Automatically registers all Sky resolvers upon import. 

## Installation

Use your favorite package manager to install:

```bash
pnpm install @dashkite/drn-sky
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
- [Recipes](./docs/recipes.md)
- [Reference](./docs/reference.md)
- [Technical Notes](./docs/technical-notes.md)
- [Testing](./docs/testing.md)
