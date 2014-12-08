class @Checkout

  constructor: (purchaseTotal, purchasePricePath) ->
    @setUpVoucher(purchaseTotal, purchasePricePath)
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

  setUpVoucher: (purchaseTotal, purchasePricePath) ->
    $("#purchase_voucher_code").focusout (event) ->
      $.ajax
        dataType: "json"
        url: purchasePricePath
        data:
          voucher_code: @value
          country: $("#purchase_country").val()
          total_price: purchaseTotal

        success: (result) ->
          $(".js-total-price").html result["total_price_in_dollars"]
          $(".js-voucher-discount").html result["voucher_price_in_dollars"]
          $(".js-delivery-price").html result["delivery_price_in_dollars"]
          if result["valid_voucher"] is true
            bootbox.alert "Notice: Your voucher has been applied."
          else
            bootbox.alert "Notice: The voucher code you have entered is invalid. No discount will be applied."

