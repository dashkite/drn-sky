import { Resolvers } from "@dashkite/drn"
import Domain from "#helpers/domain"

Resolvers.register
  type: "domain" 
  template: "drn:domain/{name}/{namespace}/{tld}"
  apply: ( description ) -> Domain.from description
  describe: ( description ) ->
    Default.describe description

Resolvers.register
  type: "apex domain" 
  template: "drn:domain/{namespace}/{tld}"
  apply: ( description ) -> Domain.from description
  describe: ( description ) ->
    Default.describe description

Resolvers.register
  type: "origin"
  template: "drn:origin/{name}/{namespace}/{tld}"
  apply: ( description ) ->
    "https://#{ await Domain.from description }"
  describe: ( description ) ->
    Default.describe description

Resolvers.register
  type: "url"
  template: "drn:url/{name}/{namespace}/{tld}/{path*}"
  apply: ({ name, namespace, tld, path }) ->
    path = if path.length > 0 then ( "/" + path.join "/" ) else ""
    domain = await Domain.from { name, namespace, tld }
    "https://#{ domain }#{ path }"
  describe: ( description ) ->
    Default.describe description
