class @Basket
  constructor: (basketValuePath) ->
    @setupDeliverySelect(basketValuePath)
    @setUpVoucher(basketValuePath)

  setupDeliverySelect: (basketValuePath) ->
    $('.js-delivery-select').on 'change', ->
      $.ajax
        dataType: "json"
        url: basketValuePath
        data:
          country: @value

        success: (result) ->
          $(".js-total-price").html result["total_price_in_dollars"]

  setUpVoucher: (basketValuePath) ->
    $(".js-voucher-code").focusout (event) ->
      if !!@value
        $.ajax
          dataType: "json"
          url: basketValuePath
          data:
            voucher_code: @value
            country: $(".js-delivery-select").val()

          success: (result) ->
            $(".js-total-price").html result["total_price_in_dollars"]
            $(".js-voucher-discount").html result["voucher_price_in_dollars"]


