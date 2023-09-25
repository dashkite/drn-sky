import LocalAddress from "./local-address"

$mode = process.env.mode ? "development"

Subdomain =

  from: ({ name }) ->
    if $mode == "production"
      name
    else 
      address = if $mode == "development"
        await LocalAddress.get()
      else $mode
      if name == ""
        address
      else
        "#{name}-#{address}"

Domain =

  from: ({ namespace, name, tld }) ->
    switch name
      when ""
        if $mode == "production"
          "#{namespace}.#{tld}"
        else
          subdomain = await Subdomain.from { name }
          "#{subdomain}.#{namespace}.#{tld}"
      when "*"
        "*.#{namespace}.#{tld}"
      else
        subdomain = await Subdomain.from { name }
        "#{subdomain}.#{namespace}.#{tld}"

export { Domain, Subdomain }
export default Domain