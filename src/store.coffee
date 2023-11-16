import { Resolvers } from "@dashkite/drn"

store = ( uri, data ) ->
  if ( match = Resolvers.match uri )?
    { resolver } = match
    if resolver.store?
      resolver.store uri, data
    else
      throw new Error "unable to store data
        for DRN [ #{ uri } ]" 
  else
    throw new Error "unable to parse DRN [ #{ uri } ]" 


remove = ( uri ) ->
  if ( match = Resolvers.match uri )?
    { resolver } = match
    if resolver.remove?
      resolver.remove uri
    else
      throw new Error "unable to remove data
        for DRN [ #{ uri } ]" 
  else
    throw new Error "unable to parse DRN [ #{ uri } ]" 

export { store, remove }