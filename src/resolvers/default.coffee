import { Resolvers } from "@dashkite/drn"
import LocalAddress from "#helpers/local-address"
import * as Text from "@dashkite/joy/text"

Default =

  type: "default"

  template: "/{type}/{namespace}/{name}"
  apply: ({ namespace, name }) ->
    mode = process.env.mode ? "development"
    address = if mode == "development"
      await LocalAddress.get()
    else mode
    ( "#{namespace}-#{name}-#{address}" )[...32]

  describe: ({ type, namespace, name }) ->
    mode = process.env.mode ? "development"
    if mode == "development"
      address = await LocalAddress.get()
      Text.titleCase "#{ namespace } #{ name } #{ mode } #{address}"
    else
      Text.titleCase "#{ namespace } #{ name } #{ mode }"

Resolvers.register Default

# allow other implementations to delegate to the default
export { Default }