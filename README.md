# DRN Sky

*Sky-specific resolvers and storage utilities for Dynamic Resource Names.*

DRN Sky extends the core DRN system with first-class support for Sky cloud resources, including S3, Lambda, Graphene, and custom domains. It also adds a storage interface for writing and removing additional environment-specific configuration data associated with DRNs locally.

For example, storing local environment configuration for an S3-backed DRN:

```coffeescript
import { store } from "@dashkite/drn-sky"

await store "drn:s3:my-bucket/config.json", { environment: "local" }
```

### Features
- **Cloud Resource Resolvers**: Built-in support for `s3`, `lambda`, `graphene`, and `domain`.
- **Unified Storage API**: Write data to any resource that supports the `store` operation.
- **Resource Deletion**: Remove resources using the `remove` function.
- **Transparent Integration**: Automatically registers all Sky resolvers upon import. Note: While DRN replacement is deep, DRNs themselves cannot be nested.

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
await store "drn:s3:my-bucket/data.txt", "Hello Sky"

# Remove a resource
await remove "drn:s3:my-bucket/temporary-file"
```

## Other Resources
- [Reference](./docs/reference.md): API documentation for storage and cloud-specific resolvers.
- [Recipes](./docs/recipes.md): Patterns for cloud resource management and storage.

## Status
This software is currently in active development and is not yet suitable for production use. Please report bugs or request features via the repository's issue tracker.
 tracker.
