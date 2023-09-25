import assert from "@dashkite/assert"
import { test } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import Runner from "./runner"
import scenarios from "./scenarios"

do ->

  print await test "@dashkite/drn",
    Runner.scenarios scenarios
