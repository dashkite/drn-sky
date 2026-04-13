# DRN Sky Recipes

Common patterns and task-based scenarios for working with Sky cloud resources via DRNs.

## Local Environment Configuration

### Task
Store local environment-specific configuration for an S3 bucket (e.g., an alias or development-only setting) that persists across sessions.

### DRN Sky Approach
Use the `store` function with an `s3` DRN to save data locally.

### Example
```coffeescript
import { store } from "@dashkite/drn-sky"

config = 
  environment: "dev"
  useLocalCache: true

await store "drn:s3:app-config", config
```

### Algorithm
1.  Identify the DRN for which you want to store local configuration.
2.  Prepare the configuration object.
3.  Call `store` with the DRN and the data to persist it locally.

## Resolving Graphene Resources

### Task
Retrieve a live Graphene resource instance for interaction.

### DRN Sky Approach
Use the `resolve` function with a `graphene` DRN.

### Example
```coffeescript
import { resolve } from "@dashkite/drn-sky"

resource = await resolve "drn:graphene:my-database"
# Use the resource object
data = await resource.get()
```

### Algorithm
1.  Identify the Graphene resource name.
2.  Call `resolve` with the `drn:graphene:<name>` string.
3.  Use the returned resource object for subsequent operations.

## Deleting Lambda Functions (Metadata)

### Task
Remove a reference or associated data for a Lambda function.

### DRN Sky Approach
Use the `remove` function with a `lambda` DRN.

### Example
```coffeescript
import { remove } from "@dashkite/drn-sky"

await remove "drn:lambda:obsolete-worker"
```

### Algorithm
1.  Identify the Lambda function name.
2.  Call `remove` with the `drn:lambda:<name>` string.
