import { Resolvers } from "@dashkite/drn"
import {
  hasFunctionURL
  getFunctionURL
} from "@dashkite/dolores/lambda"

# lambda names use the default

# references to function URLs

Resolvers.register LambdaURL = 

  type: "lambda:url"

  template: "/lambda:url/{namespace}/{name}"

  apply: ({ namespace, name }) ->
    Default = Resolvers.dictionary.default
    name = await Default.apply { type: "lambda", namespace, name }
    if await hasFunctionURL name
      { FunctionUrl } = await getFunctionURL name
      FunctionUrl
    else
      throw new Error "No Function URL found for 
        Lambda [ #{ name } ]"

  describe: ({ type, namespace, name }) ->
    Default = Resolvers.dictionary.default
    name = await Default.apply { type: "lambda", namespace, name }
    "Function URL for Lambda [ #{ name } ]"

# function URL domains
Resolvers.register

  type: "lambda:domain"

  template: "/lambda:domain/{namespace}/{name}"

  apply: ({ namespace, name }) ->
    url = await LambdaURL.apply { namespace, name }
    ( new URL url ).hostname

  describe: ({ type, namespace, name }) ->
    Default = Resolvers.dictionary.default
    name = await Default.apply { type: "lambda", namespace, name }
    "Function URL domain for Lambda [ #{ name } ]"
