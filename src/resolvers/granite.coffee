import LocalStorage from "@dashkite/sky-local-storage"
import { Resolvers, decode } from "@dashkite/drn"

Resolvers.register
  type: "granite:db"
  template: "/granite:db/{namespace}/{name}"
  apply: ( description ) ->
    Default = Resolvers.dictionary.default
    name = await ( Default.apply description )
    if ( data = await ( LocalStorage.read name ) )?
      data
    else
      throw new Error "No credentials found for Granite DB [ #{ name } ]"
  describe: ( description ) ->
    Default = Resolvers.dictionary.default
    ( Default.describe description )
  
  store: ( drn, data ) ->
    description = ( decode drn )
    Default = Resolvers.dictionary.default
    name = await ( Default.apply description )
    ( LocalStorage.write name, data )

  remove: ( drn ) ->
    description = ( decode drn )
    Default = Resolvers.dictionary.default
    name = await ( Default.apply description )
    ( LocalStorage.remove name )
