import { test } from "@dashkite/amen"
import assert from "@dashkite/assert"

# MUT
import * as DRN from "../src"

Runner =

  scenarios: ( scenarios ) ->
    for type, group of scenarios
      test type, Runner.group { type, group }
  
  group: ({ type, group }) ->
    for name, scenario of group
      test name, Runner.scenario { type, scenario }

  scenario: ({ type, scenario }) ->
    for name, description of scenario
      test name, Runner[ type ] description

  resolve: ({ uri, description, result, verbose }) -> ->
    
    name = undefined
    
    if uri?
      name = await DRN.resolve uri
      console.log [ uri ]: name if verbose == true
    else if description?
      name = await DRN.resolve description
      console.log description, name if verbose == true

    if result.start?
      assert name.startsWith result.start
    if result.end?
      assert name.endsWith result.end

  codex: ({ description, expect, verbose }) -> ->
    uri = DRN.encode description
    console.log description, uri if verbose == true
    assert.equal uri, expect.uri
    _description = DRN.decode uri
    console.log [ uri ]: _description if verbose == true
    assert.deepEqual description, _description

export default Runner