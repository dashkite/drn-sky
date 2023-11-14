import Domain from "#helpers/domain"
import { Resolvers } from "@dashkite/drn"

# helpers for defining generators
apply = alias = ( type ) ->
  ( description ) -> ( Templates[ type ] description )

prefix = ( text, type ) ->
  f = apply type
  ( description ) -> "#{ text }#{ f description }"

# generator templates
Templates =

  "s3:regional:domain": ({ domain, region }) ->
    "#{ domain }.s3.#{ region }.amazonaws.com"

  "s3:domain": alias "s3:regional:domain"

  "s3:global:domain":  ({ domain, region }) ->
    "#{ domain }.s3.amazonaws.com"

  "s3:regional:origin": prefix "https://", "s3:regional:domain"

  "s3:origin": alias "s3:regional:origin"

  "s3:global:origin": prefix "https://", "s3:global:domain"

  "s3:regional:url": ({ domain, region }) ->
    "https://s3.#{ region }.amazonaws.com/#{ domain }"

  "s3:url": alias "s3:regional:url"

  "s3:global:url": ({ domain, region }) ->
    "https://s3.amazonaws.com/#{ domain }"

  "s3:website:domain": ({ domain, region }) ->
    "#{ domain }.s3-website-#{ region }.amazonaws.com"

  "s3:website:origin": prefix "https://", "s3:website:domain"

describe = ( description ) ->
  Default = Resolvers.dictionary.default
  Default.describe description

# register the resolvers for the various subtypes/scopes

for scope in [ "regional", "global", "website" ]
  for subtype in [ "domain", "origin", "url" ]
    type = "s3:#{ subtype }"
    qtype = "s3:#{ scope }:#{ subtype }"

    switch scope

      when "website"
        # websites don't have the URL form
        # otherwise, always qualified, ex: s3:website:origin
        unless subtype == "url"
          Resolvers.register
            type: qtype
            template: "/#{ qtype }/{name}/{namespace}/{tld}/{region?}"
            apply: apply qtype
            describe: describe
  
      when "global"
        # global is always qualified, ex: s3:global:domain
        Resolvers.register
          type: qtype
          # no need for the region parameter here
          template: "/#{ qtype }/{name}/{namespace}/{tld}"
          apply: apply qtype
          describe: describe

      when "regional"

        # regional can take both unqualified and qualified types
        # because regional is the default...
        # ex: s3:domain == s3:regional:domain

        Resolvers.register
          type: qtype
          template: "/#{ qtype }/{name}/{namespace}/{tld}/{region?}"
          apply: apply qtype
          describe: describe

        Resolvers.register
          type: type
          template: "/#{ type }/{name}/{namespace}/{tld}/{region?}"
          apply: apply type
          describe: describe

