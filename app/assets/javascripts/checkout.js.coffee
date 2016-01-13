class @Checkout

  constructor: (purchaseTotal, purchasePricePath) ->
    @setUpCountry(purchaseTotal, purchasePricePath)

  setUpCountry: (purchaseTotal, purchasePricePath) ->
    $("#purchase_country").change (event) ->
      klass = this
      $.ajax
        dataType: "json"
        url: purchasePricePath
        data:
          country: @value
          total_price: purchaseTotal
          voucher_code: $("#purchase_voucher_code").val()

        success: (result) ->
          $(".js-total-price").html result["total_price_in_dollars"]
          $(".js-delivery-price").html result["delivery_price_in_dollars"]
          bootbox.alert "Notice: Delivery price and total price have been updated."

