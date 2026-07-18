# Technical Notes

This document contains technical details regarding the implementation of DRN Sky.

### Storage Dispatch

The `store` and `remove` functions use the same internal router as `resolve` to identify the appropriate resolver. However, they specifically check for the presence of `store` and `remove` methods on the resolver object before execution and throw an error if they are absent.

### DRN Core Integration

DRN Sky exports all functions from the core `@dashkite/drn` package, including `resolve`, `replace`, and `describe`. This ensures that developers can interact with DRN Sky as a drop-in replacement for the core library when working in Sky environments.

### Sky Architecture

Sky represents an architectural approach centered predominantly on serverless cloud computing, specifically focusing on RESTful patterns and purely serverless offerings rather than any branded framework. By embracing these prescriptive constraints, Sky minimizes the complexities associated with managing cloud infrastructure state.

The primary remaining challenges in this model revolve around naming and orchestration. The Dynamic Resource Name (DRN) system addresses naming complexity head-on. Rather than hardcoding physical endpoints or bucket names across an application, developers can rely on DRN to delegate and defer name literals with stable logical names. This allows infrastructure to remain loosely coupled and easily orchestrated.
