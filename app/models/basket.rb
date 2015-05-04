class Basket

  def initialize(session)
    @session = session
    if @session[:products]
      @line_items = @session[:products].map{|data| BasketLineItem.new(data['product_slug'], data['size'], data['qty'])}
    else
      @session[:products] = []
      @line_items = []
    end
  end

  def add(product_slug, size)
    if current_item = @line_items.select{|line| line.product_slug == product_slug and line.size == size}.first
      item = current_item
      item.plus(1)
    else
      @line_items << BasketLineItem.new(product_slug, size, 1)
    end
    @session[:products] = @line_items.map{|item| item.to_hash}
  end

  #don't think I need this
  def line_items
    @line_items
  end

  def voucher
  end

  def total_in_dollars
    total/100.00
  end

  def total
    line_items.inject(0) do |sum, item|
      sum += item.product.price
      sum
    end
  end

end