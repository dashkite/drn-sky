import Path from "node:path"
import Zephyr from "@dashkite/zephyr"
import XRL from "@dashkite/xrl"

# adapted from Atlas
# TODO possibly extract this into a module?

getHashes = ({ module }) ->
  Zephyr.read Path.join "..", module.name, ".sky", "hashes.yaml"

getHash = ({ module, source }) ->
  do ({ path, hashes } = {}) ->    
    if ( hashes = await getHashes { module } )?
      hashes[ source.path ] ?
        throw new Error "No hash 
          for[ #{ source.path } ] 
          in [ #{ module.name } ]"
    else
      throw new Error "No hashes found for module at 
        [ #{ module.name } ]"

getModuleURL = ({ origin, dependency }) ->
  do ({ scope, name } = dependency.module ) ->
    XRL.join [ 
      origin
      "@#{ scope }"
      name
    ]

getURL = ({ origin, dependency }) ->
  do ({ hash, base, path } = {}) ->
    path = dependency.source.path
    hash = await getHash dependency
    base = getModuleURL { origin, dependency }
    XRL.join [ base, hash, path ]

export { getURL as resolve }