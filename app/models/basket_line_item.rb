class BasketLineItem

  attr_reader :product_slug, :size, :qty

  def initialize(product_slug, size, qty)
    @product_slug = product_slug
    @size = size
    @qty = qty
  end

  def product
    @product ||= Product.where(slug: @product_slug).first
  end

  def plus(qty)
    @qty += qty
  end

  def total_in_cents
    product.price * @qty
  end

  def total_in_dollars
    (total_in_cents)/100
  end

  def to_hash
    {product_slug: @product_slug, size: @size, qty: @qty}
  end

  def to_line_item
    LineItem.new(price: product.price, product_id: product.id, qty: @qty, size: @size)
  end

end
