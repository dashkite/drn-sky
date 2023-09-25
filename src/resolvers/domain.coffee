import { Resolvers } from "@dashkite/drn"
import Domain from "#helpers/domain"
import { Default } from "./default"

Resolvers.register
  type: "domain" 
  template: "/domain/{name}/{namespace}/{tld}"
  apply: ( description ) -> Domain.from description
  describe: Default.describe

Resolvers.register
  type: "origin"
  template: "/origin/{name}/{namespace}/{tld}"
  apply: ( description ) ->
    "https://#{ await Domain.from description }"
  describe: Default.describe

