import OS from "node:os"
import Crypto from "node:crypto"
import { command as exec } from "execa"
import { convert } from "@dashkite/bake"

run = ( action, options ) ->
  ( await exec action, { shell: true, options... }).stdout

getBranch = -> run "git branch --show-current"

getMAC = -> OS.networkInterfaces().en0[0].mac

md5 = (buffer) ->
  convert from: "bytes", to: "base36",
    new Uint8Array do ->
      Crypto
        .createHash "md5"
        .update buffer
        .digest()
        .buffer

LocalAddress = do ( address = undefined ) ->
  get: -> address ?= md5 "#{ getMAC() } #{ await getBranch() }"

export { LocalAddress }
export default LocalAddress