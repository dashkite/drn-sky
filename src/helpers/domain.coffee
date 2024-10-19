import LocalAddress from "./local-address"

$mode = process.env.mode ? "development"

Subdomain =

  from: ({ name }) ->
    address = if $mode == "development"
      await LocalAddress.get()
    else
      $mode
    if name?
      "#{name}-#{address}"
    else
      address

Domain =

  from: ({ name, namespace, tld }) ->    
    if $mode == "production"
      if name?
        "#{ name }.#{ namespace }.#{tld}"
      else
        "#{ namespace }.#{ tld }"
    else
      subdomain = await Subdomain.from { name }
      "#{ subdomain }.#{ namespace }.#{ tld }"

export { Domain, Subdomain }
export default Domain