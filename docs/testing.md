# Testing

This document details the testing approach for DRN Sky.

## General Approach

Testing in DRN Sky focuses on validating the correct parsing, templating, and resolution of URNs across various cloud resources. Tests verify the generation of correct URLs, endpoints, and domain names using mock data.
Tests also cover local storage functionalities for resolvers that implement `store` and `remove` to guarantee that state is successfully read from or written to the environment.

## Running Tests

To run the test suite for this repository, use the following command:

```bash
npx genie test
```
