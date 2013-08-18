class Product < ActiveRecord::Base
  attr_accessible :brand, :brand_id, :buy_url, :category, :img_url, :name, :product_id

 def self.create_product(product,brand)
    @pdt = Product.new
    @pdt.product_id = product.id
    @pdt.img_url = "https://api.svpply.com/v1/products/#{product.id}/image"
    @pdt.buy_url = product.url
    @pdt.brand = brand
    @pdt.name = product.title
    @pdt.save!
  end

end
