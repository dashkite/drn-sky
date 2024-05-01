import { Resolvers } from "@dashkite/drn"
import Domain from "#helpers/domain"

Resolvers.register
  type: "domain" 
  template: "/domain/{name}/{namespace}/{tld}"
  apply: ( description ) -> Domain.from description
  describe: ( description ) ->
    Default.describe description

Resolvers.register
  type: "apex domain" 
  template: "/domain/{namespace}/{tld}"
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

Resolvers.register
  type: "url"
  template: "/url/{name}/{namespace}/{tld}/{path*}"
  apply: ({ name, namespace, tld, path }) ->
    path = if description.path.length > 0
      "/" + description.path.join "/"
    else ""
    domain = await Domain.from domain: [ name, namespace, tld ]
    "https://#{ domain }#{ path }"
  describe: ( description ) ->
    Default.describe description
