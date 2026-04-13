# DRN Sky Recipes

Common patterns and task-based scenarios for working with Sky cloud resources via DRNs.

## Local Environment Configuration

### Task
Store local environment-specific configuration for a Graphene resource (e.g., a local address override) that persists across sessions.

Use the `store` function with a `graphene` DRN to save data locally.

### Example
```coffeescript
import { store } from "@dashkite/drn-sky"


await store "drn:graphene:db/my-db", address: "abc123"
```

### Algorithm
1.  Identify the DRN for which you want to store local configuration.
2.  Prepare the environment data.
3.  Call `store` with the DRN and the data to persist it locally.
