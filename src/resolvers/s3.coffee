import Domain from "#helpers/domain"
import { Resolvers } from "@dashkite/drn"
import { Default } from "./default"

Resolvers.register
  type: "s3"
  template: "/s3/{name}/{namespace}/{tld}/{region?}"
  apply: ( description ) ->
    region = description.region ? "us-east-1"
    domain = await Domain.from description
    "#{domain}.s3.#{region}.amazonaws.com"
  describe: Default.describe

Resolvers.register
  type: "s3-website"
  template: "/s3-website/{name}/{namespace}/{tld}/{region?}"
  apply: ( description ) ->
    region = description.region ? "us-east-1"
    domain = await Domain.from description
    "#{domain}.s3-website-#{region}.amazonaws.com"
  describe: Default.describe
