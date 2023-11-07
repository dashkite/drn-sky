import Domain from "#helpers/domain"
import { Resolvers } from "@dashkite/drn"

# Resolvers.register
#   type: "s3"
#   template: "/s3/{name}/{namespace}/{tld}/{region?}"
#   apply: ( description ) ->
#     region = description.region ? "us-east-1"
#     domain = await Domain.from description
#     "#{domain}.s3.#{region}.amazonaws.com"
#   describe: ( description ) ->
#     Default.describe description

Resolvers.register
  type: "s3"
  template: "/s3/{name}/{namespace}/{tld}"
  apply: ( description ) ->
    domain = await Domain.from description
    "#{ domain }.s3.amazonaws.com"
  describe: ( description ) ->
    Default.describe description

Resolvers.register
  type: "s3-website"
  template: "/s3-website/{name}/{namespace}/{tld}/{region?}"
  apply: ( description ) ->
    region = description.region ? "us-east-1"
    domain = await Domain.from description
    "#{ domain }.s3-website-#{ region }.amazonaws.com"
  describe: ( description ) ->
    Default.describe description
