DRN =

  fromPath: ( path ) -> "drn:#{ path[1..] }"

  toPath: ( uri ) -> uri.replace /^drn:/, "/"

export { DRN }
export default DRN