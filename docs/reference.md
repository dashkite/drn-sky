# DRN Sky Reference

Detailed API documentation for storage utilities and built-in Sky resolvers.

## Storage Utilities

#### store
$store: drn: string, data: any \dashrightarrow \emptyset$

Writes the provided data to the local environment configuration associated with the DRN. This allows for environment-specific overrides or additional metadata to be persisted locally.

```coffeescript
await store "drn:s3:my-bucket/key", { environment: "development" }
```

#### remove
$remove: drn: string \dashrightarrow \emptyset$

Deletes the resource identified by the DRN.

```coffeescript
await remove "drn:s3:my-bucket/old-file"
```

## Built-in Resolvers

DRN Sky automatically registers the following resource types:

### S3
**Type**: `s3`
**Template**: `/s3/{bucket}/{path*}`
**Capabilities**: `resolve`, `store`, `remove`

### Lambda
**Type**: `lambda`
**Template**: `/lambda/{name}`
**Capabilities**: `resolve`

### Graphene
**Type**: `graphene`
**Template**: `/graphene/{name}`
**Capabilities**: `resolve`, `store`, `remove`

### Domain
**Type**: `domain`
**Template**: `/domain/{name}`
**Capabilities**: `resolve`

# Technical Notes

### Storage Dispatch
The `store` and `remove` functions use the same internal router as `resolve` to identify the appropriate resolver. However, they specifically check for the presence of `store` and `remove` methods on the resolver object before execution.

### DRN Core Integration
DRN Sky exports all functions from the core `@dashkite/drn` package, including `resolve`, `replace`, and `describe`.
