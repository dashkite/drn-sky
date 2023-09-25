import LocalStorage from "@dashkite/sky-local-storage"
import { Resolvers } from "@dashkite/drn"
import { Default } from "./default"

Resolvers.register
  type: "graphene"
  template: "/graphene/{namespace}/{name}"
  apply: ( description ) ->
    name = await Default.apply description
    if ( data = await LocalStorage.read name )?
      data.address
    else
      throw new Error "No address found for
        Graphene DB [ #{ name } ]"     
  describe: Default.describe
