# DRN Sky Reference

Detailed API documentation for storage utilities and built-in Sky resolvers.

## Storage Utilities

#### store
$store: drn: string, data: any \dashrightarrow \emptyset$

Writes the provided data to the local environment configuration associated with the DRN. This allows for environment-specific overrides or additional metadata to be persisted locally.

```coffeescript
await store "drn:graphene:db/my-db", { address: "abc123" }
```

#### remove
$remove: drn: string \dashrightarrow \emptyset$

Deletes the local environment data associated with the given DRN.

```coffeescript
await remove "drn:graphene:db/my-db"
```

## Resolvers

DRN Sky  registers the resolvers for each of the resource types described below.

> [!Note]
>
> In the templates below, the root (`/`) simply denotes the start of the URN. Within a DRN URI, the root would be replaced by the `drn:` scheme.

### Default

The default resolver acts a fallback: if a more specific template isn’t provided, the default template is used.

#### Types

`default`

#### Template

`/{type}/{namespace}/{name}`

### S3

S3 resolvers provide access to bucket-related metadata across various scopes and subtypes.

#### Types

##### Scopes

- **regional**: (Default) Region-specific endpoints.
- **global**: Region-independent endpoints.
- **website**: S3 website hosting endpoints.

##### Subtypes

- **domain**: The hostname for the bucket.
- **origin**: The full HTTPS URL for the bucket hostname.
- **url**: The S3 path-style URL.


`s3:domain`, `s3:origin`, `s3:url`, `s3:regional:domain`, `s3:regional:origin`, `s3:regional:url`, `s3:global:domain`, `s3:global:origin`, `s3:global:url`, `s3:website:domain`, `s3:website:origin`

#### Templates

- `/{type}/{name}/{namespace}/{tld}/{region?}`
- `/{type}/{namespace}/{tld}/{region?}`
- `/{type}/{name}/{namespace}/{tld}` (global)
- `/{type}/{namespace}/{tld}` (global)

### Lambda

#### Types

`lambda:url`, `lambda:domain`

#### Templates

- `/lambda:url/{namespace}/{name}`
- `/lambda:domain/{namespace}/{name}`

Note: Basic Lambda names (e.g., `drn:lambda:namespace/name`) use the **Default** resolver.

### Graphene

Provides resolution for Graphene database addresses, supporting local configuration via `store` and `remove`.

#### Type

`graphene:db`

#### Template

`/graphene:db/{namespace}/{name}`

### Domain

#### Type

`domain`, `apex domain`, `origin`, `url`

#### Templates

- `/domain/{name}/{namespace}/{tld}`
- `/domain/{namespace}/{tld}` (apex)
- `/origin/{name}/{namespace}/{tld}`
- `/url/{name}/{namespace}/{tld}/{path*}`

# Technical Notes

### Storage Dispatch

The `store` and `remove` functions use the same internal router as `resolve` to identify the appropriate resolver. However, they specifically check for the presence of `store` and `remove` methods on the resolver object before execution and throw if they’re absent.

### DRN Core Integration

DRN Sky exports all functions from the core `@dashkite/drn` package, including `resolve`, `replace`, and `describe`.
