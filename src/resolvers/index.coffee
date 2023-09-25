# register resolvers in order of precedence
#
# the only thing that really matters is that the default
# resolver goes last since it's the fallback
#

import "./domain"
import "./s3"
import "./graphene"
import "./default"