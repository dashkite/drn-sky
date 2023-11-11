import Domain from "#helpers/domain"
import { Resolvers } from "@dashkite/drn"

Generators =

  website:

    domain: ({ domain, region }) ->
      "#{ domain }.s3-website-#{ region }.amazonaws.com"

    origin: ( description ) ->
      "https://#{ Generators.website.domain descripton }"

  regional:
  
    domain: ({ domain, region }) ->
      "#{ domain }.s3.#{ region }.amazonaws.com"

    origin: ( description ) ->
      "https://#{ Generators.regional.domain descripton }"

  global:
  
    domain: ({ domain }) ->
      "#{ domain }.s3.amazonaws.com"
     
     origin: ( description ) ->
      "http://#{ Generators.global.domain description }"

Generator =

  find: ({ scope, subtype }) ->
    Generators[ scope ][ subtype ]

Resolvers.register

  type: "s3"

  template: "/s3/{scope}/{subtype}/{name}/{namespace}/{tld}/{region?}"

  apply: ({ scope, subtype, region, description... }) ->
    domain = await Domain.from description
    region ?= "us-east-1"
    if ( generator = Generator.find { scope, subtype })?
      generator { scope, subtype, domain, region, description... }
    else
      throw new Error "unable to resolve S3 DRN with
        scope [ #{ scope } ] and subtype [ #{ subtype } ]"

  describe: ( description ) ->
    Default.describe description

