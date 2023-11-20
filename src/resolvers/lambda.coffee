import { Resolvers } from "@dashkite/drn"
import LocalAddress from "#helpers/local-address"
import * as Text from "@dashkite/joy/text"
import {
  hasFunctionURL
  getFunctionURL
} from "@dashkite/dolores/lambda"

Resolver =

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

Resolvers.register Resolver
