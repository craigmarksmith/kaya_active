class @Basket
  constructor: (basketValuePath) ->
    @setupDeliverySelect(basketValuePath)

  setupDeliverySelect: (basketValuePath) ->
    $('.js-delivery-select').on 'change', ->
      $.ajax
        dataType: "json"
        url: basketValuePath
        data:
          country: @value

        success: (result) ->
          $(".js-total-price").html result["total_price_in_dollars"]
