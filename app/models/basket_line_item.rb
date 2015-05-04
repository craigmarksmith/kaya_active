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

  def to_hash
    {product_slug: @product_slug, size: @size, qty: @qty}
  end

end