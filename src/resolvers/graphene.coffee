import LocalStorage from "@dashkite/sky-local-storage"
import { Resolvers, decode } from "@dashkite/drn"

Resolvers.register
  type: "graphene:db"
  template: "/graphene:db/{namespace}/{name}"
  apply: ( description ) ->
    Default = Resolvers.dictionary.default
    name = await Default.apply description
    if ( data = await LocalStorage.read name )?
      data.address
    else
      throw new Error "No address found for
        Graphene DB [ #{ name } ]"     
  describe: ( description ) ->
    Default = Resolvers.dictionary.default
    Default.describe description
  
  store: ( drn, { address }) ->
    description = decode drn
    Default = Resolvers.dictionary.default
    name = await Default.apply description
    LocalStorage.write name, { address }

  remove: ( drn ) ->
    description = decode drn
    Default = Resolvers.dictionary.default
    name = await Default.apply description
    LocalStorage.remove name
