require 'csv'

task :import => :environment do
  CSV.foreach(File.join(Rails.root, 'app', 'assets', 'upload_stuff', 'file.csv')) do |row|
    product = Product.create!(kind: row[0], name: row[1])
    next if row[2].nil? or row[2].empty?
    images = row[2].split(" + ").map do |image|
      image_id = Cloudinary::Uploader.upload(File.join(Rails.root, 'app', 'assets', 'upload_stuff', 'images', "#{image}.jpg"))['public_id']
      Image.create!(cloudinary_ref: image_id, product_id: product.id)
    end
  end

end