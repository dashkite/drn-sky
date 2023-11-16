import OS from "node:os"
import Crypto from "node:crypto"
import * as Fn from "@dashkite/joy/function"
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

truncate = Fn.curry ( length, text ) -> text[...length]

LocalAddress =

  get: Fn.once Fn.flow [
    getBranch
    Fn.pipe [
      ( branch ) -> "#{ getMAC() } #{ branch }"
      md5
      truncate 8 # characters
    ]
  ]

export { LocalAddress }
export default LocalAddress