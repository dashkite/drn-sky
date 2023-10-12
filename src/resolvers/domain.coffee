import { Resolvers } from "@dashkite/drn"
import Domain from "#helpers/domain"

Resolvers.register
  type: "domain" 
  template: "/domain/{name}/{namespace}/{tld}"
  apply: ( description ) -> Domain.from description
  describe: ( description ) ->
    Default.describe description

Resolvers.register
  type: "origin"
  template: "/origin/{name}/{namespace}/{tld}"
  apply: ( description ) ->
    "https://#{ await Domain.from description }"
  describe: ( description ) ->
    Default.describe description

