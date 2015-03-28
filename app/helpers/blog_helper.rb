require 'erb'
module BlogHelper
  def markdown_format(text)
    Kramdown::Document.new(text).to_html
  end

  def erb_compile(text)
    ERB.new(text).result(binding)
  end

  def youtube_tag(id)
    content_tag(:div, class:"embed-responsive embed-responsive-16by9") do
      content_tag(:iframe, {}, src:"//www.youtube.com/embed/#{id}", class: "embed-responsive-item", allowfullscreen: true)
    end
  end

  def blog_image(filename)
    image_tag("blog/#{filename}", class: "img-responsive center-block")
  end

  def related_products(product_slugs)
    render partial: 'shared/product_list', locals: {products: Product.where("slug IN (?)", product_slugs)}
  end
end