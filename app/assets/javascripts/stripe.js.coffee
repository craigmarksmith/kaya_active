stripeResponseHandler = (status, response) ->
  $form = $("#new_purchase")
  if response.error

    # Show the errors on the form
    $form.find(".payment-errors").text response.error.message
    $form.find(".js-stripe-error").show()
    $form.find("button").prop "disabled", false
  else

    # response contains id and card, which contains additional card details
    token = response.id

    # Insert the token into the form so it gets submitted to the server
    $form.append $("<input type=\"hidden\" name=\"purchase[stripe_token]\" />").val(token)

    # and submit
    $form.get(0).submit()

jQuery ($) ->
  $("#new_purchase").submit (event) ->
    $form = $(this)
    $form.find("button").prop "disabled", true
    Stripe.card.createToken $form, stripeResponseHandler
    false
