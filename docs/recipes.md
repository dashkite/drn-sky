# DRN Sky Recipes

This guide provides common patterns and task-based scenarios for working with Sky cloud resources via DRNs.

## Local Environment Configuration

This section provides instructions for storing local environment-specific configuration for a Graphene resource (e.g., a local address override) that persists across sessions. 
The developer achieves this by using the `store` function with a `graphene` DRN to save data locally.

### Algorithm
1. Identify the DRN for which you want to store local configuration.
2. Prepare the environment data object.
3. Call `store` with the DRN and the data to persist it locally.

### Example
```coffeescript
import { store } from "@dashkite/drn-sky"

# The string address requires an address property.
await store "drn:graphene:db/my-app/my-db", address: "abc123"
```

## Resolving S3 URLs

This section explains how to resolve an S3 URN into a fully qualified origin URL.
The developer uses the `resolve` function exported by the package with an `s3` URN containing the `origin` scope to retrieve the HTTPS URL.

### Algorithm
1. Import `resolve` from `@dashkite/drn-sky`.
2. Provide a URN formatted with `s3:origin`.
3. Await the resolution of the URN.

### Example
```coffeescript
import { resolve } from "@dashkite/drn-sky"

# Resolves to a regional origin URL for the S3 bucket.
origin = await resolve "drn:s3:origin/my-app/com/my-bucket/us-west-2"
```

## Discovering Lambda Function URLs

This section demonstrates how to discover the public Function URL for a deployed Lambda function using its logical DRN.
The developer calls the `resolve` function with the `lambda:url` scope. The system will internally retrieve the associated HTTP endpoint from the cloud provider, decoupling the codebase from hardcoded URL identifiers.

### Algorithm
1. Import `resolve` from `@dashkite/drn-sky`.
2. Provide a URN formatted with `lambda:url`.
3. Await the resolution to receive the function's HTTP URL.

### Example
```coffeescript
import { resolve } from "@dashkite/drn-sky"

# Retrieves the dynamic function URL for a specific Lambda.
url = await resolve "drn:lambda:url/my-app/my-function"
```

## Constructing Qualified Custom Domains

This section covers how to resolve fully qualified custom domains or API endpoints based on logical naming components.
The developer uses the `domain` or `url` scope to generate domain names that adapt to the surrounding environment and namespace configuration without relying on static strings.

### Algorithm
1. Import `resolve` from `@dashkite/drn-sky`.
2. Provide a URN using the `url` type with an optional path segment.
3. Await the resolution to form a valid, environment-specific URL.

### Example
```coffeescript
import { resolve } from "@dashkite/drn-sky"

# Constructs a full HTTPS URL spanning a custom domain and path.
apiEndpoint = await resolve "drn:url/api/my-app/com/v1/users"
```
