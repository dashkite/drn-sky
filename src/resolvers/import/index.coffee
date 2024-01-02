import * as DRN from "@dashkite/drn"
import { resolve } from "./resolve"

DRN.Resolvers.register
  type: "import:url"
  template: "/import:url/{scope}/{name}/{path*}"
  apply: ({ scope, name, path }) ->
    resolve
      origin: await DRN.resolve "drn:origin/modules/dashkite/com"
      dependency:
        module: {
          scope
          name
        }
        source: { path: path.join "/" }
          
