RJS.installPrototypes()

# assert the top-level namespace and add client-side namespaces
if typeof client is undefined
  console.error "Expected the client namespace to be defined. This should be boostrapped from the server."

$ ->
  
  # make sure the bootstrapped view matches a client-side jade view
  if not client.view of jade.templates
    console.error "Invalid view: '{0}'. This value must exactly match the name of a view function stored on jade.templates.".supplant [client.view]
  
  # render the view
  jade.render(document.body, client.view, client.data)
