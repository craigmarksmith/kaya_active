class Basket

  attr_accessor :line_items, :voucher_code

  def initialize(session)
    @session = session
    if @session[:products]
      @line_items = @session[:products].map{|data| BasketLineItem.new(data['product_slug'], data['size'], data['qty'])}
    else
      @session[:products] = []
      @line_items = []
    end
    @voucher_code = @session[:voucher_code] || nil
  end

  def clear!
    @session[:products] = []
    @session[:voucher_code] = nil
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

  def remove(product_slug, size)
    @line_items.delete_if do |li|
      if size.empty?
        li.product_slug == product_slug
      else
        li.product_slug == product_slug && li.size == size
      end
    end
    @session[:products] = @line_items.map{|item| item.to_hash}
  end

  def voucher_code=(code)
    @voucher_code = code
    @session[:voucher_code] = code
  end

  def voucher
    voucher = Voucher.find_by_code(@voucher_code)
  end

  def voucher_discount_amount
    return 0.00 unless voucher
    voucher.fixed_discount_amount_in_cent
  end

  def voucher_discount_in_dollars
    return 0.00 unless voucher
    voucher.discount_in_dollars
  end

  def total_in_dollars
    total/100.00
  end

  def total
    amount = line_items.inject(0) do |sum, item|
      sum += item.total_in_cents
      sum
    end
    amount - voucher_discount_amount
  end

  def count
    line_items.inject(0) do |sum, item|
      sum += item.qty
      sum
    end
  end

end