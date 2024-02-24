import OS from "node:os"
import Crypto from "node:crypto"
import * as Fn from "@dashkite/joy/function"
import { command as exec } from "execa"
import { convert } from "@dashkite/bake"
import LocalStorage from "@dashkite/sky-local-storage"
import { confidential } from "panda-confidential"
{ randomBytes } = do confidential

run = ( action, options ) ->
  ( await exec action, { shell: true, options... }).stdout

getBranch = -> run "git branch --show-current"

getMachineKey = ->
  if ( configuration = await LocalStorage.read "machine" )?
    configuration.key
  else
    configuration =
      key: convert from: "bytes", to: "base36", await randomBytes 8
    await LocalStorage.write "machine", configuration
    configuration.key

md5 = (buffer) ->
  convert from: "bytes", to: "base36",
    new Uint8Array do ->
      Crypto
        .createHash "md5"
        .update buffer
        .digest()
        .buffer

truncate = Fn.curry ( length, text ) -> text[...length]

LocalAddress =

  compute: ( branch ) ->
    key = await do getMachineKey
    truncate 8,
      md5 "#{ key }#{ branch }"

  get: Fn.once ->
    branch = await do getBranch
    configurations = await LocalStorage.read "branches"
    if ( configuration = configurations?[ branch ])?
      configuration.address
    else LocalAddress.compute branch


export { LocalAddress }
export default LocalAddress